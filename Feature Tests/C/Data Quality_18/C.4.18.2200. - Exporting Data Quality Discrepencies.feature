Feature: C.4.18.2200. User Interface: The system shall support exporting Data Quality discrepancy results.

    As a REDCap project user
    I want to export Data Quality discrepancy results
    So that I can review them outside of REDCap

    Scenario: C.4.18.2200.100 Export Data Quality discrepancy results
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.2200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Project status:  Production"

        #FUNCTIONAL_REQUIREMENT: Run Data Quality and export discrepancy results
        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "C"
        Then I should see "Rule: Field validation errors (incorrect data type)"
        And I should see "Discrepancies found: 1"
        And I should see "email = HelloWorld"
        And I click on the button labeled "Export results (CSV)"
        Then I should see "SUCCESS! The data quality results were successfully downloaded."
        And the downloaded CSV with filename "C4182200100_DataQualityDiscrepancies_FieldValidationErrorsIncorrect_yyyy-mm-dd.csv" has the header and rows below
            | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | result-status    | result-is-excluded | email      |
            | 6         | event_1_arm_1     |                           |                          |                           | Validation error | No                 | HelloWorld |

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Download data quality results           |

        And I logout

#END