Feature: A.2.67.0300. - Control Center: The system shall allow projects to be assigned to a Project Administrator Group to delegate project administration to the designated project-level administrators. A project shall be assigned to only one Project Administrator Group at a time.
  
  As a REDCap system administrator
  I want to ensure that projects are correctly assigned to a Project Administrator Group and are managed by the appropriate project-level administrators.

  Scenario: Setup REDCap+ and create initial PAG and Project
    #Setup new project for PAG Assignment
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "PAG Admin Project" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see "Your new REDCap project has been created"
    And I should see "PAG Admin Project"

    #Move project to production
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Project status:  Production"

    #Assign Project Users
    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I click on the checkbox labeled "Project Design and Setup"
    And I click on the button labeled "Add user"
    Then I should see 'User "Test_User2" was successfully added'

    #Setup REDCap+ and create initial PAG
    When I click on the link labeled "Control Center"
    And I click on the link labeled "REDCap Plus"
    And I click on the button labeled "Enter a REDCap+ subscription key"
    And I enter "[SUBSCRIPTION_KEY]" into the textarea field labeled "Enter a REDCap+ subscription key"
    And I click on the button labeled "Save key"
    Then I should see "REDCap+ subscription activated!"
    And I click on the link labeled "Project Administrator Groups"
    And I click on "Create new PAG"
    Then I should see "Create new Project Administrator Group"

  Scenario: A.2.67.0300.0100 Assign a REDCap user as a PAG administrator    
    #Creating 2 new PAGs
    When I enter "New PAG 1" into the field with the placeholder text of "Enter name for new PAG"
    And I enter "Test_User1" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Create new PAG"
    Then I should see "PAG successfully created!"
    When I click on "Create new PAG"
    Then I should see "Create new Project Administrator Group"
    When I enter "New PAG 2" into the field with the placeholder text of "Enter name for new PAG"
    And I enter "Test_User2" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Create new PAG"
    Then I should see "PAG successfully created!"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1)     |0                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)     |0                          | 0                      |2        |
    #Assigning a REDCap user as a PAG administrator
    When I click on the button labeled "Add or remove admins" in the row labeled "New PAG 1"
    And I click on the button labeled "Assign user to PAG as project-level admin"
    And I enter "Test_User3" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Assign user as project-level admin"
    Then I should see "User assigned successfully as a project-level admin!"
    And I click on the button labeled "Close"
    And I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                                 |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3)     |0                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)                              |0                          | 0                      |2        |


  Scenario: A.2.67.0300.0200 Assign multiple administrators to one PAG
    When I click on the button labeled "Add or remove admins" in the row labeled "New PAG 1"
    And I click on the button labeled "Assign user to PAG as project-level admin"
    And I enter "Test_user4" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Assign user as project-level admin"
    Then I should see "User assigned successfully as a project-level admin!"
    And I click on the button labeled "Close"
    And I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                                                          |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3), Test_User4 (Test User4)     |0                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)                                                       |0                          | 0                      |2        |


  Scenario: A.2.67.0300.0300 Assign one administrator to multiple PAGs
    When I click on the button labeled "Add or remove admins" in the row labeled "New PAG 2"
    And I click on the button labeled "Assign user to PAG as project-level admin"
    And I enter "Test_user4" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Assign user as project-level admin"
    Then I should see "User assigned successfully as a project-level admin!"
    And I click on the button labeled "Close"
    And I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                                                          |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3), Test_User4 (Test User4)     |0                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2), Test_User4 (Test User4)                              |0                          | 0                      |2        |

  Scenario: A.2.67.0300.0400 Remove a PAG administrator and revoke delegated authority
    #Remove Test User 4 from both PAGs.
    When I click on the button labeled "Add or remove admins" in the row labeled "New PAG 1"
    And I click on the icon in the column labeled "Remove" and the row labeled "test_user4"
    And I click on the button labeled "Unassign user from PAG"
    Then I should see "The user was successfully removed from the PAG!"
    And I click on the button labeled "Close"

    When I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "Add or remove admins" in the row labeled "New PAG 2"
    And I click on the icon in the column labeled "Remove" and the row labeled "test_user4"
    And I click on the button labeled "Unassign user from PAG"
    Then I should see "The user was successfully removed from the PAG!"
    And I click on the button labeled "Close"
    Then I should NOT see "Test_User4"
    And I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                               |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3)   |0                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)                            |0                          | 0                      |2        |
    
    #Validate revoked authority for Test_User1
    Given I logout
    And I login to REDCap with the user "Test_User4"
    Then I should NOT see "Control Center"

  Scenario: A.2.67.0300.0500 Assign a project to a PAG
    Given I logout
    And I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "View & Manage" 
    And I click on the button labeled "Add project"
    And I click on "Search for a project..."
    And I click on "PAG Admin Project"
    And I click on the button labeled "Assign"
    Then I should see "Project assigned successfully!"
    And I should see "New PAG 1"
    #Validate project assignment
    And I should see a table header and rows containing the following values in a table:
        |PID        |Project Title           | Remove | 
        |13         |PAG Admin Project       |        |
    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                               |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3)   |1                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)                            |0                          | 0                      |2        |
     
  Scenario: A.2.67.0300.0600 A project can be assigned to only one PAG
    Given I click on the button labeled "View & Manage" in the row labeled "New PAG 2"
    And I click on the button labeled "Add project"
    And I click on "Search for a project..."
    And I click on "PAG Admin Project"
    And I click on the button labeled "Assign"
    Then I should see "Project assigned successfully!"
    And I should see "New PAG 2"
    #Validate project assignment
    And I should see a table header and rows containing the following values in a table:
        |PID        |Project Title           | Remove | 
        |13         |PAG Admin Project       |        |
    #Validate Project moved from NEW PAG 1 to NEW PAG 2
    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                               |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3)   |0                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)                            |1                          | 0                      |2        |

  Scenario: A.2.67.0300.0700 Remove a project from a PAG
    Given I click on the button labeled "View & Manage" in the row labeled "New PAG 2"
    And I click on the icon in the column labeled "Remove" and the row labeled "PAG Admin Project"
    And I click on the button labeled "Remove project from PAG"
    Then I should see "The project was successfully removed from the PAG!"

    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                               |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3)   |0                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)                            |0                          | 0                      |2        |


  Scenario: A.2.67.0300.0800 Reassign a project to another PAG
    #Assign PAG Admin Project to New PAG 1 after being removed.
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "View & Manage" 
    And I click on the button labeled "Add project"
    And I click on "Search for a project..."
    And I click on "PAG Admin Project"
    And I click on the button labeled "Assign"
    Then I should see "Project assigned successfully!"
    And I should see "New PAG 1"
    #Validate project assignment
    And I should see a table header and rows containing the following values in a table:
        |PID        |Project Title           | Remove | 
        |13         |PAG Admin Project       |        |
    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                               |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3)   |1                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)                            |0                          | 0                      |2        |
    
    #Reassign project from New PAG 1 to New PAG 2
    Given I click on the button labeled "View & Manage" in the row labeled "New PAG 2"
    And I click on the button labeled "Add project"
    And I click on "Search for a project..."
    And I click on "PAG Admin Project"
    And I click on the button labeled "Assign"
    Then I should see "Project assigned successfully!"
    And I should see "New PAG 2"
    #Validate project assignment
    And I should see a table header and rows containing the following values in a table:
        |PID        |Project Title           | Remove | 
        |13         |PAG Admin Project       |        |
    #Validate Project moved from NEW PAG 1 to NEW PAG 2
    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins                               |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1), Test_User3 (Test User3)   |0                          | 0                      |1        |
        |New PAG 2                    |Test_User2 (Test User2)                            |1                          | 0                      |2        |

  Scenario: A.2.67.0300.0900 Reassignment transfers administrative responsibility
    #Checking that no projects are currently available to manage for Test_User1.
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    And I click on the button labeled "View all projects"
    Then I should NOT see "PAG Admin Project"

    #Checking that test user 2 has access to the PAG Admin Project
    Given I logout
    And I login to REDCap with the user "Test_User2"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    And I click on the button labeled "View all projects"
    Then I should see "PAG Admin Project"

    #Reassign project from New PAG 2 back to New PAG 1
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    And I click on the button labeled "View & Manage" in the row labeled "New PAG 1"
    And I click on the button labeled "Add project"
    And I click on "Search for a project..."
    And I click on "PAG Admin Project"
    And I click on the button labeled "Assign"
    Then I should see "Project assigned successfully!"
    And I should see "New PAG 1"

    #Checking that project is now assigned to New PAG 1 and is available to manage for Test_User1.
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    And I click on the button labeled "View all projects"
    Then I should see "PAG Admin Project"

    #Checking that test user 2 does not still have access to project.
    Given I logout
    And I login to REDCap with the user "Test_User2"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    And I click on the button labeled "View all projects"
    Then I should NOT see "PAG Admin Project"

  #Scenario: A.2.67.0300.1000 Delegated administrative functions are available for assigned projects
    #This scenario is redundent and has been fully validated in Scenario: A.2.67.0200.400 Delegated administrative functions are available for assigned projects

  #Scenario: A.2.67.0300.1100 PAG administrators cannot use authentication or system-wide administration
    #This scenario is redundent and has been fully validated in Scenario: A.2.67.0200.500 Authentication and system-wide administration remain unavailable

  #Scenario: A.2.67.0300.1200 PAG administrators cannot manage projects outside their assigned PAG
    #This scenario is redundent and has been fully validated in Scenario: A.2.67.0200.600 Administrator cannot manage projects outside the assigned PAG

  Scenario: A.2.67.0300.1300 Project requests follow the assigned PAG
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "PAG Admin Project"
    
    #Make a project leve change in draft more that must be reviewed
    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"


    #Change field that would need to be approved by administrator
    When I click on the link labeled "Dictionary"
    And I upload a "csv" format file located at "dictionaries/Project_4.9.modified.csv", by clicking the button near "Upload your Data Dictionary file" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."
    When I click on the button labeled "Commit Changes"
    And I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit"
    Then I should see "Awaiting review of project changes"
    
    #Check that the request has been submitted and is visible to the PAG administrator.
    Given I logout
    And I login to REDCap with the user "Test_User1"
    When I click on the link labeled "Control Center"
    Then I should see "To-Do List"
    And I should see "Pending Requests"
    And I should see a table header and rows containing the following values in a table:
    |Req #|Request type         |Request time       |PID              |User                   |Action|
    |1    |Approve draft changes|mm/dd/yyyy hh:mm   |13               |test_user2 (Test User2)|      |
 
#End