Feature: User Interface: The system shall support limiting a rule viewing that references a field to only users with access rights.

    As a REDCap end user
    I want to see that Data Quality Module is functioning as expected

    Scenario: C.4.18.1400.100 User access limit rule viewing
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.1400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see Project status: "Production"

        #USER_RIGHTS: add two users with diff access levels
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign" on the role selector dropdown
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

        When I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "4_NoAccess_Noexport" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign" on the role selector dropdown
        Then I should see "Test User2" within the "4_NoAccess_Noexport" row of the column labeled "Username" of the User Rights table

        And I logout

        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.4.18.1400"
        And I click on the link labeled "Data Quality"
        Then I should see "Data Quality Rules"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: confirm user with full rights can execute
        When I click on the button labeled "All"
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                                                                 | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | A      | Blank values*                                                             | -                                         | 395                 |
            | B      | Blank values* (required fields only)                                      | -                                         | 2                   |
            | C      | Field validation errors (incorrect data type)                             | -                                         | 1                   |
            | D      | Field validation errors (out of range)                                    | -                                         | 4                   |
            | E      | Outliers for numerical fields (numbers, integers, sliders, calc fields)** | -                                         | 2                   |
            | F      | Hidden fields that contain values***                                      | -                                         | 1                   |
            | G      | Multiple choice fields with invalid values                                | -                                         | 1                   |
            | H      | Incorrect values for calculated fields                                    | -                                         | 0                   |
            | I      | Fields containing "missing data codes"                                    | -                                         | 4                   |
            | 1      | [radio]=9.9                                                               | [radio]= '9..9'                           | 1                   |
            | 2      | [ptname]<>[name]                                                          | [ptname]<>[name]                          | 8                   |

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: verify ability to view discrepancies with access
        When I click on the "view" link for Data Quality Rule # "C"
        Then I should see "Rule: Field validation errors (incorrect data type)" in the dialog box
        And I should see "Discrepancies found: 1" in the dialog box
        And I should see a table header and rows containing the following values in a table:
            | Record                    | Discrepant fields with their values | Status           | Exclude |
            | 6  Event 1 (Arm 1: Arm 1) | email = HelloWorld                  | Validation error | exclude |

        And I click on the button labeled "Close" in the dialog box
        And I logout

        #ACTION: switch to Test_User2
        Given I login to REDCap with the user "Test_User2"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.4.18.1400"
        And I click on the link labeled "Data Quality"
        Then I should see "Data Quality Rules"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: confirm user with full rights can execute but NOT view discrepancy
        When I click on the button labeled "All"
        Then I should see a table header and rows containing the following values in a table:
            | Rule # | Rule Name                                                                 | Rule Logic  (Show discrepancy only if...) | Total Discrepancies |
            | A      | Blank values*                                                             | -                                        | 0                   |
            | B      | Blank values* (required fields only)                                      | -                                        | 0                   |
            | C      | Field validation errors (incorrect data type)                             | -                                        | 1                   |
            | D      | Field validation errors (out of range)                                    | -                                        | 4                   |
            | E      | Outliers for numerical fields (numbers, integers, sliders, calc fields)** | -                                        | 2                   |
            | F      | Hidden fields that contain values***                                      | -                                        | 1                   |
            | G      | Multiple choice fields with invalid values                                | -                                        | 1                   |
            | H      | Incorrect values for calculated fields                                    | -                                        | 0                   |
            | I      | Fields containing "missing data codes"                                    | -                                        | 4                   |
            | 1      | [radio]=9.9                                                               | [radio]= '9..9'                          | ERROR               |
            | 2      | [ptname]<>[name]                                                          | [ptname]<>[name]                         | ERROR               |

        When I click on the "view" link for Data Quality Rule # "C"
        Then I should see "Rule: Field validation errors (incorrect data type)" in the dialog box
        And I should see "Discrepancies found: 1" in the dialog box
        And I should see a table header and rows containing the following values in a table:
            | Record                    | Discrepant fields with their values                             | Status           | Exclude |
            | 6  Event 1 (Arm 1: Arm 1) | email = [cannot display data] (Reason: Lack of user privileges) | Validation error | exclude |

        And I click on the button labeled "Close" in the dialog box

        #VERIFY_RSD GO TO RSD AND CANNOT SEE ANY INSTRUMENTS
        When I click on the link labeled "Record Status Dashboard"
        And I should NOT see "Text Validation"
#END