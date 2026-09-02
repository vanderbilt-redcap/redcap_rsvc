Feature: A.2.33.4600.: The system shall restrict project creation and project copying to users whose ACG permits the User Rights privilege.---Project Creation & Copy
    As a REDCap end user I want to see project creation and project copy access enforced by ACG user_rights privilege.

Scenario: #SETUP        
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Yes, normal users can create new projects" on the dropdown field labeled "Allow normal users to create new projects?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    When I create a new project named "A.2.33.4600.SOURCE" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see "Your new REDCap project has been created"
    #Adding test user 1 to project.
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I click on the checkbox labeled "Project Design and Setup"
    And I click on the button labeled "Add user"
    Then I should see 'User "Test_User1" was successfully added'
    #Adding test user 2 to project.
    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I click on the checkbox labeled "Project Design and Setup"
    And I click on the button labeled "Add user"
    Then I should see 'User "Test_User2" was successfully added'

    When I click on the link labeled "Control Center"
    And I click on the link labeled "Access Control Groups"
    And I click on "Enable Access Control Groups"
    Then I should see "Enable the Access Control Groups feature?"
    When I click on the button labeled "Enable"
    Then I should see a table header and rows containing the following values in a table:
        |Username       |Full Name       |Email                         |Access Control Group  |
        |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights            |
        |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights            |
        |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights            |
        |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights            |
        |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights            |
        |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights            |

    #Create a new ACG without project creation rights
    When I click on the tab labeled "Access Control Groups"
    And I enter "New_ACG_1" into the input field labeled "Create new Access Control Group"
    And I click on "Create ACG"
    And I click on the radio labeled "No (overrides the user-level setting)"
    And I click on the checkbox labeled "Project Design and Setup"
    And I click on the checkbox labeled "Data Access Groups"
    And I click on the checkbox labeled "Manage MyCap Participants"
    And I click on the checkbox labeled "Survey Distribution Tools"
    And I click on the checkbox labeled "Alerts & Notifications"
    And I click on the checkbox labeled "Calendar & Scheduling"
    And I click on the checkbox labeled "Add/Edit/Organize Reports"
    And I click on the checkbox labeled "Stats & Charts"
    And I click on the checkbox labeled "Data Import Tool"
    And I click on the checkbox labeled "Data Comparison Tool"
    And I click on the checkbox labeled "Logging"
    And I click on the checkbox labeled "Email Logging"
    And I click on the checkbox labeled "File Repository"
    And I click on the checkbox labeled "Create Records"
    And I click on the checkbox labeled "Rename Records"
    And I click on the checkbox labeled "Delete Records"
    And I click on the radio labeled "View & Edit + Edit Survey Responses + Delete"
    And I click on the radio labeled "Full Data Set"
    And I click on the button labeled "Save Group"
    Then I should see a table header and rows containing the following values in a table:
        |ACG Name|
        |No Rights|
        |New_ACG_1|

    #Create a new ACG with project creation rights
    When I click on the link labeled "User Assignments"
    And I click on the tab labeled "Access Control Groups"
    And I enter "New_ACG_2" into the input field labeled "Create new Access Control Group"
    And I click on "Create ACG"
    And I click on the radio labeled "Yes (overrides the user-level setting)"
    And I click on the checkbox labeled "Project Design and Setup"
    And I click on the radio labeled "Full Access"
    And I click on the checkbox labeled "Data Access Groups"
    And I click on the checkbox labeled "Manage MyCap Participants"
    And I click on the checkbox labeled "Survey Distribution Tools"
    And I click on the checkbox labeled "Alerts & Notifications"
    And I click on the checkbox labeled "Calendar & Scheduling"
    And I click on the checkbox labeled "Add/Edit/Organize Reports"
    And I click on the checkbox labeled "Stats & Charts"
    And I click on the checkbox labeled "Data Import Tool"
    And I click on the checkbox labeled "Data Comparison Tool"
    And I click on the checkbox labeled "Logging"
    And I click on the checkbox labeled "Email Logging"
    And I click on the checkbox labeled "File Repository"
    And I click on the checkbox labeled "Create Records"
    And I click on the checkbox labeled "Rename Records"
    And I click on the checkbox labeled "Delete Records"
    And I click on the radio labeled "View & Edit + Edit Survey Responses + Delete"
    And I click on the radio labeled "Full Data Set"
    And I click on the button labeled "Save Group"
    Then I should see a table header and rows containing the following values in a table:
        |ACG Name|
        |No Rights|
        |New_ACG_1|

    When I click on the link labeled "User Assignments"
    Then I should see a table header and rows containing the following values in a table:
        |Username       |Full Name       |Email                         |Access Control Group  |
        |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights          |
        |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights          |
        |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights          |
        |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights          |
        |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights          |
        |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights          |

    When I click on the tab labeled "Access Control Groups"
    And I click on the link labeled "User Assignments"
    And I click on the button labeled "Enter edit mode"
    Then I should see "Exit edit mode"

    #Assigning User 1 to new acg 1
    When I click on the button labeled "No Rights (G-NORIGHTS)" in the column labeled "Access Control Group" and the row labeled "Test_User1"
    Then I should see the dropdown field labeled "Upload or download user assignments" with the options below
        |New_ACG_1|
        |New_ACG_2|
    When I click on the link labeled "New_ACG_1"
    Then I should see "Success"
    And I should see "User group updated successfully"

    #Assigning User 2 to new acg 2
    When I click on the button labeled "No Rights (G-NORIGHTS)" in the column labeled "Access Control Group" and the row labeled "Test_User2"
    Then I should see the dropdown field labeled "Upload or download user assignments" with the options below
        |New_ACG_1|
        |New_ACG_2|
    When I click on the link labeled "New_ACG_2"
    Then I should see "Success"
    And I should see "User group updated successfully"

    When I click on the link labeled "My Projects"
    And I logout
    Then I should see "Log In"

Scenario: A.2.33.4600.100: Copying a project is blocked for users with incorrect ACG User Rights privilege.
    Given I login to REDCap with the user "Test_User1"
    And I wait for 5 seconds
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.2.33.4600.SOURCE"
    And I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Copy the project" that is disabled

Scenario: A.2.33.4600.200: The system shall restrict project creation and project copying to users whose ACG permits the User Rights privilege.---Project Creation & Copy
    Given I logout
    And I login to REDCap with the user "Test_User1"
    Then I should NOT see a link labeled "New Project"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.2.33.4600.SOURCE"
    And I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Copy the project" that is disabled

    When I click on the link labeled "My Projects"
    Given I logout
    And I login to REDCap with the user "Test_User2"
    Then I should see a link labeled "New Project"
    When I create a new project named "A.2.33.4600.ALLOW" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see "Your new REDCap project has been created"

    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.2.33.4600.SOURCE"
    And I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Copy the project"
    When I click on the button labeled "Copy the project"
    And I enter "A.2.33.4600.COPY.ALLOW" into the input field labeled "Project title:"
    And I click on the link labeled "Select All"
    And I click on the button labeled "Copy project"
    Then I should see "COPY SUCCESSFUL!"

#End    