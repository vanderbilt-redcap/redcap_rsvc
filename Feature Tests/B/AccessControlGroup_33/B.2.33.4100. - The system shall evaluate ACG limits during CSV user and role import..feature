Feature: B.2.33.4100.: The system shall evaluate ACG limits during CSV user and role import.---Upload Users/Roles CSV
    
     As a REDCap end user
     I want to see the system evaluate ACG limits when importing users or roles via CSV.
   
    Scenario: #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on the button labeled "Enable Access Control Groups"
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
       
        When I click on the third link labeled "Access Control Groups"
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


    Scenario: B.2.33.4100.: The system shall evaluate ACG limits during CSV user and role import.---Upload Users/Roles CSV
        When I create a new project named "B.2.33.4100." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

    #Validate ACG limits during CSV user
        When I click on the link labeled "User Rights"
        And I click on the button labeled "Upload or download users, roles, and assignments"
        Then I should see "Upload users (CSV)"
        When I click on the link labeled "Upload users (CSV)"
        Then I should see a dialog containing the following text: "Upload users (CSV)"
        Given I upload a "csv" format file located at "import_files/User_import_for_ACGs.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "Error"
        And I should see "Errors occurred while processing your uploaded file, and thus it could not be successfully uploaded. Please fix the following errors and try again:"
        And I should see "Non-compliant Rights Detected [test_user1]: lock_record_customize, user_rights, data_quality_design, data_quality_execute"
        And I click on the button labeled "Close"
        Then I should see "Upload or download users, roles, and assignments"

    #Validate ACG limits during CSV for role import
        When I click on the link labeled "User Rights"
        And I click on the button labeled "Upload or download users, roles, and assignments"
        Then I should see "Upload users (CSV)"
        When I click on the link labeled "Upload users (CSV)"
        Then I should see a dialog containing the following text: "Upload users (CSV)"
        Given I upload a "csv" format file located at "import_files/User_import_for_ACG_roles.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "Error"
        And I should see "Errors occurred while processing your uploaded file, and thus it could not be successfully uploaded. Please fix the following errors and try again:"
        And I should see "Non-compliant Rights Detected"

#END