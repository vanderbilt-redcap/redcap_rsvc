Feature: User Interface: The system shall provide a project-level configuration option that allows users to append static text to the displayed record name using a Custom Record Label.

    As a REDCap end user
    I want to set a Custom Record Label for my project
    So that static text is displayed next to each record name to help me identify records

    Scenario: C.6.47.0100 Append static text to the displayed record name using a Custom Record Label
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.6.47.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Project status:  Production"

        #VERIFY: No Custom Record Label is displayed by default
        When I click on the link labeled "Record Status Dashboard"
        Then I should NOT see "Name"

        #FUNCTIONAL_REQUIREMENT: Configure a Custom Record Label containing only static text
        When I click on the link labeled "Setup"
        And I click on the button labeled "Additional customizations"
        Then I should see "Set a Custom Record Label"
        And I should see "Custom Record Label:"

        When I check the checkbox labeled "Set a Custom Record Label"
        And I enter "[name]" into the input field labeled "Custom Record Label:"
        And I click on the button labeled "Save"
        Then I should see "Success! Your changes have been saved."

        # #VERIFY: The static text is appended to the record name when choosing a record
        # When I click on the link labeled "Record Status Dashboard"
        # Then I should see "1 Name"
        # And I should see "2 Name"

        # #VERIFY: The static text is appended to the record name on the Record Home Page and data entry form
        # When I select "1 Name" on the dropdown field labeled "select record"
        # Then I should see "1 Name"

        # When I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
        # Then I should see "1 Name"
        # And I click on the button labeled "Cancel"

        # #VERIFY: The static text is appended to the record name on the Record Status Dashboard
        # When I click on the link labeled "Record Status Dashboard"
        # Then I should see "1 Name"
        # And I should see "2 Name"

        # #FUNCTIONAL_REQUIREMENT: Modify the Custom Record Label
        # When I click on the link labeled "Project Setup"
        # And I click on the button labeled "Additional customizations"
        # And I clear the field labeled "Custom Record Label:"
        # And I enter "Cohort A" into the input field labeled "Custom Record Label:"
        # And I click on the button labeled "Save"
        # And I click on the button labeled "Close"

        # When I click on the link labeled "Record Status Dashboard"
        # Then I should see "1 Cohort A"
        # And I should see "2 Cohort A"
        # And I should NOT see "Study Participant"

        # #VERIFY: The change is logged
        # When I click on the link labeled "Logging"
        # Then I should see a table header and rows containing the following values in the logging table:
        #     | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
        #     | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Make project customizations             |

        # #FUNCTIONAL_REQUIREMENT: Remove the Custom Record Label
        # When I click on the link labeled "Project Setup"
        # And I click on the button labeled "Additional customizations"
        # And I uncheck the checkbox labeled "Set a Custom Record Label"
        # And I click on the button labeled "Save"
        # And I click on the button labeled "Close"

        # When I click on the link labeled "Record Status Dashboard"
        # Then I should NOT see "Cohort A"
        # And I should NOT see "Name"
#END
