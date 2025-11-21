Feature: C.3.30.1400 – User Interface: The system shall support single randomization per model and multiple randomizations per record.
As a REDCap end user
I want to see that Randomization is functioning as expected

Scenario: #SETUP - Create new project
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.1400" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button

    #SETUP- Assign rights for user with randomization rights
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    #SETUP- Randomization model 1 setup
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "A) Use stratified randomization?"
    And I select "strat_1 (Stratification 1)" on the first dropdown field labeled "- select a field -"
    And I select "rand_group (Randomization group 1)" on the second dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"
    When I upload a "csv" format file located at "import_files/Randomization_one_strat.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Success! The randomization allocation table was created!"

    #SETUP- Randomization model 2 setup
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I select "rand_group_6 (Randomization group 6)" on the first dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"
    When I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_1basic.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Success! The randomization allocation table was created!"

Scenario:#C.3.30.1400.0100. A record can be randomized across distinct models (e.g., Model A, Model B).
    #Randomizing to first model
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Demographics" on the column labeled "Status"
    And I select the radio option "Yes" for the field labeled "Stratification 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 1 successfully edited."
    When I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the first button labeled "Randomize"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize" in the dialog box
    Then I should see "was randomized for"
    And I click on the button labeled "Close" in the dialog box 

    #Randomizing to second model
    When I click on the button labeled "Randomize"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize" in the dialog box
    Then I should see "was randomized for"
    And I click on the button labeled "Close" in the dialog box 

    #VERIFY: Logging
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action             | List of Data Changes OR Fields Exported      |
      | test_user1 | Randomize Record 1 | Randomize record                             |
      | test_user1 | Update record 1    | rand_group_6 = '1'                           |
      | test_user1 | Randomize Record 1 | Randomize record                             |
      | test_user1 | Update record 1    | rand_group = '1'                             |


Scenario:#C.3.30.1400.0200. The system shall prevent a record from being randomized more than once within the same model.
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    Then I should see "Already randomized"
    And I should NOT see a button labeled "Randomize"

Given I logout
#End