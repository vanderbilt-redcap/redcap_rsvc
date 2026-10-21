Feature: User Interface: The system shall support assigning and reassigning data queries to users within the Data Resolution Workflow (DRW).

    As a REDCap end user
    I want to assign data queries to users and reassign them to other users
    So that the appropriate person is responsible for responding to each data query

    Scenario: C.4.18.2000 Assign and reassign data queries
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.2000" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button

        When I click on the button labeled "Additional customizations"
        And I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
        And I click on the button labeled "Save"
        And I click on the button labeled "Close"

        #SETUP_ASSIGNEES: two users who can be assigned queries
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"

        When I check the radio labeled "Respond only to opened queries"
        And I click on the button labeled "Add user"
        Then I should see "test_user1"

        When I enter "Test_User2" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"

        When I check the radio labeled "Respond only to opened queries"
        And I click on the button labeled "Add user"
        Then I should see "test_user2"

        #SETUP_QUERIES: Query 1 (record 1, ptname) - opened without an assignee
        When I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
        And I click on the radio labeled "Open query"
        And I enter "Query 1 - please confirm the name." into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        Then I should see "Saved!"
        And I wait for 2 seconds

        #SETUP_QUERIES: Query 2 (record 2, integer) - opened and assigned to test_user1
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Save changes and leave"
        And I select "2" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        And I click on the link in the row labeled "Instance #1"
        And I click on the icon labeled "View data resolution workflow" in the row labeled "Integer"
        And I click on the radio labeled "Open query"
        And I select "Test_User1 (Test User1)" on the dropdown field labeled "Assign query to a user (optional):"
        And I enter "Query 2 - please confirm the integer." into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        Then I should see "Saved!"
        And I click on the button labeled "Save & Exit Form"

        #VERIFY: Initial assignments
        When I click on the link labeled "Resolve Issues"
        And I select "test_user1 (Test User1)" on the dropdown field labeled "User assigned (all users) or not assigned"
        Then I should see "Field: integer"
        And I should NOT see "Field: ptname"

        When I click on the link labeled "Resolve Issues"
        And I select "User not assigned" on the dropdown field labeled "User assigned (all users) or not assigned"
        Then I should see "Field: ptname"
        And I should NOT see "Field: integer"

        #FUNCTIONAL_REQUIREMENT: Assign an open, unassigned data query to a user
        When I click on the link labeled "Resolve Issues"
        And I click on the button labeled "1 comment" in the row labeled "Field: ptname"
        Then I should see "Query 1 - please confirm the name."
        And I should NOT see "Assigned to user:"

        When I click on the link labeled "Assign query to a user"
        And I select "Test_User1 (Test User1)" on the dropdown field labeled "Reassign query to selected user:"
        And I click on the button labeled "Reassign"
        And I wait for 2 seconds

        #VERIFY: The query is now assigned to test_user1
        When I click on the link labeled "Resolve Issues"
        And I select "test_user1" on the dropdown field labeled "User assigned (all users) or not assigned"
        Then I should see "Field: ptname"
        And I should see "Field: integer"

        When I click on the link labeled "Resolve Issues"
        And I select "User not assigned" on the dropdown field labeled "User assigned (all users) or not assigned"
        Then I should NOT see "Field: ptname"
        And I should NOT see "Field: integer"

        #FUNCTIONAL_REQUIREMENT: Reassign an assigned data query to a different user
        When I click on the link labeled "Resolve Issues"
        And I click on the button labeled "1 comment" in the row labeled "integer"
        Then I should see "Query 2 - please confirm the integer."
        And I should see "Assigned to user:"
        And I should see "test_user1"

        When I click on the link labeled "Assign to other user"
        And I select "Test_User2 (Test User2)" on the dropdown field labeled "Reassign query to selected user:"
        And I click on the button labeled "Reassign"
        And I wait for 2 seconds

        #VERIFY: The query is now assigned to test_user2 and no longer to test_user1
        When I click on the link labeled "Resolve Issues"
        And I select "test_user2" on the dropdown field labeled "User assigned (all users) or not assigned"
        Then I should see "Field: integer"
        And I should NOT see "Field: ptname"

        When I click on the link labeled "Resolve Issues"
        And I select "test_user1" on the dropdown field labeled "User assigned (all users) or not assigned"
        Then I should see "Field: ptname"
        And I should NOT see "Field: integer"

        #VERIFY: The assignment is shown in the data query history
        When I click on the link labeled "Resolve Issues"
        And I click on the button labeled "1 comment" in the row labeled "integer"
        Then I should see "Assigned to user:"
        And I should see "test_user2"
        And I click on the button labeled "Cancel"

        #VERIFY: The assignment and reassignment are logged
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported                                             |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Reassign data query to other user (Record: 2, Event: Event 1 (Arm 1: Arm 1), Field: integer) |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Assign data query to user (Record: 1, Event: Event 1 (Arm 1: Arm 1), Field: ptname)          |

#END
