Feature: User Interface: The system shall import only valid formats for text fields with validation.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.0400.100 Import valid formats for text fields
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.0400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #VERIFY_RSD: no records exist
        When I click on the link labeled "Record Status Dashboard"
        Then I should see "No records exist yet"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION
        Given I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.400_DataImport_Rows.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "The data you uploaded from the file is displayed in the Data Display Table below"
        And I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        #VERIFY_RSD: 3 records
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 100       |
            | 200       |
            | 300       |

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action                 | List of Data Changes OR Fields Exported |
            | test_admin | Create record (import) | record_id = '100'                       |
            | test_admin | Create record (import) | record_id = '200'                       |
            | test_admin | Create record (import) | record_id = '300'                       |

        #FUNCTIONAL_REQUIREMENT
        ##ACTION
        When I click on the link labeled "Data Import Tool"
        And I select "Yes, blank values in the file will overwrite existing values" on the dropdown field labeled "Overwrite data with blank values?"
        And I click on the button labeled "Yes, I understand" in the dialog box
        And I upload a "csv" format file located at "import_files/B.3.16.400_DataImport_Rows Bad.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "Errors were detected in the import file that prevented it from being loaded."
        And I should see a table header and rows containing the following values in a table:
            | Record | Field Name          | Value         |
            | 300    | email               | ringo@noreply |
            | 300    | bdate               | 0007-40-07    |
            | 300    | multiple_radio_auto | 99            |

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Corrected format

        And I upload a "csv" format file located at "import_files/B.3.16.400_DataImport_Rows Corrected.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see a table header and rows containing the following values in a table:
            | record_id | email             | bdate      | multiple_radio_auto |
            | 300       | ringo@noreply.edu | 1940-07-07 | 2                   |

        When I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        ##VERIFY_LOG
        #verify import log
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action | List of Data Changes OR Fields Exported |
            | test_admin | 300    | email = 'ringo@noreply.edu'             |
            | test_admin | 300    | notesbox = '',                          |
            | test_admin | 300    | multiple_radio_auto = '2'               |
#End
