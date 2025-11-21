Feature: C.3.30.1500.	User Interface: The system shall support blinded and open randomization models, with access to allocation details based on user permissions and model setup.
As a REDCap end user
I want to see that Randomization is functioning as expected

Scenario: #SETUP project with randomization enabled
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.1500." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button
    
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
    And I uncheck the checkbox labeled "Setup"
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
    When I upload a "csv" format file located at "import_files/Randomization_one_strat.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded"

    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model" 
    And I select "rand_blind" on the dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"
    When I upload a "csv" format file located at "import_files/C3.30BlindAllocationTemplate.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded"

    #SETUP -  Create a record and randomize with both Open and Blinded Randomization fields.
    When I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Demographics" on the column labeled "Status"
    And I select the radio option "Yes" for the field labeled "Stratification 1"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 2 successfully edited."
    When I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the first button labeled "Randomize"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    When I click on the button labeled "Randomize" in the dialog box
    Then I should see "was randomized for"
    And I click on the button labeled "Close" in the dialog box

    When I click on the button labeled "Randomize"
    Then I should see a dialog containing the following text: "Below you may perform randomization for Record ID"
    When I click on the button labeled "Randomize" in the dialog box
    Then I should see "was randomized for"
    And I click on the button labeled "Close" in the dialog box
    
    When I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 2 successfully edited."
   
Scenario: #C.3.30.1500.0100. For a blinded model, users without setup rights will see only a concealed allocation code in the record and reports, with no visible group assignment.  
    Given I logout
    And I login to REDCap with the user "Test_User2"
    And I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"

    #Verify the user can only see a concealed allocation code in the record with no visible group assignment.  
    Then I should see "Already randomized"
    And I should see "01" in the data entry form field "Blinded randomization" 
    
    #Verify the user can only see a concealed allocation code in reports with no visible group assignment.  
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
            | Record ID | Blinded randomization |
            | 1         |                       |
            | 2         | 01                    |
            | 3         |                       |
            | 4         |                       |
            | 5         |                       |

  Scenario: #C.3.30.1500.0200. For an open model, users without setup rights can view the assigned group allocation directly in the record and reports.  
    Given I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"

    #Verify the user can see the assigned group allocation code directly in the record
    Then I should see "Already randomized"
    And I should see a radio labeled "Drug A" in the row labeled "Randomization group 1" that is disabled
    And I should see a radio labeled "Drug B" in the row labeled "Randomization group 1" that is disabled
    And I should see a radio labeled "Placebo" in the row labeled "Randomization group 1" that is disabled
   
    #Verify the user can see the assigned group allocation code directly in reports
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
            | Record ID | Stratification 1 |
            | 1         |                       |
            | 2         | Yes (1)               |
            | 3         |                       |
            | 4         |                       |
            | 5         |                       |

Scenario: #C.3.30.1500.0300. All users with export rights can export randomized records, seeing the allocation assigned to each record as displayed in the record view.  
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
            | Record ID | Stratification 1 | Randomization group | Blinded randomization|
            | 1         |                  |                     |                      |
            | 2         | Yes (1)          | Drug A (1)          |01                    |
            | 3         |                  |                     |                      |
            | 4         |                  |                     |                      |
            | 5         |                  |                     |                      |
    
Scenario:#C.3.30.1500.0400. Only users with setup rights or admin privileges can access and export the full allocation table directly from the setup interface, regardless of model type.
    When I click on the link labeled "Setup"
    Then I should see the button labeled "Set up randomization" is disabled
    Given I logout

    #Verify user with setup rights can access and export the full allocation table directly from the setup interface, (rand_group) open randomization type
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"
    When I click on the button labeled "Download table"
    Then I should see a downloaded file named "RandomizationAllocationTable_Dev.csv"

    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Download randomization allocation table (development)|

    #Verify User with setup rights can access and export the full allocation table directly from the setup interface, (rand_blind) blind randomization type
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "2" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"
    When I click on the button labeled "Download table"
    Then I should see a downloaded file named "RandomizationAllocationTable_Dev.csv"

    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Download randomization allocation table (development)|
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Download randomization allocation table (development)|
    Given I logout

    #Verify Admin User can access and export the full allocation table directly from the setup interface, (rand_group) open randomization type
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"
    When I click on the button labeled "Download table"
    Then I should see a downloaded file named "RandomizationAllocationTable_Dev.csv"

    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_user1 | Manage/Design |Download randomization allocation table (development)|

    #Verify User with setup rights can access and export the full allocation table directly from the setup interface, (rand_blind) blind randomization type
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "2" 
    Then I should see "STEP 3: Upload your allocation table (CSV file)"
    When I click on the button labeled "Download table"
    Then I should see a downloaded file named "RandomizationAllocationTable_Dev.csv"

    #VERIFY_log Randomization saved in logging table
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design |Download randomization allocation table (development)|
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design |Download randomization allocation table (development)|

Given I logout
#End