Feature: User Interface: Survey Project Settings: The system shall support the ability to create repeating surveys.

  As a REDCap end user
  I want to see that Manage project user access is functioning as expected

  Scenario: B.6.4.1400.100 Ability to create repeating surveys
    #ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
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
    And I create a new project named "B.6.4.1400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    #VERIFY_SETUP repeat instrument
    Then I should see a button labeled "Modify" in the row labeled "Repeating instruments and events"

    #SETUP_PRODUCTION
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #VERIFY_DESIGNER
    When I click on the link labeled "Designer"
    Then I should see a button labeled "Survey settings" in the row labeled "Survey"

    #FUNCTIONAL REQUIREMENT
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event Three" for record ID "1" and click on the bubble
    ##ACTION open survey
    When I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see a button labeled "Submit"

    #VERIFY - only submit button and hit submit, no take again
    Given I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"
    Then I should see "You may now close this tab/window"
    And I should NOT see "Take this survey again"

    #VERIFY - no repeatable button
    Given I return to the REDCap page I opened the survey from
    Then I should see "Survey response is read-only"
    And I click on the link labeled "Record Status Dashboard"
    And I should see the "Completed Survey Response" icon for the "Survey" longitudinal instrument on event "Event Three" for record "1"

    #SETUP modify repeat instrument
    Given I click on the link labeled "Setup"
    When I click on the button labeled "Modify" in the row labeled "Repeating instruments and events"
    Then I should see a dialog containing the following text: "WARNING"
    Given I click on the button labeled "Close" in the dialog box
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
    And for the Event Name "Event Three (Arm 1: Arm 1)", I check the checkbox labeled "Survey" in the dialog box
    And I click on the button labeled "Save"
    Then I should see a dialog containing the following text: "Your settings for repeating instruments and/or events have been successfully saved."
    And I click on the button labeled "Close" in the dialog box

    #VERIFY - OK for manual; since dialog box disappears, commented out for ATS
    #Then I should see "Successfully saved" in the dialog box
    #And I click on the button labeled "Close" in the dialog box

    #ACTION - Create repeatable survey
    Given I click on the link labeled "Designer"
    And I click on the button labeled "Survey settings" in the row labeled "Survey"
    And I click on the checkbox labeled "(Optional) Repeat the survey"
    And I click on the button labeled "Save Changes"
    #VERIFY
    Then I should see "Your survey settings were successfully saved"

    ##ACTION - Create repeatable survey in record
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event Three" for record ID "4" and click on the bubble
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "Record ID 4 successfully edited"

    Given I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey below."

    Given I clear field and enter "Name_survey" into the data entry form field labeled "Name"
    And I click on the button labeled "Take this survey again"
    Then I should see "Please complete the survey below."

    Given I clear field and enter "Name_survey2" into the data entry form field labeled "Name"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    When I click on the button labeled "Close survey"
    Then I should see "You may now close this tab/window"

    ##VERIFY 2 instances
    Given I return to the REDCap page I opened the survey from
    Then I should see "Survey response is read-only"

    Given I click on the link labeled "Record Status Dashboard"
    Then I should see the "Many statuses (all same)" icon for the "Survey" longitudinal instrument on event "Event Three" for record "4"

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username            | Action          | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response | [instance = 2]                          |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response | name_survey = 'Name_survey2'            |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response | name_survey = 'Name_survey'             |
#END