Feature: A.2.33.0500.: The system shall allow editing existing ACGs.---Control Center → Access Control Groups
    As an Admin
    I want to see that I can edit an already created ACG.

    Scenario: A.2.33.0500.: The system shall allow editing existing ACGs.---Control Center → Access Control Groups
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
        Then I should see an icon labeled "No Access" in the column labeled "Project Design and Setup" and the row labeled "No Rights"
        And I click on the link labeled "No Rights"
        And I click on the checkbox labeled "Project Design and Setup"
        And I click on the button labeled "Save Group"
        Then I should see "Access Control Group saved successfully!"
        Then I should see an icon labeled "Full Access" in the column labeled "Project Design and Setup" and the row labeled "No Rights"
#END