Feature: C.3.30.1200.	User Interface: The system shall support an audit trail showing who randomized the record and the date-time of randomization.

Scenario: #SETUP - Create new project
Given I login to REDCap with the user "Test_User1"
And I create a new project named "C.3.30.1200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button

Scenario: #SETUP User Rights
When I click on the link labeled "User Rights"
And I click on the link labeled "Test User1" 
And I click on the button labeled "Assign to role"
And I select "1_FullRights" on the dropdown field labeled "select role"
And I click on the button labeled exactly "Assign"
Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

#SETUP Creating randomiztion stategy and adding allocation table.
When I click on the link labeled "Setup"
And I click on the button labeled "Set up randomization"
And I click on the button labeled "Add new randomization model"
And I select "rand_blind (Blinded randomization)" on the first dropdown field labeled "- select a field -"
And I click on the button labeled "Save randomization model"
Then I should see "Success! The randomization model has been saved!"
And I upload a "csv" format file located at "import_files/AlloRand blind1.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
And I click on the link labeled "Summary"
And I click on the button labeled "Add new randomization model"
And I select "rand_group (Randomization group 1)" on the first dropdown field labeled "- select a field -"
And I click on the button labeled "Save randomization model"
Then I should see "Success! The randomization model has been saved!"
And I upload a "csv" format file located at "import_files/AlloRand open1.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file

Scenario: #C.3.30.1200.0100. Logging of record's randomization includes user and timestamp.  
Given I click on the link labeled "Add / Edit Records"
And I click on the button labeled "Add new record"
And I click the bubble for the row labeled "Randomization" instrument on the column labeled "Status"
And I click on the first button labeled "Randomize"
And I should see "Below you may perform randomization"
And I click on the button labeled "Randomize"
Then I should see a dialog containing the following text: 'Record ID "6" was randomized for the field "Randomization group 1" and assigned the value "Drug A" (1).'
And I click on the button labeled "Close"
And I click on the button labeled "Randomize"
And I should see "Below you may perform randomization"
And I click on the button labeled "Randomize"
Then I should see a dialog containing the following text: 'Record ID "6" was randomized for the field "Blinded randomization" and assigned the value "1".'
And I click on the button labeled "Close"
And I click on the button labeled "Save & Exit Form"

Scenario: #C.3.30.1200.0200 Logging includes the target field allocation value.
#VERIFY: Logging of record's randomization includes user and timestamp.  
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
   | Time / Date       | Username   | Action             | List of Data Changes OR Fields Exported     |
   | mm/dd/yyyy hh:mm | test_user1 | Randomize Record 6 | Randomize record                             |
   | mm/dd/yyyy hh:mm | test_user1 | Update record 6    | rand_blind = '1' |
   | mm/dd/yyyy hh:mm | test_user1 | Randomize Record 6 | Randomize record                             |
   | mm/dd/yyyy hh:mm | test_user1 | Create record 6    | record_id = '6', rand_group = '1', randomization_complete = '0' |
   

#C.3.30.1200.0300 Allocation group is visible in logging for open models.
# This feature test is REDUNDANT and can be viewed in C.3.30.1200.0200 where "rand_group = '1'"

Scenario: # C.3.30.1200.0400 Concealed allocation group remains hidden in logging for blinded models.
#VERIFY: Concealed allocation group remains hidden in logging for blinded models.
And I should NOT see "Group A"  

And I logout
#End
