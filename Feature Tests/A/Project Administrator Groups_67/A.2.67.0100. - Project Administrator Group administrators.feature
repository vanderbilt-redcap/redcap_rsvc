Feature: A.2.67.0100. Control Center: The system shall support Project Administrator Groups (PAGs) to allow designated project-level administrators to manage administrative responsibilities for assigned projects.

  As a REDCap system administrator
  I want to verify PAG availability, creation, modification, deletion, and assignment routing behavior
  So that projects can be assigned to project-level administrators without bypassing the standard administrative workflow

  Scenario: A.2.67.0100.100 PAG management is not available outside REDCap+ and Project Setup
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "PAG Test 1" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see "Your new REDCap project has been created"
    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I click on the button labeled "Add user"
    Then I should see 'User "Test_User2" was successfully added'
    When I click on the link labeled "Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Success! The project is now in production."
    And I click on the link labeled "Control Center"
    Then I should see "Project Administrator Groups" that is disabled

Scenario: A.2.67.0100.200 PAG management is available in REDCap+
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    Given I click on the link labeled "REDCap Plus"
    And I click on the button labeled "Enter a REDCap+ subscription key"
    And I enter a REDCap+ subscription key into the textarea field labeled "Enter a REDCap+ subscription key"    
    And I click on the button labeled "Save key"
    Then I click on the button labeled "OK"
    Then I should see "Project Administrator Groups"
    When I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    And I logout

    #Verify user without admin rights cannot access the Control Center
    Given I login to REDCap with the user "Test_User1"
    Then I should NOT see "Control Center"
    And I logout
  
  Scenario: A.2.67.0100.300 Only system administrators can create, modify, or remove PAGs
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    Then I should see "Project Administrator Groups"

  Scenario: A.2.67.0100.400 Create a PAG
    When I click on the link labeled "Project Administrator Groups"
    And I click on the button labeled "Create new PAG"
    And I enter "Test PAG Group" into the field labeled "Project Administrator Group name"
    And I enter "test_user1" into the field labeled "Initial Project-Level Admin (username)"
    And I click on the button labeled "Create new PAG"
    Then I should see "Test PAG Group"
    Then I click on the button labeled "OK"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group   |Project-level Admins       | Projects Assigned to PAG  |  Users Assigned to PAG  | PAG ID  |
        |Test PAG Group                |Test_User1 (Test User1)    |           0               |             0           |    1    |


  Scenario: A.2.67.0100.500 Modify a PAG
    When I click on the button labeled "Edit PAG Name" in the row labeled "Test PAG Group"
    And I enter "Updated Test PAG Group" into the field labeled "Project Administrator Group name"
    And I click on the button labeled "Update"
    Then I should see "PAG name successfully updated!"
    Then I click on the button labeled "OK"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group   |Project-level Admins       | Projects Assigned to PAG  |  Users Assigned to PAG  | PAG ID  |
        |Updated Test PAG Group        |Test_User1 (Test User1)    |           0               |             0           |    1    |

  Scenario: A.2.67.0100.600 Delete a PAG
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    And I click on the button labeled "Delete" in the row labeled "Updated Test PAG Group"
    Then I click on the button labeled "Delete PAG"
    Then I should see "PAG deleted successfully!"
    Then I click on the button labeled "OK"
    Then I should NOT see "Updated Test PAG Group"
    And I logout


  Scenario: A.2.67.0100.700 Projects assigned to a PAG route administrative requests to the assigned PAG administrator
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    When I click on the button labeled "Create new PAG"
    And I enter "Routing PAG" into the field labeled "Project Administrator Group name"
    And I enter "test_user2" into the field labeled "Initial Project-Level Admin (username)"
    And I click on the button labeled "Create new PAG"
    Then I should see "Routing PAG"
    Then I click on the button labeled "OK"
    And I click on the button labeled "View & Manage" in the row labeled "Routing PAG"   
    And I click on the button labeled "Add project"
    And I click on "Search for a project..."
    And I click on "PAG Test 1"
    And I click on the button labeled "Assign"
    Then I should see "Project assigned successfully!"
    Then I click on the button labeled "OK"
    And I click on the button labeled "Close"
    And I logout

    #Make a project leve change in draft more that must be reviewed
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "PAG Test 1"

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
    And I login to REDCap with the user "Test_User2"
    When I click on the link labeled "Control Center"
    Then I should see "To-Do List"
    And I should see "Pending Requests"
    And I should see a table header and rows containing the following values in a table:
    |Req #|Request type         |Request time       |PID              |User                   |Action|
    |1    |Approve draft changes|mm/dd/yyyy hh:mm   |13               |test_user2 (Test User2)|      |


  Scenario: A.2.67.0100.800 Projects without a PAG continue through the standard administrative workflow
   Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "PAG Test 2" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see "Your new REDCap project has been created"
    When I click on the link labeled "Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Success! The project is now in production."

    #Change field that would need to be approved by administrator
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "PAG Test 2"
    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"
    When I click on the link labeled "Dictionary"
    And I upload a "csv" format file located at "dictionaries/Project_4.9.modified.csv", by clicking the button near "Upload your Data Dictionary file" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."
    When I click on the button labeled "Commit Changes"
    And I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit"
    Then I should see "Awaiting review of project changes"


#END

