Feature: User Interface: The system shall support opening and management of data queries from Data Quality discrepancy results within the Data Resolution Workflow (DRW).

    As a REDCap end user
    I want to open and manage data queries directly from Data Quality discrepancy results
    So that discrepancies found by Data Quality rules can be tracked through resolution

    Scenario: C.4.18.1800 Open and manage data queries from Data Quality discrepancy results
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.1800" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button

        When I click on the button labeled "Additional customizations"
        And I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
        And I click on the button labeled "Save"
        And I click on the button labeled "Close"

        #FUNCTIONAL_REQUIREMENT: Open a data query from a discrepancy result
        #ACTION: Execute the rules and view the discrepancies for "Field validation errors (incorrect data type)"
        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "C"
        Then I should see "Rule: Field validation errors (incorrect data type)"
        And I should see "Discrepancies found: 1"
        And I should see "email = HelloWorld"
        And I should see a button labeled "0 comments"

        ##ACTION: Open the data query from the discrepancy
        When I click on the button labeled "0 comments" in the row labeled "HelloWorld"
        Then I should see "Not Opened"

        When I click on the radio labeled "Open query"
        And I enter "Please verify this email value." into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        Then I should see "Saved!"
        And I click on the button labeled "Close"

        #VERIFY: The query is linked to the discrepancy result
        When I click on the link labeled "view" in the row labeled "C"
        Then I should see "Discrepancies found: 1"
        And I should see a button labeled "1 comment"
        And I click on the button labeled "Close"

        #FUNCTIONAL_REQUIREMENT: Manage the data query on the Resolve Issues page
        #VERIFY: The query is listed for the discrepant field
        When I click on the link labeled "Resolve Issues"
        Then I should see a button labeled "1 comment"
        When I click on the button labeled "1 comment" in the row labeled "email"
        Then I should see "Please verify this email value."
        And I should see "Open / Unresolved"

        #ACTION: Respond to the query
        When I select "Corrected - Typographical error" on the dropdown field labeled "Reply with response:"
        And I enter "The email address has been corrected." into the textarea field labeled "Comment"
        And I click on the button labeled "Respond to query"
        Then I should see "Saved!"
        And I wait for 2 seconds

        #ACTION: Close the query
        When I click on the button labeled "2 comments" in the row labeled "email"
        Then I should see "The email address has been corrected."
        And I enter "Closing the query." into the textarea field labeled "Comment"
        And I click on the button labeled "Close the query"
        Then I should see "Saved!"

        #VERIFY: The closed query is reflected in the discrepancy result
        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "C"
        And I wait for 2 seconds
        And I click on the link labeled "view" 
        Then I should see "Discrepancies found: 1"
        And I should see a button labeled "3 comments"
        
        #VERIFY: Verify status
        When I click on the button labeled "3 comments" in the row labeled "HelloWorld"
        Then I should see "Closed / Resolved"
        And I should see "Closed query"
#END
