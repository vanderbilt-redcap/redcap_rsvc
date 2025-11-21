Feature: User Interface:The system shall provide the ability to display real-time process data comparison table

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.1800.100 Data Import real-time process data comparison table
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.1800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "BigDataTestProject.xml", and clicking the "Create Project" button
        
        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        Given I click on the link labeled "Data Import Tool"
        When I select "Import in real time" on the dropdown field labeled "Choose an import option"
        And I select "Yes, display uploaded data prior to importing" on the dropdown field labeled "Display the data comparison table"
        And I upload a "csv" format file located at "import_files/BigDataTestProjectDATA.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "Instructions for Data Review"

        When I click on the button labeled "Import Data"
        Then I should see "Import Successful!"
        And I should see "75"
        And I should see "records were created or modified during the import"

        Given I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in a table:
            | Record ID | Form 1 |
            | 1         |        |
            | 2         |        |
            | 3         |        |
            | 4         |        |
        And I should see the "Unverified" icon for the "Form 1" instrument for record "1"
        And I should see the "Unverified" icon for the "Form 1" instrument for record "50"
        #VERIFY
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username    | Action                   | List of Data Changes OR Fields Exported |
            | test_admin  | Create record 50         | record_id = '50'                        |
#END