Feature: A.6.11.0500. Control Center: The system shall restrict the number of test records that can be created in a project with development status based on the configured limit.
As a REDCap end user
I want to see that My Project is functioning as expected

Scenario: #SETUP
    #Set limit in control center to 0 = No limit
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    And I enter "0" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    
    #Create Project

Scenario: A.6.11.0500.0100. - Given no record limit is set in the Control Center, then projects default to no restriction or system default value.
    When I create a new project named "A.6.11.0500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
    And I click on the link labeled "Add / Edit Records"
    Then I should NOT see "You are currently using 4 of 5 test records allowed while in Development status"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 5 successfully added"

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_admin | Create record5 | record_id = '5'   |

Scenario: A.6.11.0500.0200. - Given a system-wide limit is set (e.g., 3 records), then new development-mode projects shall block creation of a 4th record.
    #Set limit in control center to 5
    When I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    When I enter "5" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
   
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.11.0500.100"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 5 of 5 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 5 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"


Scenario: A.6.11.0500.0300. - Given a project already exceeds the system limit, and the global setting is enabled, then the project shall prevent further record creation but retain existing records.
    #Set limit in control center to 0 = No limit
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    And I enter "0" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    #Add new record
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.11.0500.100"
    And I click on the link labeled "Add / Edit Records"
    Then I should NOT see "You are currently using 5 of 5 test records allowed while in Development status"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 6 successfully added"
    #Set limit in control center to 5
    When I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    When I enter "5" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
   
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.11.0500.100"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 6 of 5 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 5 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"

    #Verify records were retained
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
        | Record ID |
        | 1         |
        | 2         |
        | 3         |
        | 4         |
        | 5         |
        | 6         |

#END