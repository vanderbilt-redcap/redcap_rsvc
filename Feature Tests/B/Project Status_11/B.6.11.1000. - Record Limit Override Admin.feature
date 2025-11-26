Feature: B.6.11.1000. User Interface: The system shall allow the REDCap Administrator to override Record Limits when create or copying a project
# This record override is only applicable when set at the global level. This is the case because project level record limits are specific to that project, so the copised project would not have the project record limit already set. 

As a REDCap end user
I want to see that My Project is functioning as expected

Scenario: #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.11.1000" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
    Then I should see "Your new REDCap project has been created and is ready to be accessed."
    
    #Set global limit in control center to 0 and Project level to 3
    When I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    And I enter "3" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario:B.6.11.1000.0100. Allow admin to copy project that exceeds record limit
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.1000"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 4 of 3 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 3 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"
    When I click on the link labeled "Setup"  
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Copy the Project"
    And I click on the link labeled "Select All"
    And I enter "B.6.11.1000.copy" into the input field labeled "Project title:"
    And I click on the button labeled "Copy project"
    Then I should see "Your REDCap project has been copied, and an exact duplicate was generated, which is already loaded and ready for you here."
    #Adding user rights for Test_User1
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled "Assign"
    Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
    #Verify limit is still set to 3 on new project
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.1000.copy"  
    And I click on the link labeled "Add / Edit Records"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 3 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"
    And I logout
     
    #Verify Non-Admin can not copy project already over record limit. 
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.11.1000.copy"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 4 of 3 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 3 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"
    When I click on the link labeled "Setup"  
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Copy the Project"
    Then I should see a checkbox labeled "All records" that is disabled
    And I should see "All records (4 records total)"
    And I should see "Note: The records cannot be copied to the new project because the amount exceeds the max number of records that a development project may have."
    When I enter "B.6.11.1000.copy2" into the input field labeled "Project title:"
    And I click on the button labeled "Copy project"
    Then I should see "Your REDCap project has been copied, and an exact duplicate was generated, which is already loaded and ready for you here."
    
    #Verify data didn't come over with project copy
    When I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 0 of 3 test records allowed while in Development status"
    And I should NOT see "NOTICE: No new records can be created since this project has already met the limit of 3 records while in Development status."
    And I should see the button labeled "Add new record for the arm selected above"
    And I logout

Scenario: B.6.11.1000.0200. Allow admin to create new project with XML that exceeds record limit
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Record Limit:"
    And I enter "3" into the input field labeled "Record Limit:Set the maximum number of records that can be created while a project is in development status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    When I click on the link labeled "My Projects"
    And I create a new project named "B.6.11.1000.0200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
    Then I should see "Your new REDCap project has been created and is ready to be accessed."

    #VERIFY The number of records is over max
    When I click on the link labeled "Add / Edit Records"
    Then I should see "You are currently using 4 of 3 test records allowed while in Development status"
    And I should see "NOTICE: No new records can be created since this project has already met the limit of 3 records while in Development status."
    And I should NOT see the button labeled "Add new record for the arm selected above"
    And I click on the link labeled "REDCap"
    And I logout

    #VERIFY Non-Admin can not create a proejct with XML over max record limit
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "B.6.11.1000.0200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
    Then I should see "Projects are not allowed to have more than 3 records while in Development status. Thus, you will not be allowed to create a new project that initially contains 4 records, as found in the Project XML file you are attempting to import. If you have questions regarding this, please contact your REDCap administrator."


#END
