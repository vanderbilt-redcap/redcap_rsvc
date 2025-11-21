Feature: User Interface: The system shall provide the ability to require a reason when modifying records via real-time data import

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.2000.100 reason when modifying records via real-time data import

        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.2000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #SETUP DRW
        When I click on the button labeled "Additional customizations"
        And I check the checkbox labeled "Require a 'reason' when making changes to existing records?"
        And I click on the button labeled "Save"

        #FUNCTIONAL REQUIREMENT
        ##ACTION
        When I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.2000.100data.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "The data you uploaded from the file is displayed in the Data Display Table below"
        Then I should see "Please supply a reason for the data changes for EACH existing record in the text boxes"

        And I enter "because I said so" into the first textarea field labeled "Copy to all"
        And I click on the first link labeled "Copy to all"
        And I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        #VERIFY
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported | Reason for Data Change |
            | test_admin | Update record | [instance = 3]                          | because I said so      |
#END