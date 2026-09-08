Feature: A.2.33.1400.: The system shall allow editing privileges of the “No Rights” ACG.---Control Center → Edit ACG

As an Admin I want to see that the system allows editing privileges of the “No Rights” access control groups effectively.
    Scenario: A.2.33.1400.: The system shall allow editing privileges of the “No Rights” ACG.---Control Center → Edit ACG
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
        Then I should see a table header and rows containing the following values in a table:
            |ACG Name   |
            |No Rights  |
        
        When I click on the link labeled "No Rights"
        And I click on the checkbox labeled "Project Design and Setup"
        And I click on the button labeled "Save Group"
        
    #Validate the modification to ACG is successful and the updated privileges are displayed in the ACG listing page
        Then I should see "Access Control Group saved successfully!"
        Then I should see an icon labeled "Full Access" in the column labeled "Project Design and Setup" and the row labeled "No Rights"

#End