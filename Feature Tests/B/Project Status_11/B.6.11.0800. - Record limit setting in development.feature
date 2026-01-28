Feature: B.6.11.0800. User Interface: The system shall allow setting a record limit for data collection (forms, surveys, import) when the project is in development status.
    
    As a REDCap end user
    I want to see that My Project is functioning as expected

    Scenario: #SETUP
        #Setup global limit in control center to 0
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "General Configuration"
        Then I should see "Record Limit:"
        And I enter "0" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"
        #Setup create project
        When I create a new project named "B.6.11.0800" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

        #Setup add survey settings
        When I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"
        And I click on the link labeled "Survey Distribution Tools"
        And I click on the link labeled "Public Survey Link"
        And I click on the button labeled "Enable public survey"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"

    Scenario: B.6.11.0800.0100. - The UI must expose a record limit setting for development-mode projects
        When I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"
        And I click on the link labeled "Edit Project Settings"
        Then I should see "Record Limit:"
        And I enter "5" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
        And I click on the button labeled "Save Changes"
        Then I should see "Your changes have been saved!"
        
        When I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"
        And I click on the link labeled "Add / Edit Records"
        Then I should see "You are currently using 4 of 5 test records allowed while in Development status"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        Then I should see "Record ID 5 successfully added"

        ##VERIFY_LOG:
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin | Create record5 | record_id = '5'   |


    Scenario: B.6.11.0800.0200. - If limit is set (e.g., 3), a 4th record attempt via any method (form, survey, import) must be blocked    
        When I click on the link labeled "Add / Edit Records"
        Then I should see "You are currently using 5 of 5 test records allowed while in Development status"
        And I should see "NOTICE: No new records can be created since this project has already met the limit of 5 records while in Development status."
        And I should NOT see the button labeled "Add new record for the arm selected above"

        #Validation that another records can not be added via survey
        When I click on the link labeled "Survey Distribution Tools"
        And I click on the button labeled "Open public survey"
        Then I should see "no new responses can be added to the survey at this time."
        And I should see "project has already reached the maximum limit of records while in Development status. The survey administrator may want to contact their REDCap administrator if they have any questions about this."
        And I click on the button labeled "Close survey"
        And I return to the REDCap page I opened the survey from

        #Validation that another records can not be added via data import
        When I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.1000_New Record.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "NOTICE: No new records can be created since this project has already met the limit of 5 records while in Development status. If you have questions regarding this, please contact your REDCap Administrator."


    Scenario: B.6.11.0800.0300. - If survey limit is different from general limit, both must be enforced independently
        #SETUP record survey limit
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"
        And I click on the link labeled "Designer"
        And I click on the button labeled "Survey settings" in the row labeled "Text Validation"
        And I enter "1" into the input field labeled "Response Limit (optional)"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"
        #SETUP project level max record limit 
        When I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"
        And I click on the link labeled "Edit Project Settings"
        And I enter "2" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
        And I click on the button labeled "Save Changes"
        Then I should see "Your changes have been saved!"
        #SETUP erase all data
        When I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"      
        And I click on the link labeled "Other Functionality"
        And I click on the button labeled "Erase all data"
        Then I should see "Are you sure you wish to erase all the data in this project?"
        When I click on the button labeled "Erase all data"
        Then I should see "All data has now been deleted from the project!"
        And I click on the button labeled "Close"
        #Action: Adding survey response #1
        When I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"
        And I click on the link labeled "Survey Distribution Tools"
        And I click on the button labeled "Open public survey"
        Then I should see "Please complete the survey below."
        When I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."
        And I click on the button labeled "Close survey"
        And I return to the REDCap page I opened the survey from
        Then I should see "Link Actions"
        #Action: Adding survey response #2 to ensure its blocked.
        When I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"
        When I click on the link labeled "Survey Distribution Tools"
        Then I should see "Link Actions"
        When I click on the button labeled "Open public survey"
        #Verify
        Then I should see "Thank you for your interest; however, the survey is closed because the maximum number of responses has been reached."
        And I click on the button labeled "Close survey"
        And I return to the REDCap page I opened the survey from
        
        #Action: Adding record 2 via data entry
        Given I click on the link labeled "My Projects"
        Then I should see "Listed below are the REDCap project"
        When I click on the link labeled "B.6.11.0800"
        And I click on the link labeled "Add / Edit Records"
        Then I should see "You are currently using 1 of 2 test records allowed while in Development status"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        Then I should see "Record ID 2 successfully added"

        ##VERIFY_LOG:
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin | Create record2 | record_id = '2'   |

        When I click on the link labeled "Add / Edit Records"
        Then I should see "You are currently using 2 of 2 test records allowed while in Development status"
        And I should see "NOTICE: No new records can be created since this project has already met the limit of 2 records while in Development status."
        And I should NOT see the button labeled "Add new record for the arm selected above"

#END