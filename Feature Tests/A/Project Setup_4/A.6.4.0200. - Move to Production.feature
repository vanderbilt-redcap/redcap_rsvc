Feature: A.6.4.0200. Manage project creation, deletion, and settings

    As a REDCap end user
    I want to see that project management features are functioning as expected

    Scenario: A.6.4.0200.100 User requests admin move project to production
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.6.4.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.6.4.0200.100"
        And I click on the link labeled "User Rights"
        And I should see a table with 6 rows
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        When I click on the button labeled "Assign"
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        Then I should see "System-level User Settings"
        When I select "No, only Administrators can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"
        Given I logout

        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.6.4.0200.100"
        And I click on the link labeled "Setup"
        Then I should see a button labeled "Move project to production"

        When I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "Yes, Request Admin to Move to Production Status"
        Then I should see "Your request to move the project to production status has been sent to a REDCap administrator"
        And I wait for 1 second
        And I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Send request to move project to production status |
        Given I logout

        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.6.4.0200.100"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "To-Do List"

        Then I should see "Pending Requests"

        Given I click on the icon labeled "Actions" in the row labeled "Move to prod"
        Then I should see 'Project title: "A.6.4.0200.100"'
        When I click on the icon labeled "Comment" in the row labeled "Move to prod"
        Then I should see "Move Project To Production Status"

        Given I click on the radio labeled "Keep ALL data saved so far."
        When I click on the button labeled "YES, Move to Production Status"
        And I close the iframe window
        Then I click on the icon labeled "Actions" in the row labeled "completed"
        And I should see 'Project title: "A.6.4.0200.100"'
        And I should see "Request Completed By: Test_Admin"

        Given I click on the link labeled "My Projects"
        And I click on the link labeled "A.6.4.0200.100"
        Then I should see "Project status:  Production"
        And I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Move project to Production status       |

    Scenario: A.6.4.200.200 User moves project to production
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I create a new project named "A.6.4.0200.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.6.4.0200.200"
        And I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled "Assign"
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        Then I should see "System-level User Settings"
        When I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"
        Given I logout

        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.6.4.0200.200"
        And I click on the link labeled "Setup"
        Then I should see a button labeled "Move project to production"

        Given I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far."
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Project status:  Production"
        Given I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Move project to Production status       |
#End