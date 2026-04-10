Feature: A.2.33.3200.: The system shall reject ACG CSV uploads containing invalid usernames.---User Assignments → Upload CSV
   
    As a REDCap end user
    I want to see that the system rejects ACG CSV uploads containing invalid usernames and displays an appropriate error message.

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
        And I click on the button labeled "Save Group"
        Then I should see "Access Control Group saved successfully!"
        And I should see a table header and rows containing the following values in a table:
            |ACG Name|
            |No Rights|
            |New_ACG_1|
            
    Scenario: A.2.33.3200.: The system shall reject ACG CSV uploads containing invalid usernames.---User Assignments → Upload CSV
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
        When I upload a "csv" format file located at "import_files/ACG_NewRights_nonuser.csv", by clicking the button near "Upload user assignments (CSV)" to browse for the file
        Then I should see "Validation Error(s)"
        And I should see "Invalid value for username at row 0"

        When I click on the button labeled "Close"
        Then I should NOT see "Test_Admin_10"

#END        