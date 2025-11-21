Feature: Field Creation: The system shall support the creation of Descriptive Text (with optional Image/File Attachment.


    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.1500.100 Creation of Descriptive field through the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.1500.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.1500.100"

        ##SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Signature field creation
        Given I click on the link labeled "Form 1"
        And I click on the Add Field input button below the field named "Record ID"

        When I select "Descriptive Text (with optional Image/Video/Audio/File Attachment)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Descriptive Text with File" into the Field Label of the open "Add New Field" dialog box
        And I enter "descriptive_text_file" into the Variable Name of the open "Add New Field" dialog box
        Then I should see a link labeled "Upload file"

        Given I click on the link labeled "Upload file"
        And I see a dialog containing the following text: "Attach an image, file, or embedded audio"
        When I upload a "docx" format file located at "import_files/B.6.7.1500_Upload File.docx", by clicking the button near "Select a file then click the 'Upload File' button" to browse for the file, and clicking the button labeled "Upload file" to upload the file
        Then I should see "Document was successfully uploaded!"
        And I click on the button labeled "Close"
        And I click on the button labeled "Save"

        ##VERIFY
        Then I should see the field labeled "Descriptive Text with File"
        And I should see the link labeled "B.6.7.1500_Upload File"

        ##SETUP_PRODUCTION
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close" in the dialog box

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name   | Field Label                | Field Attributes |
            | [descriptive_text_file] | Descriptive Text with File | descriptive      |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Create project field                    |

        ##ACTION: Download file from descriptive field
        Given I click on the link labeled "Add / Edit Records"
        When I click on the button labeled "Add new record"
        Then I should see the field labeled "Descriptive Text with File"
        And I should see "Attachment:"
        And I should see a link labeled "B.6.7.1500_Upload File"

        When I download a file by clicking on the link labeled "B.6.7.1500_Upload File"
        ##VERIFY
        Then I should see a downloaded file named "B.6.7.1500_Upload File.docx"

    Scenario: B.6.7.1500.200 Creation of Descriptive field through Data Dictionary upload

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.1500.200" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.1500.200"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Upload data dictionary
        When I click on the link labeled "Dictionary"
        And I upload a "csv" format file located at "dictionaries/Project1xml_DataDictionary.csv", by clicking the button near "Choose File" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "Your document was uploaded successfully and awaits your confirmation below."

        When I click on the button labeled "Commit Changes"
        Then I should see "Changes Made Successfully!"

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name   | Field Label                | Field Attributes |
            | [descriptive_text_file] | Descriptive Text with File | descriptive      |
#END