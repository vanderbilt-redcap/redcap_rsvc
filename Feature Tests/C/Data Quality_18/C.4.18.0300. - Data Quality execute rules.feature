Feature: User Interface: The system shall support executing a rule.

    As a REDCap end user
    I want to see that Data Quality Module is functioning as expected

    Scenario: C.4.18.0300.100 Executing data quality rule
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.0300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button
        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see Project status: "Production"
        #FUNCTIONAL REQUIREMENT
        ##ACTION The system shall support executing a single rule.
        When I click on the link labeled "Data Quality"
        And I click on the "Execute" button for Data Quality Rule # "1"
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name   | Rule Logic  | Total Discrepancies |
            | 1      | [radio]=9.9 | [radio]=9.9 | 1                   |

        #FUNCTIONAL REQUIREMENT
        ##ACTION The system shall support executing all rules.
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
#END