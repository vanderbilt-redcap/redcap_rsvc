Feature: Renaming a Record: The system shall allow users to rename a record.

    As a REDCap end user
    I want to see that rename record is functioning as expected

    Scenario: B.3.14.0900.100 Rename record
        #ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        Then I should see "System-level User Settings"
        Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        When I click on the button labeled "Save Changes"
        And I see "Your system configuration values have now been changed!"
        Then I logout

        #SETUP
        Given I login to REDCap with the user "Test_User1"
        And I create a new project named "B.3.14.0900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #SET UP_USER_RIGHTS
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        When I click on the button labeled exactly "Assign" on the role selector dropdown
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

        ##VERIFY - INITIAL RECORD ROW IN REPORT
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see a table header and rows containing the following values in the report data table:
            | Record ID | Email          |
            | 1         | email@test.edu |

        #FUNCTIONAL REQUIREMENT
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "1"
        ##ACTION Rename record
        When I click on the button labeled "Choose action for record"
        And I click on the link labeled "Rename record"
        Then I should see a dialog containing the following text: 'Rename record "1"'

        Given I clear field and enter "1.A" into the input field labeled 'Rename record "1"' in the dialog box
        And I click on the button labeled "Rename record" in the dialog box
        Then I should see "Record ID 1.A was successfully renamed!"

        #VERIFY_RSD: Record 1 is now 1.A
        When I click on the link labeled "Record Status Dashboard"
        Then I should see "Record Status Dashboard (all records)"
        Then I should see a link labeled "1.A"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Update record1 | record_id = '1.A'                       |

        ##VERIFY_DE - FIND SAME RECORD AFTER RENAME
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see a table header and rows containing the following values in the report data table:
            | Record ID | Email          |
            | 1.A       | email@test.edu |
#END