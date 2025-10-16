Feature: User Interface: The system shall support data quality rule creation.

  As a REDCap end user
  I want to see that Data Quality Module is functioning as expected

  Scenario: C.4.18.0200.100 Data quality rule creation
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.4.18.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see Project status: "Production"

    #FUNCTIONAL_REQUIREMENT
    ##REDUNDANT C.4.18.1100 Data quality rule creation for longitudinal projects
    ##ACTION: Manual rule add
    When I click on the link labeled "Data Quality"
    Then I should see "Data Quality Rules"

    When I enter "Integer" into the textarea field labeled "Enter descriptive name for new rule"
    And I click on "" in the textarea field labeled "Enter logic for new rule"
    And I wait for 2 seconds
    And I clear field and enter "[event_1_arm_1][integer]='1999'" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Add" on the active Data Quality rule
    ##VERIFY
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name | Rule Logic  (Show discrepancy only if...) |
      | 3      | Integer   | [event_1_arm_1][integer]='1999'          |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Upload rule
    And I click on the button labeled "Upload or download Data Quality Rules"
    And I click on the link labeled "Upload Data Quality Rule (CSV)"
    And I upload a "csv" format file located at "import_files/C418100TEST_DataQualityRules_Upload.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Upload Data Quality Rule (CSV) - Confirm" in the dialog box

    When I click on the button labeled "Upload" in the dialog box
    Then I should see "SUCCESS!"

    When I click on the button labeled "Close" in the dialog box
    Then I should see "Data Quality Rules"
    ##VERIFY
    And I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name | Rule Logic  (Show discrepancy only if...) |
      | 4      | Integer   | [integer]<>'1999'                        |

    ##ACTION: create record for new rule
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 11"

    When I enter "1999" into the data entry form field labeled "Integer"
    And I click on the button labeled "Close" in the dialog box
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 11 successfully added."

    ##ACTION: create record for uploaded new rule
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 12."

    When I enter "2000" into the data entry form field labeled "Integer"
    And I click on the button labeled "Close" in the dialog box
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 12 successfully added."

    #VERIFY
    When I click on the link labeled "Data Quality"
    And I click on the button labeled exactly "All"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name | Rule Logic  (Show discrepancy only if...) |
      | 3      | Integer   | [event_1_arm_1][integer]='1999'          |
      | 4      | Integer   | [integer]<>'1999'                        |
        
    ##ACTION: edit existing rule for longitudinal projects
    When I click the element containing the following text: "[event_1_arm_1][integer]='1999'"
    And I wait for 2 seconds
    And I clear field and enter "[event_1_arm_1][integer]='1'" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Save" on the active Data Quality rule
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name | Rule Logic  (Show discrepancy only if...) |
      | 3      | Integer   | [event_1_arm_1][integer]='1'             |
            
    ##ACTION: edit existing rule
    When I click the element containing the following text: "[integer]<>'1999'"
    And I clear field and enter "[integer]='2'" in the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Save" on the active Data Quality rule

    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name | Rule Logic  (Show discrepancy only if...) |
      | 4      | Integer   | [integer]='2'                            |
    #Manual: refresh browser page

    #VERIFY
    When I click on the link labeled "Data Quality"
    And I click on the button labeled exactly "All"
    And I should see "Processing Complete!"
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name | Rule Logic  (Show discrepancy only if...) |
      | 3      | Integer   | [event_1_arm_1][integer]='1'             |
      | 4      | Integer   | [integer]='2'                            |

    ##ACTION: delete rule
    When I click on the Delete icon for Data Quality Rule # "4"
    #Manual: confirmation windows are automatically accepted on automated side
    And I click on the button labeled "Delete" in the dialog box
    Then I should see a table header and rows containing the following values in a table:
      | Rule # | Rule Name | Rule Logic  (Show discrepancy only if...) |
      | 3      | Integer   | [event_1_arm_1][integer]='1'             |
    And I should NOT see "[integer]='2'"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | test_admin | Manage/Design | Delete data quality rule               |
      | test_admin | Manage/Design | Execute data quality rule: Rule 4      |
      | test_admin | Manage/Design | Execute data quality rule: Rule 3      |
      | test_admin | Manage/Design | Execute data quality rule: Rule 2      |
      | test_admin | Manage/Design | Execute data quality rule: Rule 1      |
      | test_admin | Manage/Design | Execute data quality rule: Rule H      |
      | test_admin | Manage/Design | Execute data quality rule: Rule I      |
      | test_admin | Manage/Design | Execute data quality rule: Rule F      |
      | test_admin | Manage/Design | Execute data quality rule: Rule G      |
      | test_admin | Manage/Design | Execute data quality rule: Rule E      |
      | test_admin | Manage/Design | Execute data quality rule: Rule B      |
      | test_admin | Manage/Design | Execute data quality rule: Rule D      |
      | test_admin | Manage/Design | Execute data quality rule: Rule C      |
      | test_admin | Manage/Design | Execute data quality rule: Rule A      |
      | test_admin | Manage/Design | Edit data quality rule                 |
      | test_admin | Manage/Design | Upload Data Quality Rules              |
      | test_admin | Manage/Design | Create data quality rule               |
#END