Feature: User Interface: The system shall restrict users to randomizing records only within their assigned DAG, in accordance with system-wide access controls.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

 Scenario: #SETUP project with randomization enabled
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.0600." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button
    #Adding user rights Test_User1
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
  
    #Adding DAG
    When I click on the link labeled "DAGs"
    Then I should see "Create new groups"
    When I enter "DAG 1" into the field with the placeholder text of "Enter new group name"
    And I click on the button labeled "Add Group"
    #Assign User to DAG
    Given I click on the link labeled "DAGs"
    When I select "test_user2 (Test User2)" on the dropdown field labeled "Assign user"
    And I select "DAG 1" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"
    Then I should see a table header and rows containing the following values in a table:
      | Data Access Groups        | Users in group          |
      | DAG 1                     | test_user2 (Test User2) |
      | [Not assigned to a group] | test_user1 (Test User1) |
    #Adding randomization strategy and allocation table
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "B) Randomize by group/site"
    And I click on the radio labeled "Use Data Access Groups"
    And I select "rand_group_2 (Randomization group 2)" on the second dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"

    When I click on the button labeled "Example #2 (all possible combos)"
    Then I should see a downloaded file named "RandomizationAllocationTemplate.csv"
    Then I upload a "csv" format file located at "downloads/RandomizationAllocationTemplate.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    
    #Adding Allocation table for automation
    When I upload a "csv" format file located at "import_files/AllocationTblC.3.30.0600.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see " Success! The randomization allocation table was created!"


  Scenario: #FUNCTIONAL_REQUIREMENT C.3.30.0600.0100. Users within a DAG can randomize records only within their assigned DAG, ensuring they cannot view or randomize records outside their group.
    Given I logout
    And I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.0600."
    And I click on the link labeled "Project Setup"
    And I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I click the bubble for the row labeled "Demographics" on the column labeled "Status"
    And I select the radio option "Yes" for the field labeled "Stratification 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 1-1 successfully added." 
    #M This number may be diferent with manual testing.

    When I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize" 
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize" in the dialog box
    Then I should see "was randomized for the field"
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 1-1 successfully edited."
    #M This number may be diferent with manual testing.

      #VERIFY Randomization value was saved and field now has a value.
    When I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    Then I should see "Already randomized" 

      #VERIFY access restriction | Test_User2 doesn't have access to records outside of their dag.
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1-1       |
      #M This record ID may be diferent with manual testing.

      #Verification that user does not have access to record 2. Ensuring they cannot view or randomize records outside their group is fully covered by B.2.10.0400. User Interface: The system shall provide the ability to restrict a user who has been assigned to a DAG.
    And I should see "ALL (1)" 
    
      #VERIFY Record Randomization was added to the randomization dashboard.
    Given I logout
    And I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.0600."
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    Then I should see a table header and rows containing the following values in a table:
                 | Used    | Not Used | Allocated records   | Data Access Group  redcap_data_access_group|Randomization group 2  rand_group_2|
                 | 1       |     0    |     1-1             | DAG 1 (1)                                  | Drug A (1)        | 
      #M This record ID may be diferent with manual testing.
       	
      #VERIFY_log Randomization at project level enabled recorded in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action              | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user2 | Randomize Record 1-1|Randomize record|
            | mm/dd/yyyy hh:mm | test_user2 | Update record 1-1   |Assign record to Data Access Group (redcap_data_access_group = 'dag_1')|
            | mm/dd/yyyy hh:mm | test_user2 | Create record 1-1   |strat_1 = '1', demographics_complete = '0', record_id = '1-1'|
      #M These record IDs may be diferent with manual testing.

  
  Scenario: FUNCTIONAL_REQUIREMENT C.3.30.0600.0200: The randomization model shall support stratification by DAG, allowing independent randomization assignments within each DAG.
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    When I select "DAG 1" on the dropdown field labeled "Assign this record to a Data Access Group"
    And I click on the button labeled "Randomize"
    Then I should see "was randomized for"
    And I click on the button labeled "Close" in the dialog box
    And I should see "Already randomized" 
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 6 successfully edited."

      #VERIFY Logging
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
           |Time / Date        | Username   | Action              | List of Data Changes OR Fields Exported      |
           | mm/dd/yyyy hh:mm  | test_user1 | Update record 6     |  |
           | mm/dd/yyyy hh:mm  | test_user1 | Randomize Record 6  | Randomize record  |
           | mm/dd/yyyy hh:mm  | test_user1 | Update record 6     | Assign record to Data Access Group (redcap_data_access_group = 'dag_1') |
           | mm/dd/yyyy hh:mm  | test_user1 | Create record 6     | record_id = '6', rand_group_2 = '2', randomization_complete = '0' |

And I logout
#END
