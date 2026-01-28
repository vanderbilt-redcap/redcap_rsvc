Feature: B.6.11.0600. Project status Project Settings: The system shall allow project-level override of the record limit for development projects.

As a REDCap end user
I want to see that My Project is functioning as expected

Scenario: #SETUP
    #Set global limit in control center to 0
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    And I enter "0" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    
    #Create project and set project level record limit
    When I create a new project named "B.6.11.0600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
    When I click on the link labeled "Edit Project Settings"
    Then I should see "Record Limit:"
    And I enter "5" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"

Scenario: B.6.11.0600.0100. - Given a project-level override is set to 5 records, then the system shall enforce that limit instead of the system-wide value.
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0600"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 4 of 5 test records allowed while in Development status"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 5 successfully added"

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_admin | Create record5 | record_id = '5'   |
        
    #Action/Validation: Adding new record when max record limit is set.
    When I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 5 of 5 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 5 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"
    
Scenario: B.6.11.0600.0200. - Given the override is set to zero (inherit), then the system shall apply the global setting defined in the Control Center.
    #Set project limit to 0
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0600"
    And I click on the link labeled "Edit Project Settings"
    Then I should see "Record Limit:"
    And I enter "0" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"

    #Set global restriction to 6
    When I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    And I enter "6" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #Add new record
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0600"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 5 of 6 test records allowed while in Development status"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 6 successfully added"

    #Validation that another records can not be added
    When I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 6 of 6 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 6 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"

 Scenario: B.6.11.0600.0300. - Given the override is updated after project creation, the new limit shall take effect immediately for record creation logic.
    #Set limit in project to 7 (PROJECT OVERRIDE)
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0600"
    And I click on the link labeled "Edit Project Settings"
    Then I should see "Record Limit:"
    And I enter "7" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"
    
   #Action: Attempting to add record #7 after changing the override to 7 (PROJECT OVERRIDE)
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0600"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 6 of 7 test records allowed while in Development status"
    When I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 7 successfully added"

    #Action: Attempting to add record #8 after changing the override to 7 (PROJECT OVERRIDE)
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0600"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 7 of 7 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 7 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"

#END