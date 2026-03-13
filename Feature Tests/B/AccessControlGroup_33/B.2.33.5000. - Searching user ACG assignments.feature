Feature: The system shall allow searching user ACG assignments.---User Assignments

    As a REDCap end user
    I want to see the system shall display a table of all users and their assigned ACGs.---User Assignments

    Scenario: Setup
        Given I login to REDCap with the user "Test_Admin"
        And  I click on the link labeled "Control Center"
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
    Scenario: B.2.33.5000.: The system shall allow searching user ACG assignments.---User Assignments
        When I enter "1" into the field with the placeholder text of "Search"
        Then I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group  |             
            |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights          | 

#END