Feature: C.3.30.1600.	User Interface: The system shall ensure users with randomization dashboard rights can view the randomization dashboard.	
As a REDCap end user
I want to see that Randomization is functioning as expected

Scenario: #SETUP project with randomization enabled
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.1600." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button
    
    #Adding user rights Test_User1 (with randomize rights)
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
      
    #Adding user Test_User2 (without randomize rights)
    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the field with the placeholder text of "Add new user"
    And I click on the button labeled "Add with custom rights"
    And I click on the checkbox labeled "Project Design and Setup"
    And I check the checkbox labeled "Setup"
    And I uncheck the checkbox labeled "Dashboard"
    And I click on the button labeled "Add user"
    Then I should see 'User "Test_User2" was successfully added'
    And I should see a table header and rows containing the following values in a table:
            | Role name               | Username            | Randomization |
            | —                       | test_user2          | Setup Randomize |

    #SETUP Creating randomiztion stategy and adding allocation table.
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "A) Use stratified randomization?"
    And I select "strat_1 (Stratification 1)" on the first dropdown field labeled "- select a field -"
    And I select "rand_group (Randomization group 1)" on the second dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"
    
    #Adding valid allocation table
    When I upload a "csv" format file located at "import_files/Randomization_one_strat.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded"

    #Adding record with randomization
    And I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Demographics" on the column labeled "Status"
    And I select the radio option "Yes" for the field labeled "Stratification 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 2 successfully edited."
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize" 
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize" in the dialog box
    Then I should see "was randomized for"
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 2 successfully edited."

Scenario: #C.3.30.1600.0200 ensures that access is granted when the user has the correct dashboard rights. 
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.1600."
    And I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    Then I should see a table header and rows containing the following values in a table:
            |       | Used    | Not Used | Allocated records | Stratification 1 |Randomization group|
            |       | 0       |     1    |                   | No (0)           | Drug B (2)        |   
            |       | 1       |     0    |     2             | Yes (1)          | Drug A (1)        | 

Scenario: #C.3.30.1600.0100 ensures that access is denied when the user lacks the appropriate permission.
    Given I login to REDCap with the user "Test_User2"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.1600."
    And I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    Then I should see a table header and rows containing the following values in a table:
            | #      | Target     | Allocation Type | Stratification | Total Allocations (Development) |Total Allocations (Production)| Setup | Randomization ID |
            | 1      | rand_group |                 | strat_1        | 2                              | 0                           |       | 2                |
    
    And I should NOT see a button labeled "Dashboard"

    #Given I logout
  #End