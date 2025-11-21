Feature: Saving Data: The system shall support the following statuses for data instruments: (Incomplete (no data saved) | Incomplete | Unverified | Complete)
    As a REDCap end user
    I want to see that statuses for data instruments is functioning as expected

    Scenario: B.3.14.0700.100 Statuses for data instruments
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
        And I create a new project named "B.3.14.0700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #FUNCTIONAL_REQUIREMENT
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
        ##ACTION  Set record status to Incomplete (No data)
        And I should see the dropdown field labeled "Complete?" with the option "Incomplete" selected
        And I click on the button labeled "Cancel"
        Then I should see "Record ID 7 data entry cancelled - not saved."

        #VERIFY_RECORD_HOMEPAGE: Incomplete - save and stay (No data)
        Then I should see the "Incomplete (no data saved)" icon for the "Text Validation" longitudinal instrument on event "Event 1"

        #FUNCTIONAL_REQUIREMENT
        Given I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        ##ACTION  Set record status to Incomplete (W/ data)
        And I clear field and enter "Incomplete with data" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        Then I should see "Record ID 7 successfully added."

        #VERIFY_RECORD_HOMEPAGE: Incomplete - save and stay (W/ data)
        And I should see the "Incomplete" icon for the "Text Validation" longitudinal instrument on event "Event 1"

        #FUNCTIONAL_REQUIREMENT
        Given I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
        ##ACTION  Set record status to Unverified
        And I select "Unverified" on the dropdown field labeled "Complete?"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        Then I should see "Record ID 7 successfully edited."

        #VERIFY_RECORD_HOMEPAGE: Unverified
        And I should see the "Unverified" icon for the "Text Validation" longitudinal instrument on event "Event 1"

        #FUNCTIONAL_REQUIREMENT
        Given I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
        ##ACTION  Set record status to Complete
        And I select "Complete" on the dropdown field labeled "Complete?"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        Then I should see "Record ID 7 successfully edited."

        #VERIFY_RECORD_HOMEPAGE: Complete
        And I should see the "Complete" icon for the "Text Validation" longitudinal instrument on event "Event 1"

        ##VERIFY_DE
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see a table header and rows containing the following values in the report data table:
            | Record ID | Event Name             | Complete? text_validation_complete |
            | 7         | Event 1 (Arm 1: Arm 1) | Complete (2)                       |
            | 1         | Event 2 (Arm 1: Arm 1) | Unverified (1)                     |
            | 1         | Event 1 (Arm 1: Arm 1) | Incomplete (0)                     |
            | 3         | Event 1 (Arm 1: Arm 1) | Incomplete (0)                     |
#END