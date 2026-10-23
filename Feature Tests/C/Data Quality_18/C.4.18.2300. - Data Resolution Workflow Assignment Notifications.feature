Feature: C.4.18.2300. User Interface: The system shall support notification of users assigned to data queries within the Data Resolution Workflow (DRW).

    As a REDCap project user
    I want to notify users assigned to data queries
    So that they know which data issues require their attention

    Scenario: C.4.18.2300.100 Notify test_user1 of an assigned data query
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.2300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        When I click on the button labeled "Additional customizations"
        And I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
        And I click on the button labeled "Save"
        And I click on the button labeled "Close"
        And I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"

        When I check the radio labeled "Respond only to opened queries"
        And I click on the button labeled "Add user"
        Then I should see "test_user1"

        When I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        And I enter "John Doe" into the input field labeled "Name"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 1 successfully edited."

        #FUNCTIONAL_REQUIREMENT: Assign a query and send an email notification
        When I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        And I click on the icon labeled "View data resolution workflow" in the row labeled "Text2"
        And I click on the radio labeled "Open query"
        And I select "Test_User1 (Test User1)" on the dropdown field labeled "Assign query to a user (optional):"
        And I check the checkbox labeled "Email"
        And I enter "Please review this value" into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 1 successfully edited."

        And I verify that an email was sent to "Test_User1@test.edu" with a subject containing "You were assigned to a data query" and a body containing "Open the data query assigned to you"

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported                                                                                                                                        |
            | test_admin | Manage/Design | Open data query (Record: 1, Event: Event 1 (Arm 1: Arm 1), Field: text2, Comment: "Please review this value")|
        And I logout

        #VERIFY: The assigned user can access the notified query
        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.4.18.2300.100"
        And I click on the link labeled "Resolve Issues"
        And I click on the button labeled "1 comment" in the row labeled "Text2"
        And I select "Corrected - Typographical error" on the dropdown field labeled "Reply with response:"
        And I enter "Closing query" into the textarea field labeled "Comment"
        And I click on the button labeled "Respond to query"
        Then I should see "Saved"
        And I logout
#END