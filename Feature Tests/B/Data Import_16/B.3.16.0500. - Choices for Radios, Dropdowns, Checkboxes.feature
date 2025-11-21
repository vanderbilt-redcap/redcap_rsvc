Feature: User Interface: The system shall import only valid choice codes for radio buttons, dropdowns, and checkboxes.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.0500.100 Import valid choice codes fields

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.0500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.500_DataImport_Rows.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "The data you uploaded from the file is displayed in the Data Display Table below"

        When I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION:  incorrect format
        When I upload a "csv" format file located at "import_files/B.3.16.500_DataImport_Rows Bad.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "Errors were detected in the import file that prevented it from being loaded"

        And I should see a table header and rows containing the following values in a table:
            | Record | Field Name               | Value |
            | 300    | multiple_dropdown_auto   | 99    |
            | 300    | multiple_dropdown_manual | 99    |
            | 300    | multiple_radio_auto      | 99    |
            | 300    | radio_button_manual      | 222   |
            | 300    | checkbox___1             | 99    |


        #FUNCTIONAL_REQUIREMENT
        ##ACTION:  corrected format
        When I upload a "csv" format file located at "import_files/B.3.16.500_DataImport_Rows Corrected.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see a table header and rows containing the following values in a table:
            | record_id | multiple_dropdown_auto | multiple_dropdown_manual | multiple_radio_auto | radio_button_manual | checkbox___1 |
            | 300       | 3                      | 5                        | 2                   | 101                 | 0            |

        When I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see table header and rows containing the following values in the logging table:
            | Username   | Action                 | List of Data Changes OR Fields Exported |
            | test_admin | Update record (import) | multiple_dropdown_auto = '3'            |
            | test_admin | Update record (import) | multiple_dropdown_manual = '5'          |
            | test_admin | Update record (import) | multiple_radio_auto = '2'               |
            | test_admin | Update record (import) | radio_button_manual = '101'             |
            | test_admin | Update record (import) | checkbox(1) = unchecked                 |
#End