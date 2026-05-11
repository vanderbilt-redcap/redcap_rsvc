Feature: B.2.33.4200.: The system shall allow assigning Data Access Groups unless restricted by ACG.---User Rights → Add/Edit User
    
     As a REDCap end user
     I want to see the system allow assigning Data Access Groups unless restricted by ACG.
   
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


    Scenario: B.2.33.4200.: The system shall allow assigning Data Access Groups unless restricted by ACG.---User Rights → Add/Edit User
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.2.33.4200." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        And I click on the button labeled "Add user"
        Then I should see 'User "Test_User1" was successfully added'

        When I click on the link labeled "DAGs"
        Then I should see "Assign user to a group"

        #Validate DAG assignment works with manual assignment.
        When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
        When I select "TestGroup1" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"
        ##VERIFY: DAG assignment
        Then I should see a table header and rows containing the following values in a table:
        | Data Access Groups | Users in group |
        | TestGroup1         | test_user1     |

        ##VERIFY_LOG:
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Assign user to data access group        |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | user = 'test_user1'                     |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | group = 'TestGroup1'                    |

        #Validate DAG assignment works with CSV import.
        When I click on the link labeled "DAGs"
        Then I should see "Assign user to a group"
        And I click on the button labeled "Upload or download DAGs/User-DAG assignments"
        Then I should see "Upload User-DAG assignments (CSV)"
        When I click on the link labeled "Upload User-DAG assignments (CSV)"
        Then I should see "Upload User-DAG assignments (CSV)"
        Given I upload a "csv" format file located at "import_files/Dag_import_for_ACGs.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "Upload User-DAG assignments (CSV) - Confirm"
        And I should see a table header and rows containing the following values in a table:
        | username    | redcap_data_access_group   | 
        |test_admin   | test_admin | 
        | test_user1  | testgroup2 |      

        When I click on the button labeled "Upload"
        Then I should see "SUCCESS!"
        And I should see "2 User-DAG assignments were updated."
        When I click on the button labeled "Close"
        ##VERIFY_LOG:
        And I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Import User-DAG assignments             |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Assign user to data access group        |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | user = 'test_user1'                     |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | group = 'TestGroup2'                    |
        

#END