Feature: User Interface: The system shall support data query lifecycle activities (e.g., opening, responding, verification, and closing) within the Data Resolution Workflow (DRW).

    As a REDCap end user
    I want to manage data queries through the Data Resolution Workflow
    So that data issues can be documented, responded to, verified, and resolved

    Scenario: C.4.18.1700.100 Data query lifecycle
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.1700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        When I click on the button labeled "Additional customizations"
        And I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
        And I click on the button labeled "Save"
        And I click on the button labeled "Close"

        And I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
        And I enter "John Doe" into the input field labeled "Name"
        And I click on the button labeled "Save & Exit Form"

        #SETUP_RESPONDENT
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"

        When I check the radio labeled "Respond only to opened queries"
        And I click on the button labeled "Add user"
        Then I should see "test_user1"

        #FUNCTIONAL_REQUIREMENT: Open a field-level data query
        And I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
        And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
        
        And I click on the radio labeled "Open query"
        And I select "Test_User1 (Test User1)" on the dropdown field labeled "Assign query to a user (optional):"
        And I enter "Please confirm this participant's name is correct." into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        And I logout


        # #FUNCTIONAL_REQUIREMENT: Respond to the open query
        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.4.18.1700.100"
        And I click on the link labeled "Resolve Issues"
        And I click on the button labeled "1 comment" in the row labeled "Name"
        Then I should see "Please confirm this participant's name is correct."
        And I select "Corrected - Typographical error" on the dropdown field labeled "Reply with response:"
        And I enter "The value has been corrected." into the textarea field labeled "Comment"
        When I click on the button labeled "Respond to query"
        Then I should see "Saved!"
        And I logout

        #FUNCTIONAL_REQUIREMENT: Close the responded query
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.4.18.1700.100"
        And I click on the link labeled "Resolve Issues"
        And I click on the button labeled "2 comments" 
        Then I should see "The value has been corrected."
        And I enter "Please confirm this participant's name is correct." into the textarea field labeled "Comment"
        And I click on the button labeled "Close the query"
        Then I should see "Saved!"

        #VERIFY: Closed query status
        When I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
        And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
        Then I should see "Closed / Resolved"
        And I should see "Closed query"
        And I click on the button labeled "Cancel"

        #FUNCTIONAL_REQUIREMENT: Verify a field value in the Data Resolution Workflow
        When I click on the icon labeled "View data resolution workflow" in the row labeled "Email"
        Then I should see "Not Opened"
        And I should see "Verified data value"
        When I click on the button labeled "Verified data value"
        Then I should see "Saved!"

        # #VERIFY: Verified status
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Verified data value (Record: 1, Event: Event 1 (Arm 1: Arm 1), Field: email)        |
#END
