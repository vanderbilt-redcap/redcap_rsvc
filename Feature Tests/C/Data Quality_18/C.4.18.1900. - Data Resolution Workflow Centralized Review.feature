Feature: User Interface: The system shall support centralized review and management of data queries within the Data Resolution Workflow (DRW).

    As a REDCap end user
    I want to review and manage all data queries from a single Resolve Issues dashboard
    So that I can monitor the status of every data query in the project and act on them efficiently

    Scenario: C.4.18.1900 Centralized review and management of data queries
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.1900" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button

        When I click on the button labeled "Additional customizations"
        And I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
        And I click on the button labeled "Save"
        And I click on the button labeled "Close"

        #SETUP_ASSIGNEE: a user who can be assigned queries
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"

        When I check the radio labeled "Respond only to opened queries"
        And I click on the button labeled "Add user"
        Then I should see "test_user1"

        #SETUP_QUERIES: Query 1 (record 1, ptname) - not assigned, will be closed
        When I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
        And I click on the radio labeled "Open query"
        And I enter "Query 1 - please confirm the name." into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        Then I should see "Saved!"
        And I wait for 2 seconds

        #SETUP_QUERIES: Query 2 (record 2, integer) - assigned to test_user1, will remain open and unresponded
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
        And I wait for 2 seconds

        #SETUP_QUERIES: Query 3 (record 3, number) - not assigned, will be open and responded
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Save changes and leave"
        And I select "3" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        And I click on the link in the row labeled "Instance #1"
        And I click on the icon labeled "View data resolution workflow" in the row labeled "Numbers"
        And I click on the radio labeled "Open query"
        And I enter "Query 3 - please confirm the number." into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        Then I should see "Saved!"
        And I click on the button labeled "Save & Exit Form"

        #FUNCTIONAL_REQUIREMENT: Centralized review of all open data queries
        When I click on the link labeled "Resolve Issues"
        Then I should see "Data Resolution Dashboard"
        And I should see "ptname"
        And I should see "integer"
        And I should see "Numbers"
        And I should see "test_user1"

        #FUNCTIONAL_REQUIREMENT: Manage a data query from the dashboard - respond to Query 3
        When I click on the button labeled "1 comment" in the row labeled "Numbers"
        Then I should see "Query 3 - please confirm the number."

        When I select "Corrected - Typographical error" on the dropdown field labeled "Reply with response:"
        And I enter "Query 3 - the number has been corrected." into the textarea field labeled "Comment"
        And I click on the button labeled "Respond to query"
        Then I should see "Saved!"
        And I wait for 2 seconds

        #FUNCTIONAL_REQUIREMENT: Manage a data query from the dashboard - close Query 1
        When I click on the button labeled "1 comment" in the row labeled "ptname"
        Then I should see "Query 1 - please confirm the name."

        When I click on the radio labeled "Close the query"
        And I enter "Query 1 - the name has been confirmed." into the textarea field labeled "Comment"
        And I click on the button labeled "Close the query"
        Then I should see "Saved!"
        And I wait for 2 seconds

        #VERIFY: The closed query is removed from the default open view
        Then I should see "integer"
        And I should see "Numbers"
        And I should NOT see "ptname"

        #FUNCTIONAL_REQUIREMENT: Filter by query status
        ##ACTION: Open unresponded
        When I click on the link labeled "Resolve Issues"
        And I select "Open unresponded" on the dropdown field labeled "Filters:"
        Then I should see "integer"
        And I should NOT see "Numbers"
        And I should NOT see "ptname"

        ##ACTION: Open responded
        When I click on the link labeled "Resolve Issues"
        And I select "Open responded" on the dropdown field labeled "Filters:"
        Then I should see "Numbers"
        And I should NOT see "integer"
        And I should NOT see "ptname"

        ##ACTION: Closed
        When I click on the link labeled "Resolve Issues"
        And I select "Closed / resolved issues" on the dropdown field labeled "Filters:"
        Then I should see "ptname"
        And I should NOT see "integer"
        And I should NOT see "Numbers"

        #FUNCTIONAL_REQUIREMENT: Filter by field
        When I click on the link labeled "Resolve Issues"
        And I select "integer" on the dropdown field labeled "All fields and rules"
        Then I should see "integer (1)"
        And I should NOT see "Numbers"

        #FUNCTIONAL_REQUIREMENT: Filter by assigned user
        ##ACTION: Assigned to test_user1
        When I click on the link labeled "Resolve Issues"
        And I select "test_user1" on the dropdown field labeled "User assigned (all users) or not assigned"
        Then I should see "integer"
        And I should NOT see "Numbers"

        ##ACTION: Not assigned
        When I click on the link labeled "Resolve Issues"
        And I select "User not assigned" on the dropdown field labeled "User assigned (all users) or not assigned"
        Then I should see "Numbers"
        And I should NOT see "Integer"

        #FUNCTIONAL_REQUIREMENT: Export the dashboard
        When I click on the link labeled "Resolve Issues"
        And I click on the button labeled "Export"
        Then the downloaded CSV with filename "C4181900_DataResolutionDashboard_yyyy-mm-dd_hhmm.csv" has 3 rows
        Then the downloaded CSV with filename "C4181900_DataResolutionDashboard_yyyy-mm-dd_hhmm.csv" has a value "OPEN" for column "Current Query Status"
        Then the downloaded CSV with filename "C4181900_DataResolutionDashboard_yyyy-mm-dd_hhmm.csv" has a value "test_user1" for column "User Assigned"
        Then the downloaded CSV with filename "C4181900_DataResolutionDashboard_yyyy-mm-dd_hhmm.csv" has a value "2" for column "Number of comments"
        #Manual: Close file

    
#END
