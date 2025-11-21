Feature: B.3.14.1100. The system shall allow users to delete all data in an event for a given record from the Record Home Page. 

  As a REDCap end user
  I want to see that delete all data is functioning as expected

  Scenario: B.3.14.1100.100 Delete all data in an event for a given record
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
    And I create a new project named "B.3.14.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #SET UP_USER_RIGHTS
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    ##VERIFY - COUNT OF ROWS
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see the report with 19 rows

    #FUNCTIONAL_REQUIREMENT
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "1"

    ###ACTION delete this event
    Given I click the "X" icon for the row labeled "Delete all data on event:" on the event column labeled "Event 1"
    Then I should see a dialog containing the following text: 'DELETE ALL DATA ON THIS EVENT FOR RECORD "1"?'

    Given I click on the button labeled "Delete this event" in the dialog box
    Then I should see "Record ID 1 successfully deleted entire event of data"

    #VERIFY
    Given I click on the link labeled "Record Status Dashboard"
    Then I should see the "Incomplete (no data saved)" icon for the "Text Validation" longitudinal instrument on event "Event 1" for record "1"
    And I should see the "Incomplete (no data saved)" icon for the "Data Types" longitudinal instrument on event "Event 1" for record "1"
    And I should see the "Incomplete (no data saved)" icon for the "Consent" longitudinal instrument on event "Event 1" for record "1"

    #VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Update record1 | data_types_complete = ''                |
      | mm/dd/yyyy hh:mm | test_user1 | Update record1 | dob = ''                                |
      | mm/dd/yyyy hh:mm | test_user1 | Update record1 | email = ''                              |
      | mm/dd/yyyy hh:mm | test_user1 | Update record1 | email_consent = ''                      |
      | mm/dd/yyyy hh:mm | test_user1 | Update record1 | name_consent = ''                       |
      | mm/dd/yyyy hh:mm | test_user1 | Update record1 | text_validation_complete = ''           |

    ##VERIFY - COUNT OF ROWS
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    #Notice how we have 2 less rows than line 42 because we have removed an entire event from a Record
    When I click on the button labeled "View Report"
    Then I should see the report with 17 rows
#END