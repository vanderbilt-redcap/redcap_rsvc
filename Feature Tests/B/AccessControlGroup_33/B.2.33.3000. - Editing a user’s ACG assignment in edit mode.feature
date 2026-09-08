Feature: B.2.33.3000.: The system shall allow editing a user’s ACG assignment.---User Assignments → Edit ModeThe system shall allow editing a user's ACG assignment.---User Assignments → Edit Mode
   
    As a REDCap end user
    I want to see the system shall allow editing a user's ACG assignment.
    # New Scenarios added on 8/24/26 to account for the following change log item:
    # Requirement: URS.33.3000.
    # FRS: B.2.33.3000.
    # Related Change Log: 14792
    Scenario: #SETUP
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
        And I enter "New_ACG_1" into the input field labeled "Create new Access Control Group"
        And I click on "Create ACG"
        And I click on the checkbox labeled "Project Design and Setup"
        Then I should see "Creating New Access Control Group New_ACG_1"

        When I click on the button labeled "Save Group"
        Then I should see a table header and rows containing the following values in a table:
            |ACG Name|
            |No Rights|
            |New_ACG_1|
            
    Scenario: B.2.33.3000.100. Change an existing user's ACG assignment from Access Control Groups → User Assignments → Edit Mode.
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
    #Validate that the user's ACG assignment has been updated in the table
        And I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group  |   
            |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights          | 
            |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights          |            
            |Test_User1     |Test User1      |Test_User1@test.edu           | New_ACG_1         | 
            |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights          | 
            |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights          | 
            |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights          |
       
    Scenario: B.2.33.3000.200. Assign an ACG when creating a new table-based user.
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Add Users (Table-based Only)"
        Then I should see "Create single user"

        When I enter "ACG_Table_User" into the input field labeled "Username:"
        And I enter "ACG" into the input field labeled "First name:"
        And I enter "TableUser" into the input field labeled "Last name:"
        And I enter "ACG_Table_User@test.edu" into the input field labeled "Primary email:"
        And I select "New_ACG_1" on the dropdown field labeled "No Rights"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."

        When I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        Then I should see a table header and rows containing the following values in a table:
            |Username        |Full Name        |Email                      |Access Control Group|
            |ACG_Table_User   |ACG TableUser    |ACG_Table_User@test.edu    | New_ACG_1          |

    Scenario: B.2.33.3000.300. Change an existing user's ACG from the Control Center Edit User page.
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Browse Users"
        And I click on the link labeled "View User List By Criteria"
        And I enter "Test_User1" into the field with the placeholder text of "Keyword search"
        And I click on the button labeled "Display User List"

        When I click on the link labeled "test_user1"
        Then I should see "Editable user attributes"
        And I click on the button labeled "Edit user info"
        And I select "No Rights" on the dropdown field labeled "No Rights"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."

        When I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        Then I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group|
            |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights          |
#END