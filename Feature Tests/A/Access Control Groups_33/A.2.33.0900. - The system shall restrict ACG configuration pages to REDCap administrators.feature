Feature: A.2.33.0900: The system shall restrict ACG configuration pages to REDCap administrators.---Control Center

    As an Admin
    I want to verify that only REDCap administrators can access Access Control Groups configuration pages.

    Scenario: A.2.33.0900.100 Admin user can access ACG configuration pages
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
       

    Scenario: A.2.33.0900.200 Non-admin user cannot access ACG configuration pages
        Given I login to REDCap with the user "Test_User1"
        Then I should NOT see "Control Center"

    #END
        