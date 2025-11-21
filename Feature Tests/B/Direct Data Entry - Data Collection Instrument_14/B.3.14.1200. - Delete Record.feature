Feature: B.3.14.1200. The system shall allow users to delete a record from the Record Home Page. 

    As a REDCap end user
    I want to see that user rights to delete data is functioning as expected

    Scenario: B.3.14.1200.100 Delete record
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
        And I create a new project named "B.3.14.1200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

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

        ##VERIFY - COUNT OF ROWS
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see the report with 19 rows

        ##ACTION
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "1"
        Then I should see "Record Home Page"
        And I should see "Record ID 1"

        ##FUNCTIONAL_REQUIREMENT
        ###ACTION Delete record
        When I click on the button labeled "Choose action for record"
        And I click on the link labeled "Delete record (all forms/events)"
        Then I should see a dialog containing the following text: 'DELETE RECORD "1"?'

        Given I click on the button labeled "DELETE RECORD" in the dialog box
        ##VERIFY
        Then I should see a dialog containing the following text: 'Record ID "1" was successfully deleted'
        And I click on the button labeled "Close" in the dialog box

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record1 | record_id = '1'                         |

        ##VERIFY - COUNT OF ROWS
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see the report with 14 rows
#END