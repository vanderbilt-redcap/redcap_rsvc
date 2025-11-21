Feature: User Interface: The system shall provide detailed summary of all drafted changes.

    As a REDCap end user
    I want to see that Draft Mode is functioning as expected

    Scenario: B.4.20.0400.100 Detailed summary of drafted changes
        ##ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
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
        And I create a new project named "B.4.20.0400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        ##ACTION: Draft Mode
        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        When I click on the link labeled "Data Types"
        And I click on the Edit image for the field named "Radio Button Manual"
        And I enter Choices of "102, Choice102" into the open "Edit Field" dialog box
        And I click on the button labeled "Save"
        And I click on the Add Field input button below the field named "Radio Button Manual"

        Given I select "Notes Box (Paragraph Text)" on the dropdown field labeled "Field Type:"
        And I enter "Notes Box" into the Field Label of the open "Add New Field" dialog box
        And I enter "notesbox4" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save"
        Then I should see the field labeled "Notes Box"

        #FUNCTIONAL_REQUIREMENT
        When I click on the link labeled "View detailed summary of all drafted changes"
        Then I should see "Review Drafted Changes"
        And I should see a table header and rows containing the following values in a table:
            | Variable Name       | Section Header | Field Type | Field Label         | Choices or Calculations |
            | radio_button_manual |                | radio      | Radio Button Manual | 102, Choice102          |
            | notesbox4           |                | notes      | Notes Box           |                         |


        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Create project field                    |
            | test_user1 | Manage/Design | Edit project field                      |
#END