Feature: B.2.33.4700.: The system shall display past and scheduled ACG alerts.---Project → ACG → Compliance Alert Logs

     As a REDCap Administrator 
     I want to see The system shall display past and scheduled ACG alerts.---Project → ACG → Compliance Alert Logs
        So that I can review the past and scheduled ACG alerts in the project.

        Scenario: #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.2.33.4700." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        And I click on the button labeled "Add user"
        Then I should see 'User "Test_User1" was successfully added'

        When I click on the link labeled "Control Center"
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
        And I wait for 1 second
        And I click on the button labeled "Upload or download ACGs"
        And I upload a "csv" format file located at "import_files/ACG_DownloadedGroups.csv", by clicking the button near "Upload ACGs (CSV)" to browse for the file
        And I click on the button labeled "Confirm Import"
        And I should see "Access Control Groups imported successfully"
        And I wait for 1 second
        And I click on the button labeled "Close"
        Then I should see a table header and rows containing the following values in a table:
            |ACG Name|
            |No Rights|
            |New_ACG_1|
            
        When I click on the first link labeled "Access Control Groups"
        And I wait for 1 second
        When I click on the link labeled "User Assignments"
        Then I should see a table header and rows containing the following values in a table:
        |Username       |Full Name       |Email                         |Access Control Group  |
        |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights          |
        |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights          |
        |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights          |
        |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights          |
        |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights          |
        |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights          |
        When I click on the button labeled "Upload or download user assignments"
        Then I should see the dropdown field labeled "Upload or download user assignments" with the options below
        | Upload user assignments (CSV)|
        When I upload a "csv" format file located at "import_files/ACG_NewRights_2.csv", by clicking the button near "Upload user assignments (CSV)" to browse for the file
        Then I should see a table header and rows containing the following values in a table:
        |Username       |ACG ID	        | Group Name (For Reference Only)    |
        |Test_User1     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        |Test_User2     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        |Test_User3     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        |Test_User4     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        |Test_User1     |Proposed: G-34CBF4FD07C0A| Proposed: New_ACG_2      |
        |Test_User2     |Proposed: G-34CBF4FD07C0A| Proposed: New_ACG_2      |
        |Test_User3     |Proposed: G-34CBF4FD07C0A| Proposed: New_ACG_2      |
        |Test_User4     |Proposed: G-34CBF4FD07C0A| Proposed: New_ACG_2      |
        When I click on the button labeled "Confirm Import"
        Then I should see "Access Control Groups User Assignments Successfully Completed"
        When I click on the button labeled "Close"
    
    Scenario: B.2.33.4700.: The system shall display past and scheduled ACG alerts.---Project → ACG → Compliance Alert Logs
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.33.4700."
        And I click on the link labeled "ACGs"
        Then I should see "Only REDCap administrators can access this page."
        And I should see "Project Compliance"

        When I click on the checkbox labeled "test_user1"
        And I click on the button labeled "Email User(s)"
        And I enter "Test" into the input field labeled "Subject:"
        When I enter "My email body content" into the textarea field labeled "Email Body:"
        And I click on the button labeled "Send Alerts"
        And I click on the button labeled "Ok"
    #Validate the alert is sent, the alert will be listed in the "Compliance Alert Logs" page with the correct information.
        When I click on the link labeled "Compliance Alert Logs"
        Then I should see a table header and rows containing the following values in a table:
       |Batch ID|Alert ID|Alert At|Alert Type|Alert Category|Affected Users          |Recipient                                  |Alert Text           |Alert Status|
       |        |1       |        |Initial   |Users         |test_user1 (Test User1) |Test_User1 (Test User1) Test_User1@test.edu|My email body content|Success|

#END