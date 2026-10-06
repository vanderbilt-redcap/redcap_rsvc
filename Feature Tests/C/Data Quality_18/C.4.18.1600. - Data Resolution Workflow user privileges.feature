Feature: C.4.18.1600.	User Interface: The system shall support configurable user privileges for the Data Resolution Workflow (DRW).

        As a REDCap end user
        I want to see that the Data Resolution Workflow is functioning as expected

        Scenario: SETUP project, enable the Data Resolution Workflow, and configure a distinct DRW privilege level for each test user

        #SETUP
                Given I login to REDCap with the user "Test_Admin"
                And I create a new project named "C.4.18.1600." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP Enable the Data Resolution Workflow for this project
                And I click on the button labeled "Additional customizations"
                And I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
                And I click on the button labeled "Save"
                Then I should see "The Data Resolution Workflow has now been enabled!"
                And I click on the button labeled "Close"

        #SETUP Confirm the system exposes all configurable DRW privilege levels, then assign one distinct level per test user
                When I click on the link labeled "User Rights"
                And I enter "Test_User1" into the input field labeled "Add with custom rights"
                And I click on the button labeled "Add with custom rights"
                Then I should see "Adding new user"
                And I should see "No Access"
                And I should see "View only"
                And I should see "Open queries only"
                And I should see "Respond only to opened queries"
                And I should see "Open and respond to queries"
                And I should see "Open, close, and respond to queries"
                And I check the second radio labeled "No Access"
                And I click on the button labeled "Add user"

                When I enter "Test_User2" into the input field labeled "Add with custom rights"
                And I click on the button labeled "Add with custom rights"
                And I check the radio labeled "View only"
                And I click on the button labeled "Add user"

                When I enter "Test_User3" into the input field labeled "Add with custom rights"
                And I click on the button labeled "Add with custom rights"
                And I check the radio labeled "Open queries only"
                And I click on the button labeled "Add user"

                When I enter "Test_User4" into the input field labeled "Add with custom rights"
                And I click on the button labeled "Add with custom rights"
                And I check the radio labeled "Respond only to opened queries"
                And I click on the button labeled "Add user"
                Then I should see "test_user1"
                And I should see "test_user2"
                And I should see "test_user3"
                And I should see "test_user4"

        #SETUP Open an initial data query (as the full-rights project owner) that other privilege levels can view/respond to
                And I click on the link labeled "Add / Edit Records"
                And I select "1" on the dropdown field labeled "select record"
                And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
                And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
                And I click on the radio labeled "Open query"
                And I enter "Please confirm this participant's name is correct." into the textarea field labeled "Comment"
                And I click on the button labeled "Open query"
                And I logout

        Scenario: C.4.18.1600.0100 ensures a user with "No Access" DRW privileges cannot access the Data Resolution Workflow in any way

                Given I login to REDCap with the user "Test_User1"
                And I click on the link labeled "My Projects"
                And I click on the link labeled "C.4.18.1600."

                #FUNCTIONAL_REQUIREMENT
                Then I should NOT see a link labeled "Resolve Issues"
                And I should NOT see a link labeled "Data Quality"

                And I click on the link labeled "Add / Edit Records"
                And I select "1" on the dropdown field labeled "select record"
                And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
                Then I should NOT see an icon labeled "View data resolution workflow" in the row labeled "Name"
                And I logout

        Scenario: C.4.18.1600.0200 ensures a user with "View only" DRW privileges can view existing data queries but cannot open, respond to, or close them

                Given I login to REDCap with the user "Test_User2"
                And I click on the link labeled "My Projects"
                And I click on the link labeled "C.4.18.1600."
                Then I should see a link labeled "Resolve Issues"

                #FUNCTIONAL_REQUIREMENT
                ##ACTION a field with no query history shows no DRW icon, so a new query cannot be opened
                And I click on the link labeled "Add / Edit Records"
                And I select "1" on the dropdown field labeled "select record"
                And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
                Then I should NOT see an icon labeled "View data resolution workflow" in the row labeled "Email"

                ##VERIFY the existing query on "Name" can be viewed, but no action controls are offered
                And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
                Then I should see "Please confirm this participant's name is correct."
                And I should see "Awaiting action by user with sufficient user privileges."
                And I should NOT see a textarea labeled "Comment"
                And I should NOT see a button labeled "Respond to query"
                And I logout

        Scenario: C.4.18.1600.0300 ensures a user with "Open queries only" DRW privileges can open a new data query but cannot act further once it is opened

                Given I login to REDCap with the user "Test_User3"
                And I click on the link labeled "My Projects"
                And I click on the link labeled "C.4.18.1600."
                And I click on the link labeled "Add / Edit Records"
                And I select "1" on the dropdown field labeled "select record"
                And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"

                #FUNCTIONAL_REQUIREMENT
                ##ACTION open a brand new query on the "Email" field
                And I click on the icon labeled "View data resolution workflow" in the row labeled "Email"
                And I click on the radio labeled "Open query"
                And I enter "Please verify this participant's email address." into the textarea field labeled "Comment"
                And I click on the button labeled "Open query"

                ##VERIFY the query now exists and is awaiting action by a user with sufficient privileges
                And I click on the link labeled "Resolve Issues"
                And I click on the button labeled "1 comment" in the row labeled "Email"
                Then I should see "Please verify this participant's email address."
                And I should see "Awaiting action by user with sufficient user privileges."
                And I should NOT see a button labeled "Respond to query"
                And I logout

        Scenario: C.4.18.1600.0400 ensures a user with "Respond only to opened queries" DRW privileges can reply to an already-opened query, but cannot open new queries or close existing ones

                Given I login to REDCap with the user "Test_User4"
                And I click on the link labeled "My Projects"
                And I click on the link labeled "C.4.18.1600."
                And I click on the link labeled "Add / Edit Records"
                And I select "1" on the dropdown field labeled "select record"
                And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"

                #FUNCTIONAL_REQUIREMENT
                ##ACTION respond to the query that was opened on the "Name" field, requesting a response
                And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
                Then I should see "Please confirm this participant's name is correct."
                And I should NOT see a radio labeled "Open query"
                And I should NOT see a radio labeled "Close the query"
                And I select "Other" on the dropdown field labeled "Reply with response:"
                And I enter "Confirmed the name is correct." into the textarea field labeled "Comment"
                And I click on the button labeled "Respond to query"

                ##VERIFY the query remains open, awaiting action by a user who can close it
                And I click on the link labeled "Resolve Issues"
                And I click on the button labeled "2 comments" in the row labeled "Name"
                Then I should see "Confirmed the name is correct."
                And I should see "Awaiting action by user with sufficient user privileges."
                And I logout

        Scenario: C.4.18.1600.0500 ensures a user with "Open, close, and respond to queries" DRW privileges can close a query that has already been responded to

                Given I login to REDCap with the user "Test_Admin"
                And I click on the link labeled "My Projects"
                And I click on the link labeled "C.4.18.1600."
                And I click on the link labeled "Resolve Issues"

                #FUNCTIONAL_REQUIREMENT
                ##ACTION close the query on the "Name" field now that a response has been provided
                And I click on the button labeled "2 comments" in the row labeled "Name"
                And I should see a radio labeled "Close the query" that is checked
                And I enter "Thank you, closing this query." into the textarea field labeled "Comment"
                And I click on the button labeled "Close the query"

                ##VERIFY the closed query no longer appears among the open issues
                And I click on the link labeled "Resolve Issues"
                Then I should NOT see a button labeled "3 comments"

        Scenario: C.4.18.1600.0600 ensures DRW privileges are dynamically configurable, and that a user's capabilities change immediately once their assigned privilege level is updated

                #FUNCTIONAL_REQUIREMENT
                ##ACTION upgrade Test_User3 from "Open queries only" to "Open and respond to queries"
                Given I click on the link labeled "User Rights"
                And I click on the link labeled "Test User3"
                And I click on the button labeled "Edit user privileges"
                Then I should see "Editing existing user"
                And I check the radio labeled "Open and respond to queries"
                And I click on the button labeled "Save Changes"
                And I logout

                ##VERIFY Test_User3 can now respond to the same query that previously could not be acted upon further
                Given I login to REDCap with the user "Test_User3"
                And I click on the link labeled "My Projects"
                And I click on the link labeled "C.4.18.1600."
                And I click on the link labeled "Add / Edit Records"
                And I select "1" on the dropdown field labeled "select record"
                And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
                And I click on the icon labeled "View data resolution workflow" in the row labeled "Email"
                Then I should NOT see "Awaiting action by user with sufficient user privileges."
                And I select "Other" on the dropdown field labeled "Reply with response:"
                And I enter "Email address has been verified." into the textarea field labeled "Comment"
                And I click on the button labeled "Respond to query"

                And I click on the link labeled "Resolve Issues"
                Then I should see a button labeled "2 comments" in the row labeled "Email"
                And I logout
#End
