Feature: C.4.18.2400. User Interface: The system shall restrict deletion of files uploaded to data queries within the Data Resolution Workflow (DRW) to authorized administrative users.

    As a REDCap administrator
    I want to see that only REDCap administrators are able to delete attachments from data queries
    So that query documentation is protected and deletions are recorded in the project log

    Scenario: C.4.18.2400.100 A non-administrator cannot delete their own query attachment despite having full project-level DRW privileges
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.2400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        When I click on the button labeled "Additional customizations"
        And I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
        And I click on the button labeled "Save"
        And I click on the button labeled "Close"
        And I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"

        When I check the radio labeled "Open, close, and respond to queries"
        And I click on the button labeled "Add user"
        Then I should see "test_user1"
        And I logout

        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.4.18.2400.100"
        And I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        And I click on the icon labeled "View data resolution workflow" in the row labeled "Text2"
        And I click on the radio labeled "Open query"
        And I select "Test_User1 (Test User1)" on the dropdown field labeled "Assign query to a user (optional):"
        And I enter "Please review this value" into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 1 successfully edited."
        
        When I click on the link labeled "Resolve Issues"
        And I click on the button labeled "1 comment" in the row labeled "Text2" 
        And I click on the link labeled "Upload file"
        And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Select a file then click the 'Upload File' button" to browse for the file
        And I click on the button labeled "Upload document"
        Then I should see "Document was successfully uploaded"

        When I click on the button labeled "Close"
        And I select "Corrected - Typographical error" on the dropdown field labeled "Reply with response:"
        And I enter "Reviewed documentation attached" into the textarea field labeled "Comment"
        And I click on the button labeled "Respond to query"
        Then I should see "2 comments"

        When I click on the link labeled "Resolve Issues"
        And I click on the button labeled "2 comments" in the row labeled "Text2"
       
        #FUNCTIONAL_REQUIREMENT: Attachment ownership and project-level DRW rights do not authorize deletion
        And I click on the icon labeled "Delete File"   
        Then I should see "ERROR: Only REDCap administrators may delete uploaded files from data queries."
        And I should NOT see "SUCCESS! The attachment was successfully deleted from the data query."
        When I click on the button labeled "Close"
        And I click on the button labeled "Cancel"
        
        And I click on the button labeled "2 comments" in the row labeled "Text2"
        Then I should see "testusers_bulkupload.csv"
        And I should see "Reviewed documentation attached"
        When I click on the button labeled "Cancel"
        And I logout

    Scenario: C.4.18.2400.200 A REDCap administrator can delete a query attachment and the deletion is logged
        #VERIFY: The attachment remains available to the administrator
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.4.18.2400.100"
        And I click on the link labeled "Resolve Issues"
        And I click on the button labeled "2 comments" in the row labeled "Text2"
        Then I should see a link labeled "testusers_bulkupload.csv"

        #FUNCTIONAL_REQUIREMENT: Only an administrator can confirm deletion of the saved attachment
        When I click on the icon labeled "Delete File"
        Then I should see "Are you sure you wish to delete this file from the data query?"
        When I click on the button labeled "Delete"
        Then I should see "SUCCESS! The attachment was successfully deleted from the data query."
        When I click on the button labeled "Close"
        And I click on the link labeled "Resolve Issues"
        And I click on the button labeled "2 comments" in the row labeled "Text2"
        Then I should NOT see a link labeled "testusers_bulkupload.csv"
        And I should see "Reviewed documentation attached"


        #VERIFY_LOG: Identify the deleting administrator and the affected record, event, and field
        When I click on the button labeled "Cancel"
        And I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported                                                                                |
            | test_admin | Manage/Design | Delete uploaded document for data query response (Record: 1, Event: Event 1 (Arm 1: Arm 1), Field: text2)                  |
        And I logout
#END
