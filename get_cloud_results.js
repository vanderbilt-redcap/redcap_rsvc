#!/usr/bin/env node

/**
 * This tool reports the result from the specified cypress cloud build for each feature file in this project.
 * This makes it easy to compare the results between two cloud builds,
 * and also ensures that all features in the project are being run in the cloud.
 */
class Results {
  constructor() {
    const buildNumber = process.argv[2]
    if(!buildNumber){
      console.log('Please specify a cypress cloud build number.')
      return
    }

    this.query(
      {
        "variables":{
          "buildNumber":buildNumber,
          "buildId":buildNumber,
          "projectId":"pvu79o",
          "queryById":false,
        },
        "query":`query RunContainer($buildNumber: ID!, $projectId: String!, $queryById: Boolean!) {
          runByBuildNumber(buildNumber: $buildNumber, projectId: $projectId) @skip(if: $queryById) {
            id
          }
        }`
      },
    )
    .then((response) => {
      this.query({
        "variables":{
          "input":{
            "runId":response.data.runByBuildNumber.id,
          }
        },
        "query":`query RunTestResults($input: TestResultsTableInput!) {
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
      })
      .then((response) => {
        const results = {}
        response.data.testResults.forEach((feature) => {
            if(feature.__typename !== 'RunInstance'){
              return
            }
            
            results[feature.spec.path] = feature.status
        })

        this.handleResults(results)
      })
    })
  }

  query(payload) {
    return fetch("https://cloud.cypress.io/graphql", {
      method: "POST",
      body: JSON.stringify(payload),
      headers: {
        "Content-type": "application/json; charset=UTF-8"
      }
    })
    .then((response) => response.json())
  }

  async handleResults(cloudResults) {
    const combinedResults = {}
    ;(await this.getFiles('Feature Tests')).forEach((path) => {
      if(path.startsWith('Feature Tests/D') || path.includes('REDUNDANT')){
        return  
      }

      let result = cloudResults['redcap_rsvc/' + path]
      if(result === undefined){
        result = 'DID NOT RUN'
      }

      combinedResults[path] = result
    })

    for(let cloudPath in cloudResults){
      let localPath = cloudPath.replace('redcap_rsvc/', '');
      if(combinedResults[localPath] === undefined){
        combinedResults[localPath] = cloudResults[cloudPath]
      }
    }

    Object.keys(combinedResults).sort().forEach(key => {
      console.log(JSON.stringify([key, combinedResults[key]]) + ',')
    })
  }

  async getFiles(dir) {
    const { readdir } = require('fs').promises;
    const dirents = await readdir(dir, { withFileTypes: true });
    const files = await Promise.all(dirents.map((dirent) => {
      const res = dir + '/' + dirent.name
      return dirent.isDirectory() ? this.getFiles(res) : res;
    }));
    return Array.prototype.concat(...files);
  }
}

new Results()
