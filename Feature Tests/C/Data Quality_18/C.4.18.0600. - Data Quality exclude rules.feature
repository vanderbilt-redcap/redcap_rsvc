Feature: User Interface: The system shall support excluding discrepancies found in rule execution.

    As a REDCap end user
    I want to see that Data Quality Module is functioning as expected

    Scenario: C.4.18.0600.100 Exclude discrepancies
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.0600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button
        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

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
            | 1      | [radio]=9.9                                   | [radio]='9..9'                           | 1                   |
            | 2      | [ptname]<>[name]                              | [ptname]<>[name]                         | 8                   |

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: verify ability to exclude a discrepancy
        When I click on the link labeled "view" in the row labeled "D"
        Then I should see "Rule: Field validation errors (out of range)"
        And I should see "Discrepancies found: 4"
        And I should see a table header and rows containing the following values in a table:
            | Record | Discrepant fields with their values | Status       | Exclude |
            | 5 (#1) | integer = 1111111111                | Out of range | exclude |
            | 5 (#1) | number_1_comma = 22222222.0         | Out of range | exclude |
            | 5 (#1) | number_1_period = 4.2               | Out of range | exclude |
            | 5 (#1) | number = 10.000                     | Out of range | exclude |

        When I click on the link labeled "exclude" in the row labeled "integer = 1111111111"
        Then I should see a table header and rows containing the following values in a table:
            | Record | Discrepant fields with their values | Status       | Exclude          |
            | 5 (#1) | integer = 1111111111                | Out of range | remove exclusion |

        And I click on the button labeled "Close" in the dialog box
        #Manual: refresh the page

        ##VERIFY
        Then I click on the button labeled "Clear"
        When I click on the button labeled exactly "All"
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                              | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | D      | Field validation errors (out of range) | -                                        | 3                   |

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: verify ability to add back excluded discrepancy
        When I click on the link labeled "view" in the row labeled "D"
        Then I should see "Rule: Field validation errors (out of range)"
        And I should see "Discrepancies found: 3"
        And I should see a link labeled "view"

        When I click on the link labeled "view"
        Then I should see "Rule: Field validation errors (out of range)"
        And I should see "Discrepancies found: 4"
        And I should see a table header and rows containing the following values in a table:
            | Record | Discrepant fields with their values | Status       | Exclude          |
            | 5 (#1) | integer = 1111111111                | Out of range | remove exclusion |
            | 5 (#1) | number_1_comma = 22222222.0         | Out of range | exclude          |
            | 5 (#1) | number_1_period = 4.2               | Out of range | exclude          |
            | 5 (#1) | number = 10.000                     | Out of range | exclude          |

        When I click on the link labeled "remove exclusion" in the row labeled "integer = 1111111111"
        And I should see a table header and rows containing the following values in a table:
            | Record | Discrepant fields with their values | Status       | Exclude |
            | 5 (#1) | integer = 1111111111                | Out of range | exclude |
            | 5 (#1) | number_1_comma = 22222222.0         | Out of range | exclude |
            | 5 (#1) | number_1_period = 4.2               | Out of range | exclude |
            | 5 (#1) | number = 10.000                     | Out of range | exclude |

        And I click on the button labeled "Close" in the dialog box
        #Manual: refresh the page

        ##VERIFY
        Then I click on the button labeled "Clear"
        When I click on the button labeled exactly "All"
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                              | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | D      | Field validation errors (out of range) | -                                        | 4                   |
#END