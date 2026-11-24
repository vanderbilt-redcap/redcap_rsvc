Feature: User Interface: The system shall support configuration options to exclude resolved or verified Data Resolution Workflow (DRW) queries from Data Quality discrepancy results.

    As a REDCap end user
    I want to configure whether closed and verified data queries are excluded from Data Quality results
    So that I can focus on discrepancies that still need attention

    Scenario: C.4.18.2600.100 Hide and restore closed and verified queries in Data Quality results
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.4.18.2600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button
        When I click on the button labeled "Additional customizations"
        And I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
        And I uncheck the checkbox labeled "Hide closed/verified data queries from Data Quality results (for Data Resolution Workflow only)"
        And I click on the button labeled "Save"
        And I click on the button labeled "Close"

        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "D"
        Then I should see "Discrepancies found: 4"
        And I should see "integer = 1111111111"
        And I should see "number_1_comma = 22222222.0"
        And I should see "number_1_period = 4.2"

        # Close a query without changing the discrepant value.
        When I click on the button labeled "0 comments" in the row labeled "integer = 1111111111"
        And I click on the radio labeled "Open query"
        And I enter "Please review the integer value." into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        Then I should see "Saved!"

        When I wait for 2 seconds
        And I click on the button labeled " comments" in the row labeled "integer = 1111111111"
        And I click on the radio labeled "Close the query"
        And I enter "The value has been reviewed." into the textarea field labeled "Comment"
        And I click on the button labeled "Close the query"
        Then I should see "Saved!"


        # Verify a second discrepancy and leave a third query open.
        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "D"
        Then I should see "Discrepancies found: 4"
        And I should see "integer = 1111111111"
        And I should see "number_1_comma = 22222222.0"
        And I should see "number_1_period = 4.2"
        And I click on the button labeled "0 comments" in the row labeled "number_1_comma = 22222222.0"
        And I click on the first button labeled "Verified data value"
        Then I should see "Saved!"

        Given I click on the button labeled "Close"
        And I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "D"
        Then I should see "Discrepancies found: 4"
        And I should see "integer = 1111111111"
        And I should see "number_1_comma = 22222222.0"
        And I should see "number_1_period = 4.2"
        And I click on the button labeled "0 comments" in the row labeled "number_1_period = 4.2"
        And I click on the radio labeled "Open query"
        And I enter "Please review the number value." into the textarea field labeled "Comment"
        And I click on the button labeled "Open query"
        Then I should see "Saved!"
        And I click on the button labeled "Close"

        # With the setting disabled, all four discrepancies remain visible.
        When I click on the button labeled "Clear"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "D"
        Then I should see "Discrepancies found: 4"
        And I should see "integer = 1111111111"
        And I should see "number_1_comma = 22222222.0"
        And I should see "number_1_period = 4.2"
        And I should see "number = 10.000"
        And I click on the button labeled "Close"

        # Enable the setting and verify only the closed and verified results are hidden.
        When I click on the link labeled "Setup"
        And I click on the button labeled "Additional customizations"
        And I check the checkbox labeled "Hide closed/verified data queries from Data Quality results (for Data Resolution Workflow only)"
        And I click on the button labeled "Save"
        Then I should see "Success! Your changes have been saved"

        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "D"
        Then I should see "Discrepancies found: 2"
        And I should NOT see "integer = 1111111111"
        And I should NOT see "number_1_comma = 22222222.0"
        And I should see "number_1_period = 4.2"
        And I should see "number = 10.000"

        # Excluded results remain available from the results dialog.
        When I click on the link labeled "view"
        Then I should see "Discrepancies found: 4"
        And I should see "integer = 1111111111"
        And I should see "number_1_comma = 22222222.0"
        And I click on the button labeled "Close"

        # Disabling the setting restores the closed and verified discrepancies.
        When I click on the link labeled "Setup"
        And I click on the button labeled "Additional customizations"
        And I uncheck the checkbox labeled "Hide closed/verified data queries from Data Quality results (for Data Resolution Workflow only)"
        And I click on the button labeled "Save"
        Then I should see "Success! Your changes have been saved"
        
        When I click on the link labeled "Data Quality"
        And I click on the button labeled "All"
        And I click on the link labeled "view" in the row labeled "D"
        Then I should see "Discrepancies found: 4"
        And I should see "integer = 1111111111"
        And I should see "number_1_comma = 22222222.0"
        And I should see "number_1_period = 4.2"
        And I should see "number = 10.000"
#END
