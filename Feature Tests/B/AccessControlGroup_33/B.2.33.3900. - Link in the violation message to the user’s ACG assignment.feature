Feature: The system shall provide a link in the violation message to the user’s ACG assignment.---ACG Violation Modal
    
     As a REDCap end user
     I want to see the system provide a link in the violation message to the user’s ACG assignment when trying to assign privileges that exceed the user's ACG.
   
    Scenario: #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on "Enable Access Control Groups"
        Then I should see "Enable the Access Control Groups feature?"
        When I click on the button labeled "Enable"
        Then I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group  |   
            |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights          | 
            |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights          |            
            |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights          | 
            |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights          | 
            |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights          | 
            |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights          |
       
        When I click on the tab labeled "Access Control Groups"
        And I enter "New_ACG_1" into the input field labeled "Create new Access Control Group"
        And I click on "Create ACG"
        And I click on the checkbox labeled "Project Design and Setup"
        And I click on the checkbox labeled "Data Access Groups"
        And I click on the checkbox labeled "Manage MyCap Participants"
        And I click on the checkbox labeled "Survey Distribution Tools"
        And I click on the checkbox labeled "Alerts & Notifications"
        And I click on the checkbox labeled "Calendar & Scheduling"
        And I click on the checkbox labeled "Add/Edit/Organize Reports"
        And I click on the checkbox labeled "Stats & Charts"
        And I click on the checkbox labeled "Data Import Tool"
        And I click on the checkbox labeled "Data Comparison Tool"
        And I click on the checkbox labeled "Logging"
        And I click on the checkbox labeled "Email Logging"
        And I click on the checkbox labeled "File Repository"
        And I click on the checkbox labeled "Create Records"
        And I click on the checkbox labeled "Rename Records"
        And I click on the checkbox labeled "Delete Records"
        And I click on the radio labeled "View & Edit + Edit Survey Responses + Delete"
        And I click on the radio labeled "Full Data Set"
        Then I should see "Creating New Access Control Group New_ACG_1"
        When I click on the button labeled "Save Group"
        Then I should see a table header and rows containing the following values in a table:
            |ACG Name|
            |No Rights|
            |New_ACG_1|
            
        When I click on the link labeled "User Assignments"
        And I click on the button labeled "Enter edit mode"
        Then I should see "Exit edit mode"
        When I click on the button labeled "No Rights (G-NORIGHTS)" in the column labeled "Access Control Group" and the row labeled "Test_User1"
        Then I should see the dropdown field labeled "Upload or download user assignments" with the options below
        |New_ACG_1|
        When I click on the link labeled "New_ACG_1"
        Then I should see "Success"
        And I should see "User group updated successfully"
        When I click on the button labeled "Exit edit mode"
        Then I should see "Enter edit mode"

        When I create a new project named "B.2.33.3900." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"



    Scenario: B.2.33.3900.: The system shall provide a link in the violation message to the user’s ACG assignment.---ACG Violation Modal
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        And I click on the button labeled "Add user"
        Then I should see 'User "Test_User1" was successfully added'
        
        When I enter "Test_User2" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        And I click on the button labeled "Add user"
    #Validate that the system provide a link in the violation message to the user’s ACG assignment.
        Then I should see 'Non-compliant Rights Detected'
        And I should see "The user privileges below do not comply with the user's Access Control Group privileges. The user cannot be given any of the privileges below and cannot be assigned to a user role that has any of these privileges. Please try again."
        And I should see 'View ACG assignment in the Control Center for the user "Test_User2"'
        And I should see "data_export_instruments (i.e., form-level data export rights)"
        And I should see "file_repository"
        And I should see "graphical"
        And I should see "reports"
        And I should see "calendar"
        And I should see "data_entry (i.e., form-level data viewing rights)"
        And I should see "record_create"
        And I should see "participants"

        When I click on the link labeled 'View ACG assignment in the Control Center for the user "Test_User2"'
        Then I should see "Access Control Groups"
        And I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group  |   
            |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights          | 

#END