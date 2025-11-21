Feature: User Interface: Survey Project Settings: The system shall support survey status as active or offline.

  As a REDCap end user
  I want to see that Manage project user access is functioning as expected

  Scenario: B.3.15.0200.100 Survey Online/Offline Status
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
    And I create a new project named "B.3.15.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Enable survey in Online Designer
    Given I click on the link labeled "Designer"
    Then I click on the button labeled "Enable" in the column labeled "Enabled as" and the row labeled "Text Validation"
    And I select "Survey Active" on the dropdown field labeled "Survey Status"
    And I click on the button labeled "Save Changes"
    ##VERIFY
    Then I should see "Your survey settings were successfully saved!"

    ##ACTION Verify survey function in record
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label

    Given I clear field and enter "Name_survey" into the data entry form field labeled "Name"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey"

    ##VERIFY_DE
    Given I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see table rows containing the following values in the reports table:
      | A | All data (all records and fields) |

    And I click on the button labeled "View Report" in the row labeled "All data (all records and fields)"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Survey Timestamp | Name        |
      | 1         | mm-dd-yyyy hh:mm | Name_survey |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username            | Action          | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | [survey respondent] | Update Response | name = 'Name_survey'                    |
      | mm/dd/yyyy hh:mm | test_user1          | Manage/Design   | Set up survey                           |

    #FUNCTIONAL REQUIREMENT
    ##ACTION Survey Offline
    Given I click on the link labeled "Designer"
    And I click on the button labeled "Survey settings" in the row labeled "Text Validation"
    And I select "Survey Offline" on the dropdown field labeled "Survey Status"
    And I click on the button labeled "Save Changes"
    ##VERIFY
    Then I should see "Your survey settings were successfully saved!"
    And I should see "Survey settings"

    ##ACTION Verify no survey function in record
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 2" for record ID "2" and click on the bubble
    #VERIFY
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "Record ID 2 successfully edited"

    Given I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Thank you for your interest, but this survey is not currently active."
    And I click on the button labeled "Close survey"

    #VERIFY_LOG
    When I return to the REDCap page I opened the survey from
    And I click on the link labeled "Logging"
    Then I should see "This module lists all changes made to this project"
    And I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Modify survey info                      |
#END