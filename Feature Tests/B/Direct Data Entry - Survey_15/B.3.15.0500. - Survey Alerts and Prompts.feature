Feature: User Interface: Survey Distribution: The system shall prohibit the user from overwriting partially or fully completed survey response from a data entry form when using Open Survey link.

  As a REDCap end user
  I want to see that Survey Feature is functioning as expected

  Scenario: B.3.15.0500.100 Data form overwrite function post survey entry
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.3.15.0500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #SETUP_RECORD
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Survey" longitudinal instrument on event "Event Three"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label and will leave the tab open when I return to the REDCap project
    Then I should see "Please complete the survey below."

    #FUNCTIONAL REQUIREMENT
    ##ACTION Verify Leave this page while survey is in session
    Given I click on the button labeled "Submit"
    And I return to the REDCap page I opened the survey from
    Then I should see a dialog containing the following text: "Recommended: Leave this page while survey is in session"
    And I click on the button labeled "Leave without saving changes" in the dialog box

    ##VERIFY_LOG:
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username            | Action          | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response | survey_complete = '2'                   |

    #FUNCTIONAL REQUIREMENT
    ##ACTION Verify Leave this page while survey is in session
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Survey" longitudinal instrument on event "Event Three"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label and will leave the tab open when I return to the REDCap project
    Then I should see "Please complete the survey below."

    #FUNCTIONAL REQUIREMENT
    ##ACTION Verify stay on page and edit survey
    Given I click on the button labeled "Submit"
    And I return to the REDCap page I opened the survey from
    When I click on the button labeled "Stay on page" in the dialog box
    And I clear field and enter "Overwrite Name" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 6 successfully edited."

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username            | Action          | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin          | Update record   | name_survey = 'Overwrite Name'          |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response | survey_complete = '2'                   |
#END