Feature: B.6.11.0700 Project Settings: The system shall retain project-level record limit settings when a production project is moved back into development status.

As a REDCap Administrator
I want to verify that record limit settings persist appropriately when moving a project between production and development

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
    When I create a new project named "B.6.11.0700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
    And I click on the link labeled "Edit Project Settings"
    Then I should see "Record Limit:"
    And I enter "5" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"
    #Moving project to prduction
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0700"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"
    #Adding record 5
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 5 successfully added"
    #Adding record 6
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 6 successfully added"

Scenario: B.6.11.0700.0100. - A project that had a record limit, when moved from production back to development, should retain the prior setting
    Given I click on the link labeled "Setup"
    And  I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move back to Development status"
    Then I should see "Project status:  Development"
    #Validation ensure new records can't be added
    When I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 6 of 5 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 5 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"

Scenario: B.6.11.0700.0200. - A project with no prior limit, when moved from production to development, should apply the global setting
    #Create project and do not set project level record limit
    When I click on the link labeled "REDCap"
    And I create a new project named "B.6.11.0700.0200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
    Then I should see "Your new REDCap project has been created"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"
    #Set global limit in control center to 3
    When I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    And I enter "3" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    #Action move project back to development.
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0700.0200"
    And I click on the link labeled "Setup"
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move back to Development status"
    Then I should see "Project status:  Development"
    #Action try entering a record when project is already over limit.
    When I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 4 of 3 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 3 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"

Scenario: B.6.11.0700.0300. - If an admin removed the override in production, the system should revert to default behavior upon return to development
    #Action move project to prduction
    When I click on the link labeled "REDCap"
    And I click on the link labeled "B.6.11.0700.0200"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"
    #Action remove global record limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    And I enter "0" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    #Action move project back to development.
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.0700.0200"
    And I click on the link labeled "Setup"
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move back to Development status"
    Then I should see "Project status:  Development"
    #Action add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 5 successfully added"

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_admin | Create record5 | record_id = '5'   |

#END