Feature: The system shall allow importing user-to-ACG assignments via CSV.---User Assignments → Upload
   
    As a REDCap end user
    I want to see that project level importing of user-to-ACG assignments as CSV is available and working as expected

    Scenario: #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.2.33.2800." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
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
            
    Scenario: B.2.33.2800. The system shall allow importing user-to-ACG assignments via CSV.---User Assignments → Upload
        # The following line is only necessary for automated testing due to quirk of the way the upload file feature works on this page.
        And I click on the first link labeled "Access Control Groups"
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
        When I upload a "csv" format file located at "import_files/ACG_NewRights.csv", by clicking the button near "Upload user assignments (CSV)" to browse for the file
        Then I should see a table header and rows containing the following values in a table:
        |Username       |ACG ID	        | Group Name (For Reference Only)      |
        |Test_Admin     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        |Test_User1     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        |Test_User2     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        |Test_User3     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        |Test_User4     |Proposed: G-3C93B88E4D202| Proposed: New_ACG_1      |
        When I click on the button labeled "Confirm Import"
        Then I should see "Access Control Groups User Assignments Successfully Completed"
        When I click on the button labeled "Close"
    #Validate that the user-to-ACG assignments were updated as expected in the table
        Then I should see a table header and rows containing the following values in a table:
        |Username       |Full Name       |Email                         |Access Control Group  |
        |site_admin     |Joe User        |joe.user@projectredcap.org    | New_ACG_1      |
        |Test_Admin     |Admin User      |test_admin@test.edu           | New_ACG_1      |
        |Test_User1     |Test User1      |Test_User1@test.edu           | New_ACG_1      |
        |Test_User2     |Test User2      |Test_User2@test.edu           | New_ACG_1      |
        |Test_User3     |Test User3      |Test_User3@test.edu           | New_ACG_1      |
        |Test_User4     |Test User4      |Test_User4@test.edu           | New_ACG_1      |
#END        