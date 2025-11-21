Feature: User Interface: The system shall support the following statuses for surveys: (Incomplete (no data saved) | Partial Survey Response |  Completed Survey Response)

    As a REDCap end user
    I want to see that Survey Feature is functioning as expected

    Scenario: B.3.15.0900.100 Survey completion statuses
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
        And I create a new project named "B.3.15.0900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #SETUP_DESIGNER
        When I click on the link labeled "Designer"
        And I click on the button labeled "Survey settings" in the row labeled "Survey"
        And I select "Yes" on the dropdown field labeled "Allow 'Save & Return Later' option for respondents?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Survey mode Incomplete (no data saved)
        Given I click on the link labeled "Record Status Dashboard"
        ##VERIFY_incomplete (no data) icon on record homepage
        Then I should see the "Incomplete (no data saved)" icon for the "Survey" longitudinal instrument on event "Event Three" for record "4"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Survey mode Partial Survey Response
        Given I click on the button labeled "Add new record for this arm"
        When I click the bubble to add a record for the "Survey" longitudinal instrument on event "Event Three"
        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        Then I should see "Please complete the survey below"

        ##VERIFY_RSD
        Given I click on the button labeled "Save & Return Later"
        And I click on the button labeled "Close" in the dialog box

        #Manual: Close browser tab
        #Manual: Surveys open in the same window (by default) in automated tests (automated tests this in B.3.15.500 - Survey Alerts and Prompts)
        #And I click on the button labeled "Leave without saving changes" in the dialog box

        When I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Partial Survey Response" icon for the "Survey" longitudinal instrument on event "Event Three" for record "5"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Survey mode Completed Survey Response
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three"
        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        Then I should see "Please complete the survey below"

        When I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."
        And I click on the button labeled "Close survey"

        ##VERIFY_RSD
        #Manual: Surveys open in the same window (by default) in automated tests (automated tests this in B.3.15.500 - Survey Alerts and Prompts)
        # When I click on the button labeled "Leave without saving changes"

        Given I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Survey" longitudinal instrument on event "Event Three" for record "6"
#END