Feature: A.2.67.0200. Control Center: The system shall allow REDCap users to be designated as project-level administrators for a Project Administrator Group to manage administrative responsibilities for assigned projects

  As a REDCap system administrator and Project Administrator
  I want to see that the Project Administrator Group (PAG) functionality allows me to assign and manage project-level administrators for specific groups

  Scenario: A.2.67.0200.100 Create a PAG and Assign a REDCap user as a PAG administrator
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "REDCap Plus"
    And I click on the button labeled "Enter a REDCap+ subscription key"
    And I enter a REDCap+ subscription key into the textarea field labeled "Enter a REDCap+ subscription key"
    And I click on the button labeled "Save key"
    Then I should see "REDCap+ subscription activated!"

    When I click on the button "OK"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    And I click on "Create new PAG"
    Then I should see "Create new Project Administrator Group"

    When I enter "New PAG 1" into the field with the placeholder text of "Enter name for new PAG"
    And I enter "Test_User1" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Create new PAG"
    Then I should see "PAG successfully created!"
    Then I should see a table header and rows containing the following values in a table:
          |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
          |New PAG 1                    |Test_User1 (Test User1)     |0                          | 0                      |1        |


  Scenario: A.2.67.0200.200 Assign multiple administrators to one PAG
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    
    When I click on the button labeled "Add or remove admins" 
    And I click on the button labeled "Assign user to PAG as project-level admin"
    And I enter "Test_User2" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Assign user as project-level admin"
    Then I should see "User assigned successfully as a project-level admin!"
    Then I should see a table header and rows containing the following values in a table:
        |Username       |Name         | Remove | 
        |test_user1     |Test User1   |        |
        |test_user2     |Test User2   |        |

    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
          |Project Administrator Group  |Project-level Admins                                 |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
          |New PAG 1                    |Test_User1 (Test User1), Test_User2 (Test User2)     |0                          | 0                      |1        |


  Scenario: A.2.67.0200.300 Assign one administrator to multiple PAGs
    Given I click on "Create new PAG"
    And I enter "New PAG 2" into the field with the placeholder text of "Enter name for new PAG"
    And I enter "Test_User1" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Create new PAG"
    Then I should see "PAG successfully created!"
    Then I should see a table header and rows containing the following values in a table:
          |Project Administrator Group  |Project-level Admins                                 |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
          |New PAG 1                    |Test_User1 (Test User1), Test_User2 (Test User2)     |0                          | 0                      |1        |
          |New PAG 2                    |Test_User1 (Test User1)                              |0                          | 0                      |2        |


  Scenario: A.2.67.0200.400 Delegated administrative functions are available for assigned projects
   #Create a project for PAG Admin
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "New Project"
    And I enter "PAG Admin Project" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "Your new REDCap project has been created"
    And I should see "PAG Admin Project"

    #Create a project for No PAG Access
    Given I click on the link labeled "REDCap"
    And I click on the link labeled "New Project"
    And I enter "No PAG Access" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "Your new REDCap project has been created"
    And I should see "No PAG Access"

    #Assigning project to pag
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "View & Manage" 
    And I click on the button labeled "Add project"
    And I click on "Search for a project..."
    And I click on "PAG Admin Project"
    And I click on the button labeled "Assign"
    Then I should see "Project assigned successfully!"
    And I should see a table header and rows containing the following values in a table:
        |PID        |Project Title           | Remove | 
        |13         |PAG Admin Project       |        |


  Scenario: A.2.67.0200.500 Authentication and system-wide administration remain unavailable
    Given I login to REDCap with the user "Test_User1" 
    And I click on the link labeled "Control Center"
    Then I should see "Control Center Home"
    And I should see "To-Do List"
    And I should see "Browse Projects"
    And I should see "Edit Project Settings"
    And I should see "API Tokens"
    And I should NOT see "Notifications & Reporting"
    And I should NOT see a link labeled "Administrator Resources"
    And I should NOT see a link labeled "Dashboards & Activity"
    And I should NOT see a link labeled "Link Lookup"
    And I should NOT see a link labeled "Project Migration Dashboard"
    And I should NOT see a link labeled "Add Users (Table-based Only)"
    And I should NOT see a link labeled "User Allowlist"
    And I should NOT see a link labeled "Email Users"
    And I should NOT see a link labeled "Administrator Privileges"
    And I should NOT see a link labeled "Access Control Groups"
    And I should NOT see a link labeled "Miscellaneous Modules"
    And I should NOT see a link labeled "External Modules"
    And I should NOT see a link labeled "Manage User Roles"
    And I should NOT see a link labeled "Banned IP Addresses"

  Scenario: A.2.67.0200.600 Administrator cannot manage projects outside the assigned PAG
    #Check that the administrator cannot manage projects outside the assigned PAG
    Given I click on the link labeled "Browse Projects"
    And I click on the button labeled "View all projects"
    Then I should see "PAG Admin Project"
    And I should NOT see "No PAG Access"
    #Check project updated for PAG Admin View
    When I click on "PAG Admin Project"
    Then I should see "PAG Admin Project"
    And I should see "Project-level Administrator"
    And I should see "Edit Project Settings"
    #Check that the project level settings has the appropriate options for the PAG Administrator
    When I click on the link labeled "Edit Project Settings"
    Then I should see "Edit Project Settings"
    And I should see 'Navigate to project PID 13 "PAG Admin Project"'
    And I should see "PAG Admin Project"
    And I should see "Online Status of Project"
    And I should see "Language for text displayed within project"
    And I should see "Character encoding for exported files"
    And I should see "Enable auto-calculations for calc fields?"
    And I should see "Enable/disable the Shared Library for this project?"
    And I should see "Enable/disable Twilio SMS and Voice Call services for this project?"
    And I should see "Settings relating to Data Privacy (e.g., GDPR)"
    And I should see "AI Services"
    And I should see "Miscellaneous project settings:"
    And I should see "Set custom logo and text:"
    And I should see "Custom Project Settings (will overwrite system values)"
    #Check that the coontrol center edit project settings only has the projects available to the PAG Administrator
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Edit Project Settings"
    Then I should see "PAG Admin Project"
    And I should NOT see "No PAG Access"


  Scenario: A.2.67.0200.700 Remove a PAG administrator and revoke delegated authority
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "Add or remove admins" in the row labeled "New PAG 1"
    And I click on the icon in the column labeled "Remove" and the row labeled "test_user1"
    And I click on the button labeled "Remove user as project-level admin"
    Then I should see "User successfully removed as a project-level admin!"
    And I click on the button labeled "Close"
    Given I logout
    And I login to REDCap with the user "Test_User1"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    And I click on the button labeled "View all projects"
    Then I should NOT see "PAG Admin Project"
    And I should NOT see "No PAG Access"

#End