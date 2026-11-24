Feature: User Interface: The system shall support executing a Data Quality rule for a specific record within the project.

    As a REDCap end user
    I want to execute a Data Quality rule for a specific record and view the results
    So that I can verify data quality for individual records

    Scenario: C.4.18.2500.100 Execute a single data quality rule for a single record
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.2500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button
        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Success! The project is now in production."

        #Validate Data Quality Rules Table has totals for all records.
        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                                     | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | A      | Blank values*                                 | -                                        | 395                 |
            | B      | Blank values* (required fields only)          | -                                        | 2                   |
            | C      | Field validation errors (incorrect data type) | -                                        | 1                   |
            | D      | Field validation errors (out of range)        | -                                        | 4                   |
            | E      | Outliers for numerical fields                 | -                                        | 2                   |
            | F      | Hidden fields that contain values***          | -                                        | 1                   |
            | G      | Multiple choice fields with invalid values    | -                                        | 1                   |
            | H      | Incorrect values for calculated fields        | -                                        | 32                  |
            | I      | Fields containing "missing data codes"        | -                                        | 4                   |
            | 1      | [radio]=9.9                                   | [radio]='9..9'                           | 1                   |
            | 2      | [ptname]<>[name]                              | [ptname]<>[name]                         | 8                   |
        And I click on the button labeled "Clear"
        #FUNCTIONAL REQUIREMENT
        ##ACTION The system shall display results when executing a rule for a specific record
        And I select "1" on the dropdown field labeled "Apply to"
        And I click on the button labeled "All" 
        #Validate the values in the Data Quality Rules Table is specific to record 1
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                                     | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | A      | Blank values*                                 | -                                         | 100                 |
            | B      | Blank values* (required fields only)          | -                                         | 2                   |
            | C      | Field validation errors (incorrect data type) | -                                         | 0                   |
            | D      | Field validation errors (out of range)        | -                                         | 0                   |
            | E      | Outliers for numerical fields                 | -                                         | 0                   |
            | F      | Hidden fields that contain values***          | -                                         | 0                   |
            | G      | Multiple choice fields with invalid values    | -                                         | 0                   |
            | H      | Incorrect values for calculated fields        | -                                         | 6                   |
            | I      | Fields containing "missing data codes"        | -                                         | 0                   |
            | 1      | [radio]=9.9                                   | [radio]='9..9'                            | 0                   |
            | 2      | [ptname]<>[name]                              | [ptname]<>[name]                          | 2                   |

        When I click on the link labeled "view" in the row labeled "H"
        Then I should see "Rule: Incorrect values for calculated fields"

        ##Action: Fix calculations for record 1
        When I click on the button labeled "Fix calcs now for selected record(s)"
        Then I should see "7 calculated values were successfully fixed."
        And I should see "The data quality rule is now automatically re-running to ensure that all calculated field values were updated correctly.)"
        And I click on the button labeled "Close"
        #Validate the values in the Data Quality Rules Table updated after calculations ran
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                                     | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | A      | Blank values*                                 | -                                         | 100                 |
            | B      | Blank values* (required fields only)          | -                                         | 2                   |
            | C      | Field validation errors (incorrect data type) | -                                         | 0                   |
            | D      | Field validation errors (out of range)        | -                                         | 0                   |
            | E      | Outliers for numerical fields                 | -                                         | 0                   |
            | F      | Hidden fields that contain values***          | -                                         | 0                   |
            | G      | Multiple choice fields with invalid values    | -                                         | 0                   |
            | H      | Incorrect values for calculated fields        | -                                         | 0                   |
            | I      | Fields containing "missing data codes"        | -                                         | 0                   |
            | 1      | [radio]=9.9                                   | [radio]='9..9'                            | 0                   |
            | 2      | [ptname]<>[name]                              | [ptname]<>[name]                          | 2                   |
              
        #Validate logging. Ensure the calculated fields were updated correctly
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action                                                  | List of Data Changes OR Fields Exported                                        |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design                                           | Execute data quality rule: Rule H (Incorrect values for calculated fields)     |
        | mm/dd/yyyy hh:mm | test_admin | Update record (Data Quality) 1 (Event 2 (Arm 1: Arm 1)) | [instance = 2], calc_test = '6', calculated_field = '6'     |
        | mm/dd/yyyy hh:mm | test_admin | Update record (Data Quality) 1 (Event 2 (Arm 1: Arm 1)) | calc_test = '6', calculated_field = '6'                     |

    Scenario: C.4.18.2500.200 Execute all data quality rules for a single record with discrepancies
        Given I click on the link labeled "REDCap"
        And I create a new project named "C.4.18.2500.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button
        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Success! The project is now in production."

         #Validate Data Quality Rules Table has totals for all records.
        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                                     | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | A      | Blank values*                                 | -                                        | 395                 |
            | B      | Blank values* (required fields only)          | -                                        | 2                   |
            | C      | Field validation errors (incorrect data type) | -                                        | 1                   |
            | D      | Field validation errors (out of range)        | -                                        | 4                   |
            | E      | Outliers for numerical fields                 | -                                        | 2                   |
            | F      | Hidden fields that contain values***          | -                                        | 1                   |
            | G      | Multiple choice fields with invalid values    | -                                        | 1                   |
            | H      | Incorrect values for calculated fields        | -                                        | 32                  |
            | I      | Fields containing "missing data codes"        | -                                        | 4                   |
            | 1      | [radio]=9.9                                   | [radio]='9..9'                           | 1                   |
            | 2      | [ptname]<>[name]                              | [ptname]<>[name]                         | 8                   |
        And I click on the button labeled "Clear"
        #FUNCTIONAL REQUIREMENT
        ##ACTION The system shall display results when executing a rule for a specific record
        And I select "1" on the dropdown field labeled "Apply to"
        And I click on the button labeled "All" 
        #Validate the values in the Data Quality Rules Table is specific to record 1
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                                     | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | A      | Blank values*                                 | -                                         | 100                 |
            | B      | Blank values* (required fields only)          | -                                         | 2                   |
            | C      | Field validation errors (incorrect data type) | -                                         | 0                   |
            | D      | Field validation errors (out of range)        | -                                         | 0                   |
            | E      | Outliers for numerical fields                 | -                                         | 0                   |
            | F      | Hidden fields that contain values***          | -                                         | 0                   |
            | G      | Multiple choice fields with invalid values    | -                                         | 0                   |
            | H      | Incorrect values for calculated fields        | -                                         | 6                   |
            | I      | Fields containing "missing data codes"        | -                                         | 0                   |
            | 1      | [radio]=9.9                                   | [radio]='9..9'                            | 0                   |
            | 2      | [ptname]<>[name]                              | [ptname]<>[name]                          | 2                   |

#END
