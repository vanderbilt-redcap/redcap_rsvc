Feature: User Interface: Survey Distribution: The system shall provide a survey to be generated from within a participant record using these survey options: (Log out + Open survey | Open Survey link)

  As a REDCap end user
  I want to see that Survey Distribution is functioning as expected

  Scenario: B.3.15.0400.100 Open survey mode
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
    And I create a new project named "B.3.15.0400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION - Open survey
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Survey" longitudinal instrument on event "Event Three"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey below."

    When I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey"
    And I click on the button labeled "Close survey"

    #Manual: Surveys open in the same window (by default) in automated tests (automated tests this in B.3.15.500 - Survey Alerts and Prompts)
    #And I click on the button labeled "Leave without saving changes" in the dialog box

    #FUNCTIONAL REQUIREMENT
    ##ACTION - Log out + Open survey
    Given I return to the REDCap page I opened the survey from
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Survey" longitudinal instrument on event "Event Three"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Log out+ Open survey" label
    Then I should see "Please complete the survey below"

    When I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey"
    And I click on the button labeled "Close survey"

    ##VERIFY_LOG:
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.3.15.0400.100"
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username            | Action           | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response5 | survey_complete = '2'                   |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response6 | survey_complete = '2'                   |
#END