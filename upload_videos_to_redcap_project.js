#!/usr/bin/env node
const fs = require('fs')
const { execSync } = require('child_process')
const { promisify } = require('util')
const path = require('path')
const readdir = promisify(fs.readdir)
const stat = promisify(fs.stat)

/**
 * This tool fetches the results of the latest cloud run
 * Facilitates uploading the video results to REDCap project via REDCap API
 * Videos push to the File Repo when a feature has been marked as passed
 */
class UploadVideosToREDCapProject {
    constructor() {
        const redcap_api_token = process.argv[2]
        if(!redcap_api_token){
            console.log('No REDCap API token found.')
            return
        }

        const project_id = process.argv[3]
        if(!project_id){
            console.log('No Project ID found.')
            return
        }

        this.redcap_api_url = process.argv[4]
        if(!this.redcap_api_url){
            console.log('No REDCap API URL found.')
            return
        }

        if(this.redcap_api_url.includes('redcap.loc')){
            // This is local environment.  Do not check the cert.
            process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";
        }

        this.cypress_cloud_query(
            {
                variables: {
                    projectId: project_id
                },
                query: `query GetLatestRun($projectId: String!) {
                            project(id: $projectId) {
                                runs {
                                    nodes {
                                        id
                                    }
                                }
                            }
                        }`
            },
        ).then((response) => {
            this.cypress_cloud_query({
                variables: {
                    input: {
                        runId: response.data.project.runs.nodes[0].id, //This is the first result returned from above
                    }
                },
                query: `query RunTestResults($input: TestResultsTableInput!) {
                          testResults(input: $input) {
                            __typename
                            ... on RunInstance {
                              status
                              spec {
                                path
                              }
                            }
                          }
                        }`
            }).then((response) => {

                const passed_features = []
                response.data.testResults.forEach((feature) => {
                    if (feature.__typename !== 'RunInstance') {
                        return
                    }

                    //If feature passed, upload to REDCap VUMC
                    if(feature.status === "PASSED"){
                        passed_features.push({
                            feature_path: feature.spec.path,
                            video_path: `${feature.spec.path.replace(/redcap_rsvc\/Feature Tests/g, '/home/circleci/project/coverage/cypress/videos')}.mp4`,
                        })
                    }
                })

                //Get the Folder ID
                this.redcap_project_query(new URLSearchParams({
                    token: redcap_api_token, // Replace with actual token if not using environment variables
                    content: 'fileRepository',
                    action: 'list',
                    format: 'json',
                    returnFormat: 'json'
                })).then((response) => {

                    return new Promise((resolve, reject) => {
                        const folder = response.find(r => r.name === "Automated Videos");

                        if (folder) {
                            resolve(folder.folder_id)
                        } else {
                            reject('Automated Videos folder not found');
                        }
                    })

                }).then(async (folder_id) => {
                    let dataToSave = []

                    this.redcap_project_query(new URLSearchParams({
                        token: redcap_api_token, // Replace with actual token if not using environment variables
                        content: 'fileRepository',
                        action: 'list',
                        folder_id: folder_id,
                        format: 'json',
                        returnFormat: 'json'
                    })).then((uploaded_feature_videos) =>{

                        //For each passed feature, let's upload if there isn't already a file
                        for(const passed_feature of passed_features){
                            const feature = passed_feature.video_path
                            const path = feature.split('/')
                            const filename = path[path.length - 1]
                            const file_path = feature

                            //This means we already have uploaded it
                            if(uploaded_feature_videos.find(r => r.name === filename)){
                                console.log(`ALREADY UPLOADED: ${filename}`)
                                //This means we should upload it
                            } else {
                                console.log(`NEW UPLOAD: ${filename}`)
                                console.log(`FILE PATH: ${feature}`)

                                const feature_content = fs.readFileSync('../' + passed_feature.feature_path, 'utf8')
                                dataToSave.push({
                                    record_id: filename.split(' ')[0],
                                    feature_test_script: feature_content,
                                    projects_feature: this.get_referenced_files(feature_content)
                                })

                                fs.access(file_path, fs.constants.F_OK, (err) => {
                                    if (err) {
                                        console.error(`File does not exist at path: ${file_path}`)
                                        return
                                    }

                                    //Run the import of video to REDCAP VUMC
                                    const output = execSync(`bash import_video.sh "${file_path}" "${filename}" ${folder_id}`, { encoding: 'utf8' })
                                    console.log(output)
                                })

                            }

                        }
                    }).then(() => {
                        this.redcap_project_query(new URLSearchParams({
                            token: redcap_api_token, // Replace with actual token if not using environment variables
                            content: 'record',
                            action: 'import',
                            format: 'json',
                            returnFormat: 'json',
                            overwriteBehavior: 'overwrite',
                            data: JSON.stringify(dataToSave, null, 2),
                        })) .then(json => {
                            if(json.count !== dataToSave.length){
                                throw `Expected to save ${dataToSave.length} records but received a count of ${json.count} instead`
                            }

                            console.log(`Updated ${json.count} REDCap records`)
                        })
                    })
                })
            })
        })
    }

    cypress_cloud_query(payload) {
        return fetch("https://cloud.cypress.io/graphql", {
            method: "POST",
            body: JSON.stringify(payload),
            headers: {
                "Content-type": "application/json; charset=UTF-8"
            }
        }).then((response) => response.json())
    }

    redcap_project_query(payload, headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
    }) {
        return  fetch(this.redcap_api_url, {
            method: 'POST',
            headers: headers,
            body: payload
        }).then(response => response.json())  // Parse the JSON response
        .then(json => {
            if(json.error){
                throw 'An error occured during the REDCap API call: ' + json.error
            }

            return json
        })
    }

    // This function was copied from the redcap-functional-requirements External Module
    get_referenced_files(featureContent) {
        const ignoredPhrases = [
            'Scenario:',
            'should see',
            'should NOT see',
            'into the input field',
            'the downloaded CSV with filename',
            'icon for the File Repository file named',
            'I download a file',
            'I check the checkbox',
            'I click on the link labeled "consent.pdf"',
        ]

        const lines = featureContent.split("\n")
        let referencedFiles = {} // Use an object to automatically collapse duplicates
        forEachLine: for (let lineIndex in lines){
            let line = lines[lineIndex].trim()

            for (const phrase of ignoredPhrases){
                if(line.includes(phrase)){
                    continue forEachLine
                }
            }

            if(line.includes('upload the following file')){
                while(true){
                    lineIndex++
                    const matches = [...lines[lineIndex].matchAll(/\|(.*)\|/g)]
                    if(matches.length === 0){
                        continue forEachLine
                    }

                    for (const match of matches) {
                        const filename = match[1].trim()
                        referencedFiles[filename] = true
                    }
                }
            }

            const matches = line.matchAll(/["']([^"'@]*\.[A-z][A-z][A-z][A-z]?)["']/g)
            for (const match of matches) {
                const filename = match[1]
                const extension = filename.split('.').pop()

                if([
                    'DEV',
                    'PROD',
                    'copy',
                    'php',
                ].includes(extension)){
                    continue
                }

                referencedFiles[filename] = true
            }
        }

        return Object.keys(referencedFiles).join("\n")
    }

    async get_filenames_recursively(dir) {
        const subdirs = await readdir(dir)
        const files = await Promise.all(subdirs.map(async (subdir) => {
            const res = path.resolve(dir, subdir)
            return (await stat(res)).isDirectory() ? this.get_filenames_recursively(res) : res.replaceAll('\\', '/')
        }))

        return files.reduce((a, f) => a.concat(f), [])
    }
}

new UploadVideosToREDCapProject()