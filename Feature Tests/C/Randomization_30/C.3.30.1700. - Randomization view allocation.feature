Feature: Project Interface Administrator Access: The system shall support administrator-only access to the randomization module's View Allocation Table page.
As a REDCap end user
I want to see that Randomization is functioning as expected
  
   Scenario: #SETUP project with randomization enabled
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.1700." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button
    
    #Adding user rights Test_User1 (admin)
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
      
    #Adding user Test_User2 (No randomization rights)
    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the field with the placeholder text of "Add new user"
    And I click on the button labeled "Add with custom rights"
    And I click on the checkbox labeled "Project Design and Setup"
    And I click on the button labeled "Add user"
    Then I should see 'User "Test_User2" was successfully added'
    
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

    # Create Record for one stratum
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Demographics" on the column labeled "Status"
    And I select the radio option "Yes" for the field labeled "Stratification 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 1 successfully edited."

    When I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize" 
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize" in the dialog box
    Then I should see "was randomized for"
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 1 successfully edited."

 Scenario:#C.3.30.1700.0100. Admin accesses View Allocation Table page.  
    Given I click on the link labeled "Randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    Then I should see a table header and rows containing the following values in a table:
            |       | Used    | Not Used | Allocated records | Stratification 1 |Randomization group|
            |       | 0       |     1    |                   | No (0)           | Drug B (2)        |   
	          |       | 1       |     0    |     1             | Yes (1)          | Drug A (1)        | 
     
    
    #VERIFY Non project Admin can not see Allocation Table page from the Dashboard.
    Given I logout
    And I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.1700."
    And I click on the link labeled "Setup"
    Then I should NOT see the button labeled "Set up a randomization model"
    And I logout

 Scenario:#C.3.30.1700.0200. User with dashboard rights cannot access View Allocation Table.
    #SETUP to modify user rights for test
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.1700."
    And I click on the link labeled "User Rights"
    And I click on the link labeled "Test User2"
    And I click on the button labeled "Edit user privileges"
    And I check the checkbox labeled "Dashboard"
    And I uncheck the checkbox labeled "Randomize"
    And I click on the button labeled "Save Changes"
    Then I should see 'User "test_user2" was successfully edited' 
    And I logout

    When I login to REDCap with the user "Test_User2"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.1700."
    And I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    #VERIFY Test User with dashboard permissions cannot see Allocation Table
    Then I should NOT see the button labeled "Setup"

#End