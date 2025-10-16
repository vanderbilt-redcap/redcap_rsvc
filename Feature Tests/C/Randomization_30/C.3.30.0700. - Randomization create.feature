Feature: C.3.30.0700 User Interface: The system shall ensure users with Randomization Setup can create and modify randomization models while in project development mode.
  As a REDCap end user
  I want to see that Randomization is functioning as expected
  
Scenario: #SETUP project with randomization enabled
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.0700." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button
    #Adding user rights Test_User1
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
    #Adding user rights Test_Admin
    When I click on the link labeled "User Rights"
    And I enter "Test_Admin" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "test_admin" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
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
   
    #VERIFY
    Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups |
            | DAG 1         |


Scenario: C.3.30.0700.2300. User without Randomization Setup rights cannot access Setup via Project Setup
    Given I logout
    And I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.0700."
    And I click on the link labeled "Setup"
    Then I should NOT see the button labeled "Set up a randomization model"
    
Scenario: C.3.30.0700.2100. Attempt to use non-categorical field for stratification
    Given I logout
    And I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.0700."
    And I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "A) Use stratified randomization?"
    Then I should NOT see "fname" on the dropdown field labeled "- select a field -"

Scenario: C.3.30.0700.0200. Enable stratified randomization with one stratum. 
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "A) Use stratified randomization?"
    And I select "strat_1 (Stratification 1)" on the first dropdown field labeled "- select a field -"
    And I select "rand_group (Randomization group)" on the second dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"
    
Scenario: C.3.30.0700.2200 Upload invalid allocation table in DEVELOPMENT
    When I upload a "csv" format file located at "import_files/Invalid_Allocation.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "ERROR: The following errors occurred. Please address them and try again."

    #Adding valid allocation table
    When I click on the button labeled "Return to previous page"
    When I upload a "csv" format file located at "import_files/Randomization_one_strat.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded"

Scenario: C.3.30.0700.2000. Modify an existing randomization model
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    Then I should see "If you wish to modify the randomization setup below, you will need to click the Erase Randomization Model button below."

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
    Then I should see "was randomized for" in the dialog box
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 1 successfully edited."
    

    #VERIFY Randomization model was added to the randomization summary.
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the link labeled "Dashboard"
    Then I should see a table header and rows containing the following values in a table:
            |       | Used    | Not Used | Allocated records | Stratification 1 |Randomization group|
            |       | 0       |     1    |                   | No (0)           | Drug B (2)        |   
	    |       | 1       |     0    |     1             | Yes (1)          | Drug A (1)        | 	
            	
    #VERIFY_log Randomization at project level enabled recorded in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action            | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Randomize Record 1|Randomize record|
            | mm/dd/yyyy hh:mm | test_user1 | Update record 1   |rand_group = '1'|
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design     |Upload randomization allocation table - development (rid=2)|

Scenario: C.3.30.0700.0100. Disable stratified randomization.  
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "A) Use stratified randomization?"
    And I select "strat_1 (Stratification 1)" on the first dropdown field labeled "- select a field -"
    And I uncheck the checkbox labeled "A) Use stratified randomization?"
    Then I should NOT see "Choose strata"

Scenario: C.3.30.0700.1100. Erase randomization model. 
    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the button labeled "Erase randomization model"
    Then I should see "Success! Your randomization setup and all allocations have now been erased."

    #VERIFY_log Randomization at project level enabled recorded in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Erase randomization model and allocations (rid=2)| 

Scenario: C.3.30.0700.0300. Enable stratified randomization with up to 14 strata (test all 14). 
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "A) Use stratified randomization?"
    And I select "strat_1 (Stratification 1)" on the first dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_2 (Stratification 2)" on the second dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_3 (Stratification 3)" on the third dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_4 (Stratification 4)" on the fourth dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_5 (Stratification 5)" on the fifth dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_6 (Stratification 6)" on the sixth dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_7 (Stratification 7)" on the seventh dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_8 (Stratification 8)" on the eighth dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_9 (Stratification 9)" on the ninth dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_10 (Stratification 10)" on the tenth dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_11 (Stratification 11)" on the eleventh dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_12 (Stratification 12)" on the twelfth dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_13 (Stratification 13)" on the thirteenth dropdown field labeled "- select a field -"
    And I click on the button labeled "Add another stratum"
    And I select "strat_14 (Stratification 14)" on the fourteenth dropdown field labeled "- select a field -"
    And I select "rand_group (Randomization group)" on the fifteenth dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"
   	
    #VERIFY_log Randomization at project level enabled recorded in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action            | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design     |Save randomization model (rid=3)|

Scenario: C.3.30.0700.0400. Randomize by group/site enabled with no option selected.  
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "B) Randomize by group/site"
    And I select "rand_group_2 (Randomization group)" on the second dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see an alert box with the following text: "Please choose one of the grouping options OR uncheck the Randomize By Group checkbox"

    #VERIFY Randomization model was not added to the randomization summary.
    When I click on the link labeled "Summary"
    Then I should see a table header and rows containing the following values in a table:
            | #      | Target     | Allocation Type | Stratification | Total Allocations (Development) |Total Allocations (Production)| Setup | Dashboard | Randomization ID |
            | 1      | rand_group |                 | strat_1 strat_2 strat_3 strat_4 strat_5 strat_6 strat_7 strat_8 strat_9 strat_10 strat_11 strat_12 strat_13 strat_14         | 0                              | 0                           |       |           | 3                |
			
    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Save randomization model (rid=3)| 

Scenario: C.3.30.0700.0500. Randomize by group/site enabled with DAG selected.  
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "B) Randomize by group/site"
    And I click on the radio labeled "Use Data Access Groups"
    And I select "rand_group_2 (Randomization group)" on the second dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"

    #VERIFY Randomization model was added to the randomization summary.
    When I click on the link labeled "Summary"
    Then I should see a table header and rows containing the following values in a table:
            | #     | Target     | Allocation Type | Stratification | Total Allocations (Development) |Total Allocations (Production)| Setup | Dashboard | Randomization ID |
            | 1     | rand_group |                 | strat_1 strat_2 strat_3 strat_4 strat_5 strat_6 strat_7 strat_8 strat_9 strat_10 strat_11 strat_12 strat_13 strat_14         | 0                              | 0                           |       |           | 3                |
            | 2     | rand_group_2 |                 | Data Access Group | 0                              | 0                           |       |           | 4                |
			
    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Save randomization model (rid=4)| 


 Scenario: C.3.30.0700.0600. Randomize by group/site enabled with an existing field selected.  
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "B) Randomize by group/site"
    And I click on the radio labeled "Use an existing field to designate each group/site"
    And I select "gender" on the first dropdown field labeled "- select a field -"
    And I select "rand_group_3 (Randomization group)" on the second dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"

    #VERIFY Randomization model was added to the randomization summary.
    When I click on the link labeled "Summary"
    Then I should see a table header and rows containing the following values in a table:
            | #      | Target     | Allocation Type | Stratification | Total Allocations (Development) |Total Allocations (Production)| Setup | Dashboard | Randomization ID |
            | 1      | rand_group |                 | strat_1 strat_2 strat_3 strat_4 strat_5 strat_6 strat_7 strat_8 strat_9 strat_10 strat_11 strat_12 strat_13 strat_14         | 0                              | 0                           |       |           | 3                |
            | 2      | rand_group_2 |                 | Data Access Group | 0                              | 0                           |       |           | 4                |
	    | 3      | rand_group_3 |                 | gender | 0                              | 0                           |       |           | 5                |
			
    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Save randomization model (rid=5)| 

 Scenario: C.3.30.0700.0700. Choose open randomization dropdown field.   
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I select "rand_group_4" on the first dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"

    #VERIFY Randomization model was added to the randomization summary.
    When I click on the link labeled "Summary"
    Then I should see a table header and rows containing the following values in a table:
            | #      | Target     | Allocation Type | Stratification | Total Allocations (Development) |Total Allocations (Production)| Setup | Dashboard | Randomization ID |
            | 1      | rand_group |                 | strat_1 strat_2 strat_3 strat_4 strat_5 strat_6 strat_7 strat_8 strat_9 strat_10 strat_11 strat_12 strat_13 strat_14         | 0                              | 0                           |       |           | 3                |
            | 2      | rand_group_2 |                 | Data Access Group | 0                              | 0                           |       |           | 4                |
	    | 3      | rand_group_3 |                 | gender | 0                              | 0                           |       |           | 5                |
	    | 4      | rand_group_4 |                 |                | 0                              | 0                           |       |           | 6               |
			
    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Save randomization model (rid=6)                   |


 Scenario: C.3.30.0700.0800. Choose open randomization radio field.  
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I select "rand_group_5" on the first dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"

    #VERIFY Randomization model was added to the randomization summary.
    When I click on the link labeled "Summary"
    Then I should see a table header and rows containing the following values in a table:
            | #      | Target     | Allocation Type | Stratification | Total Allocations (Development) |Total Allocations (Production)| Setup | Dashboard | Randomization ID |
            | 1      | rand_group |                 | strat_1 strat_2 strat_3 strat_4 strat_5 strat_6 strat_7 strat_8 strat_9 strat_10 strat_11 strat_12 strat_13 strat_14         | 0                              | 0                           |       |           | 3                |
            | 2      | rand_group_2 |                 | Data Access Group | 0                              | 0                           |       |           | 4                |
	    | 3      | rand_group_3 |                 | gender | 0                              | 0                           |       |           | 5                |
	    | 4      | rand_group_4 |                 |                | 0                              | 0                           |       |           | 6               |
	    | 5      | rand_group_5 |                 |        | 0                              | 0                           |       |           | 7               |
			
    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Save randomization model (rid=7)|

 Scenario: C.3.30.0700.0900. Choose concealed randomization text field.  
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I select "rand_blind" on the first dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"

    #VERIFY Randomization model was added to the randomization summary.
    When I click on the link labeled "Summary"
    Then I should see a table header and rows containing the following values in a table:
            | #      | Target     | Allocation Type | Stratification | Total Allocations (Development) |Total Allocations (Production)| Setup | Dashboard | Randomization ID |
            | 1      | rand_group |                 | strat_1 strat_2 strat_3 strat_4 strat_5 strat_6 strat_7 strat_8 strat_9 strat_10 strat_11 strat_12 strat_13 strat_14         | 0                              | 0                           |       |           | 3                |
            | 2      | rand_group_2 |                 | Data Access Group | 0                              | 0                           |       |           | 4                |
	    | 3      | rand_group_3 |                 | gender | 0                              | 0                           |       |           | 5                |
	    | 4      | rand_group_4 |                 |                | 0                              | 0                           |       |           | 6               |
	    | 5      | rand_group_5 |                 |        | 0                              | 0                           |       |           | 7               |
	    | 6      | rand_blind |                 |        | 0                              | 0                           |       |           | 8               |
	
    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Save randomization model (rid=8)|

 Scenario: C.3.30.0700.1000. Save randomization model.  
    #REDUNDANT - Tested in C.3.30.0700.0200 | C.3.30.0700.0300 | C.3.30.0700.0500 | C.3.30.0700.0600 | C.3.30.0700.0700 | C.3.30.0700.0800 | C.3.30.0700.0900 | 

 Scenario: C.3.30.0700.1200. Download example allocation tables (Excel/CSV).  
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I select "rand_group_6" on the first dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"
    And I should see "STEP 2: Download template allocation tables (as Excel/CSV files)"
    # Example 1 download
    When I click on the button labeled "Example #1 (basic)"
    Then I should see a downloaded file named "RandomizationAllocationTemplate.csv"
    # Example 2 download
    When I click on the button labeled "Example #2 (all possible combos)"
    Then I should see a downloaded file named "RandomizationAllocationTemplate.csv"
    # Example 3 download
    When I click on the button labeled "Example #3 (5x all possible combos)"
    Then I should see a downloaded file named "RandomizationAllocationTemplate.csv"

 Scenario: C.3.30.0700.1300. User with Randomization Setup uploads a unique allocation table in DEVELOPMENT status (system prevents duplicate uploads).
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"

    When I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded"

    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Upload randomization allocation table - development (rid=3)|

 Scenario: C.3.30.0700.1400. User with Randomization Setup downloads the allocation table previously uploaded in DEVELOPMENT.
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"
    When I click on the button labeled "Download table"
    Then I should see a downloaded file named "RandomizationAllocationTemplate_DEV.csv"

    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Download randomization allocation table (development)|
    
 Scenario: C.3.30.0700.1600. User with Randomization Setup uploads a unique allocation table in PRODUCTION status (system prevents duplicate uploads).
    #Duplicate Upload File
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"

    When I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "ERROR: Duplicate allocation table!"

    #Different Upload File
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"

    When I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_new.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded"

    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Upload randomization allocation table - production (rid=3)|

 Scenario: C.3.30.0700.1700. User with Randomization Setup downloads the allocation table previously uploaded in PRODUCTION.
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"
    When I click on the second button labeled "Download table"
    Then I should see a downloaded file named "RandomizationAllocationTemplate_DEV.csv"

    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Download randomization allocation table (development)|

 Scenario: C.3.30.0700.1500. User with Randomization Setup deletes the allocation table previously uploaded in DEVELOPMENT.
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"
    When I click on the link labeled "Delete allocation table?"
    Then I should see a downloaded file named "Success! The allocation table has been deleted."
    And I wait for 1 second
    #VERIFY_log Randomization deleted in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Delete randomization allocation table (development)|

 Scenario: C.3.30.0700.1800. Admin deletes the allocation table previously uploaded in PRODUCTION.
    Given I logout
    And I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.30.0700."
    And I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"
    When I click on the link labeled "Delete allocation table?"
    Then I should see "Success! The allocation table has been deleted."
    And I wait for 1 second
    #VERIFY_log Randomization deleted in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design |Delete randomization allocation table (production)|

    #Removing randomization models so we can move the project to production and test 
    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the button labeled "Erase randomization model"
    Then I should see "Success! Your randomization setup and all allocations have now been erased."

    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the button labeled "Erase randomization model"
    Then I should see "Success! Your randomization setup and all allocations have now been erased."

    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the button labeled "Erase randomization model"
    Then I should see "Success! Your randomization setup and all allocations have now been erased."
    
    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the button labeled "Erase randomization model"
    Then I should see "Success! Your randomization setup and all allocations have now been erased."

    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the button labeled "Erase randomization model"
    Then I should see "Success! Your randomization setup and all allocations have now been erased."

    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the button labeled "Erase randomization model"
    Then I should see "Success! Your randomization setup and all allocations have now been erased."

  
    #SETUP_PRODUCTION (Re-adding allocation tables so the project can be moved to production)
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"

    When I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_1basic.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded"

    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"

    When I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_2allcombos.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded"

   #SETUP
    And I click on the link labeled "Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box

    #VERIFY
    Then I should see Project status: "Production"

 Scenario: C.3.30.0700.1900. Admin uploads an additional allocation table in PRODUCTION status.
    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the link labeled "Upload more allocations?"
    And I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_2allcombos2.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Success! New assignments were appended to your existing randomization allocation table!"
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design |Upload randomization allocation table to append - production (rid=9)|
    
#End
