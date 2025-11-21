Feature: Saving Data: The system shall support the prompt to save when a user attempts to navigate away from a data entry page without saving: (Save changes and leave | Leave without saving changes | Stay on page)

    As a REDCap end user
    I want to see that leave without saving data entry page navigation is functioning as expected

    Scenario: B.3.14.500.100 Navigate away from a data entry page options
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
        And I create a new project named "B.3.14.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the link labeled "Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #FUNCTIONAL_REQUIREMENT
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
        Then I should see "Adding new Record ID 7"

        ##ACTION Navigate away from the record
        And I click on the link labeled "Setup"

        ##VERIFY
        Then I should see a dialog containing the following text: "Save your changes"
        And I should see a button labeled "Save changes and leave"
        And I should see a button labeled "Leave without saving changes"
        And I should see a button labeled "Stay on page"

        ##ACTION Leave without saving changes
        When I click on the button labeled "Leave without saving changes"
        ##VERIFY
        Then I should see "Main project settings"

        ##VERIFY_LOG:
        # We should not see any evidence in the log that a record was created
        When I click on the link labeled "Logging"
        Then I should NOT see "record_id = '7'"

        #FUNCTIONAL_REQUIREMENT
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
        And I should see "Adding new Record ID 7"
        And I click on the link labeled "Setup"
        Then I should see a dialog containing the following text: "Save your changes"

        ##ACTION Save changes and leave
        When I click on the button labeled "Save changes and leave" in the dialog box
        ##VERIFY
        Then I should see "Main project settings"

        ##VERIFY_LOG:
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Create record7 |                                         |

        #FUNCTIONAL_REQUIREMENT
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
        And I click on the link labeled "Setup"
        Then I should see a dialog containing the following text: "Save your changes"

        ##ACTION Stay on page
        When I click on the button labeled "Stay on page" in the dialog box
        ##VERIFY
        Then I should see "Adding new Record ID 8"
        And I should see a checkbox labeled "Checkbox1" that is checked
#END