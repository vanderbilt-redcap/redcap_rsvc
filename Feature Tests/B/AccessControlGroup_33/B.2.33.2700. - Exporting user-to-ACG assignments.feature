Feature: The system shall allow exporting user-to-ACG assignments as CSV.---User Assignments → Export
   
    As a REDCap end user
    I want to see that project level exporting of user-to-ACG assignments as CSV is available and working as expected

    Scenario: #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.2.33.2700." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        And I click on the button labeled "Add user"
        Then I should see 'User "Test_User1" was successfully added'

        When I click on the link labeled "Control Center"
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
        Then I should see "Creating New Access Control Group New_ACG_1"

        When I click on the button labeled "Save Group"
        Then I should see a table header and rows containing the following values in a table:
            |ACG Name|
            |No Rights|
            |New_ACG_1|
            
    Scenario: B.2.33.2700. The system shall allow exporting user-to-ACG assignments as CSV.---User Assignments → Export
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
        | Download user assignments (CSV)|
        When I click on the link labeled "Download user assignments"
        Then I should see the following values in the last file downloaded
            | Username   | ACG ID     | Group Name |
            | site_admin | G-NORIGHTS | No Rights  |
            | Test_User1 | G-NORIGHTS | No Rights  |
            | Test_User2 | G-NORIGHTS | No Rights  |
            | Test_User3 | G-NORIGHTS | No Rights  |
            | Test_User4 | G-NORIGHTS | No Rights  |
            | Test_Admin | G-NORIGHTS | No Rights  |

#END    
