Feature: Control Center: The system shall allow users to edit survey responses to be enabled or disabled.

    As a REDCap end user
    I want to see that allow edit survey response is functioning as expected

    Scenario: A.6.4.1600.100
        ##SETUP_DEV
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.6.4.1600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #FUNCTIONAL REQUIREMENT
        ##ACTION Admin Disable edit survey response function in control center
        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        And I select "Disabled" on the dropdown field labeled "Allow users to edit survey responses?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        ##VERIFY: Admin Go to user rights and look for the edit survey checkbox (should be missing)
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.6.4.1600.100"
        And I click on the link labeled "User Rights"
        And I click on the link labeled "test_admin"
        And I click on the button labeled "Edit user privileges"

        # MANUAL NOTE: We should NOT see a column labeled "Edit survey responses" in the "Data Viewing Rights" table
        Then I should see table rows containing the following values in a table in the dialog box:
            | Data Viewing Rights |           |             |        |
            | No Access           | Read Only | View & Edit | Delete |

        And I click on the button labeled "Cancel"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Admin Enable edit survey response function in control center
        Given I click on the link labeled "Control Center"
        When I click on the link labeled "User Settings"
        And I select "Enabled" on the dropdown field labeled "Allow users to edit survey responses?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        ##VERIFY: Admin Go to user rights and look for the edit survey checkbox (should be there)
        Given I click on the link labeled "My Projects"
        When I click on the link labeled "A.6.4.1600.100"
        And I click on the link labeled "User Rights"
        And I click on the link labeled "test_admin"
        And I click on the button labeled "Edit user privileges"

        # MANUAL NOTE: We should now see a column labeled "Edit survey responses" in the "Data Viewing Rights" table
        Then I should see table rows containing the following values in a table in the dialog box:
            | Data Viewing Rights |           |             |        |                       |
            | No Access           | Read Only | View & Edit | Delete | Edit Survey Responses |

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Enable editing survey responses for survey instrument
        When I check the checkbox in the column labeled "Edit Survey Responses" and the row labeled "Survey"
        And I click on the button labeled "Save Changes"
        Then I should see 'User "test_admin" was successfully edited'

        #SETUP Check edit survey function in a  record
        Given I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Survey" instrument on event "Event Three" for record ID "1" and click on the bubble

        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        And I clear field and enter "SURVEY RESPONSE" into the data entry form field labeled "Name"
        And I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        Then I should see "You may now close this tab/window"

        ##VERIFY_RSD
        Given I return to the REDCap page I opened the survey from
        Then I should see "Survey response is editable"

        Given I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Survey" longitudinal instrument on event "Event Three" for record "1"
        And I locate the bubble for the "Survey" instrument on event "Event Three" for record ID "1" and click on the bubble

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Edit survey response
        When I click on the button labeled "Edit response"
        Then I should see "(now editing)"

        Given I clear field and enter "EDITED SURVEY RESPONSE" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        Then I should see "Record ID 1 successfully edited."

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see "This module lists all changes"
        And I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username            | Action          | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin          | Update record   | name_survey = 'EDITED SURVEY RESPONSE'  |
            | mm/dd/yyyy hh:mm | [survey respondent] | Update Response | name_survey = 'SURVEY RESPONSE'         |
#End