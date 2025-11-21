Feature: User Interface: The system shall allow submitted survey responses to be changed by a user who has edit survey responses rights.
  
  As a REDCap end user
  I want to see that Survey Feature is functioning as expected

  Scenario: B.3.15.0800.100 Edit survey response
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
    And I create a new project named "B.3.15.0800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    ##USER_RIGHTS - 1_FullRights
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    #SETUP_RECORD
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Survey" longitudinal instrument on event "Event Three"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    When I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey below"

    When I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

    When I click on the button labeled "Close survey"

    #Manual: Surveys open in the same window (by default) in automated tests (automated tests this in B.3.15.500 - Survey Alerts and Prompts)
    #And I click on the button labeled "Leave without saving changes"

    Given I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    And I should see the "Completed Survey Response" icon for the "Survey" longitudinal instrument on event "Event Three" for record "5"

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username            | Action           | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response5 | survey_complete = '2'                   |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Edit survey response
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event Three" for record ID "5" and click on the bubble
    Then I should see the button labeled "Edit response"

    When I click on button labeled "Edit response"
    Then I should see "(now editing)"

    Given I clear field and enter "Name_EDITRESPONSE" into the data entry form field labeled "Name"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 5 successfully edited"

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Update record5 | name_survey = 'Name_EDITRESPONSE'       |

    #VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event Three" for record ID "5" and click on the bubble
    Then I should see "Name_EDITRESPONSE" in the data entry form field "Name"

    ##USER_RIGHTS - 3_ReadOnly_Deidentified
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Re-assign to role"
    And I select "3_ReadOnly_Deidentified" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "3_ReadOnly_Deidentified" row of the column labeled "Username" of the User Rights table

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Unable to edit survey response
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event Three" for record ID "5" and click on the bubble
    Then I should see "Survey response is read-only"
    And I should NOT see the button labeled "Edit response"
#END