Feature: B.6.11.0900. User Interface: The system shall log record limit changes in the User Activity Log

As a REDCap end user
I want to see that My Project is functioning as expected

Scenario: B.6.11.0900.0100. - If a REDCap Admin changes the Record Limit in the Edit Project Setting it will be logged in the Control Center inside the User Activity Log
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.11.0900" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
    Then I should see "Your new REDCap project has been created and is ready to be accessed."

    When I click on the link labeled "Edit Project Settings"
    Then I should see "Record Limit:"
    And I enter "5" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"

    #VERIFY: in User Activity Log 
    When I click on the link labeled "Control Center"  
    And I click on the link labeled "User Activity Log"
    Then I should see "All User Activity for Today"  
    And I should see a table header and rows containing the following values in a table:
         || Time             | User       | Event                                      |
         || mm/dd/yyyy hh:mm | test_admin | Modify settings for single project (PID 13)|
    
#END