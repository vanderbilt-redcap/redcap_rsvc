Feature: User Interface: The system shall ignore survey identifier and timestamp fields on all data import spreadsheets and allow all other data to be imported.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.0600.100 Import ignores survey identifier and timestamp fields

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.0600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "B.3.16.600Project.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Data Import Tool"

        Given I upload a "csv" format file located at "import_files/B.3.16.600_DataImport.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "DATA DISPLAY TABLE"
        And I should see a table header and rows containing the following values in the import data display table:
            | record_id | redcap_survey_identifier | data_types_timestamp | ptname    |
            | 4         | Joe                      | 2023-08-18 12:53        | My Name   |
            | 5         | Jane                     | 2023-08-18 12:54        | Your Name |
            | 6         | John                     | 2023-08-18 12:54        | That name |

        Given I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        When I click on the link labeled "Data Exports, Reports, and Stats"
        And I click on the button labeled "View Report" in the row labeled "All data (all records and fields)"

        ###VERIFY_DE
        Then I should see "All data (all records and fields)"
        Given I should see a table header and rows containing the following values in the report data table:
            | record_id | redcap_survey_identifier | data_types_timestamp | ptname    |
            | 4         |                          |                      | My Name   |
            | 5         |                          |                      | Your Name |
            | 6         |                          |                      | That name |
#Manual: new records were imported and survey timestamp fields and identifier fields are ignored
#End