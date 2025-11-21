Feature: Creating a Record and Entering Data: The system shall support the ability to reset a multiple choice-radio button selection.

    As a REDCap end user
    I want to see that field reset is functioning as expected

    Scenario: B.3.14.0300.100 Reset multiple choice-radio button selection
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
        And I create a new project named "B.3.14.0300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        When I click on the link labeled "Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        ##ACTION
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
        Then I should see "Adding new Record ID 7"

        When I select the radio option "Choice99" for the field labeled "radio"
        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        Then I should see "Record ID 7 successfully edited"

        When I click on the link labeled "reset" in the row labeled "radio"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 7 successfully edited"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Update record7 | radio = ''                              |
            | mm/dd/yyyy hh:mm | test_user1 | Create record7 | radio = '9..9'                          |

        ##VERIFY_DE
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see a table header and rows containing the following values in the report data table:
            | Record ID | radio |
            | 7         |       |
#END