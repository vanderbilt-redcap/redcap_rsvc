Feature: The system shall reapply ACG rules when ACGs are re-enabled.---System-Level Enforcement
   
    As a REDCap end user
    I want to see that the system shows ACG functionality when ACGs are re-enabled.---System-Level (Control Center + All Projects)

    Scenario: #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.2.33.1200." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"
        And I should NOT see "ACG"
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
        #Validate that the ACG functionality is present when ACGs are enabled
        Then I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group  |   
            |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights          | 
            |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights          |            
            |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights          | 
            |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights          | 
            |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights          | 
            |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights          |
       
        #Validate that the ACG functionality is present when ACGs are enabled at the project level
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.33.1200."
        Then I should see "ACGs"  
        When I click on the link labeled "ACGs"
        Then I should see "NOTICE: Only REDCap administrators can access this page."
        And I should see "Project Compliance"
        And I should see "Compliance Alert Logs"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on the button labeled "ACG enabled"
        And I click on the button labeled "Disable"
        #Validate that the ACG functionality is not present when ACGs are disabled in the control center.
        Then I should see "Enable Access Control Groups"
        #Validate that the ACG functionality is not present when ACGs are disabled at the project level
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.33.1200."
        Then I should NOT see "ACGs"

     Scenario: A.2.33.1200. The system shall reapply ACG rules when ACGs are re-enabled.---System-Level Enforcement
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on "Enable Access Control Groups"
        Then I should see "Enable the Access Control Groups feature?"
        When I click on the button labeled "Enable"
        #Validate that the ACG functionality is present when ACGs are re-enabled
        Then I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group  |   
            |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights          | 
            |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights          |            
            |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights          | 
            |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights          | 
            |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights          | 
            |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights          |
        #Validate that the ACG functionality is present when ACGs are re-enabled at the project level
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.33.1200."
        Then I should see "ACGs" 
        When I click on the link labeled "ACGs"
        Then I should see "NOTICE: Only REDCap administrators can access this page."
        And I should see "Project Compliance"
        And I should see "Compliance Alert Logs"
# #END    
