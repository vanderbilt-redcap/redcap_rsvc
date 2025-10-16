Feature: User Interface: The system shall support viewing discrepancies found in rule execution.

    As a REDCap end user
    I want to see that Data Quality Module is functioning as expected

    Scenario: C.4.18.0500.100 View discrepancies
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.0500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button
        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see Project status: "Production"

        ##ACTION executing all rules.
        When I click on the link labeled "Data Quality"
        And I click on the button labeled exactly "All"
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                                     | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | A      | Blank values*                                 | -                                        | 395                 |
            | B      | Blank values* (required fields only)          | -                                        | 2                   |
            | C      | Field validation errors (incorrect data type) | -                                        | 1                   |
            | D      | Field validation errors (out of range)        | -                                        | 4                   |
            | E      | Outliers for numerical fields                 | -                                        | 2                   |
            | F      | Hidden fields that contain values***          | -                                        | 1                   |
            | G      | Multiple choice fields with invalid values    | -                                        | 1                   |
            | H      | Incorrect values for calculated fields        | -                                        | 0                   |
            | I      | Fields containing "missing data codes"        | -                                        | 4                   |
            | 1      | [radio]=9.9                                   | [radio]=9.9                              | 1                   |
            | 2      | [ptname]<>[name]                              | [ptname]<>[name]                         | 8                   |

        When I click on the "view" link for Data Quality Rule # "C"
        #When I click on the link labeled "view" for the Rule Name labeled "Field validation errors (incorrect data type)"
        Then I should see "Rule: Field validation errors (incorrect data type)" in the dialog box
        And I should see "Discrepancies found: 1" in the dialog box
        And I should see a table header and rows containing the following values in a table:
            | Record                    | Discrepant fields with their values | Status           | Exclude |
            | 6  Event 1 (Arm 1: Arm 1) | email = HelloWorld                  | Validation error | exclude |

        #FUNCTIONAL_REQUIREMENT
        Given I click on the button labeled "Export results (CSV)" in the dialog box
        Then I should see "SUCCESS! The data quality results were successfully downloaded."
        And the downloaded CSV with filename "C4180500100_DataQualityDiscrepancies_FieldValidationErrorsIncorrect_yyyy-mm-dd.csv" has the header and rows below
            | record_id	| redcap_event_name	| redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | result-status      | result-is-excluded    | email      |
            | 6	        | event_1_arm_1		|                          |                        |                          | Validation error   | No                    | HelloWorld |

            
#END