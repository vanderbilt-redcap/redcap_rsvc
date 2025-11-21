Feature: C.3.30.0900.	User Interface: The system shall ensure users with Randomization Setup rights lock randomization models and allocation table while in production mode.	
As a REDCap end user
I want to see that Randomization is functioning as expected

Scenario: #SETUP - Create new project
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "C.3.30.0900" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "C.3.30.OneRand.xml", and clicking the "Create Project" button

#SETUP randomization 
When I click on the link labeled "Project Setup"
And I click on the button labeled "Set up randomization"
And I click on the icon in the column labeled "Setup" and the row labeled "1"
And I upload a "csv" format file located at "import_files/AlloRand rand_group3.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload File" to upload the file
And I upload a "csv" format file located at "import_files/AlloRand rand_group4.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload File" to upload the file
When I click on the link labeled "Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status:  Production"

#SETUP User Rights
When I click on the link labeled "User Rights"
And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role" 
And I click on the button labeled "Assign to role"
And I select "1_FullRights" on the dropdown field labeled "Select Role"
And I click on the button labeled exactly "Assign"
Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

And I logout

Scenario: C.3.30.0900.0100. Normal user cannot modify setup in production. 
Given I login to REDCap with the user "Test_User1"
And I click on the link labeled "My Projects"
And I click on the link labeled "C.3.30.0900"
And I click on the link labeled "Project Setup"
And I click on the button labeled "Set up randomization"
And I click on the icon in the column labeled "Setup" and the row labeled "1"

# #verify unable to erase randomization model
And I should see the button labeled "Erase randomization model" is disabled

#Verify unable to modify Stratification
And I should see a checkbox labeled "A) Use stratified randomization?" that is checked

#Verify unable to change randomize by group/site
And I should see a checkbox labeled "B) Randomize by group/site?" that is in the disabled state


#verify unable to change randomization field
And I should see the dropdown labeled "rand_group (Randomization group 1)" is disabled

#verify unable to upload or download allocation table for use in Development
And I should see a button labeled "Download table" in the row labeled "for use in DEVELOPMENT status" that is disabled

#verify unable to upload or download allocation table for use in Production 
And I should see a button labeled "Download table" in the row labeled "for use in PRODUCTION status" that is disabled

And I logout

Scenario: C.3.30.0900.0200. Admin user unable to revert project to development.  
Given I login to REDCap with the user "Test_Admin"
And I click on the link labeled "My Projects"
And I click on the link labeled "C.3.30.0900"
And I click on the link labeled "Project Setup"
And I click on the link labeled "Other Functionality"
Then I should see "Because Randomization is enabled, the project cannot be moved back to Development status."
And I should see the button labeled "Move back to Development status" is disabled

# Scenario: C.3.30.0900.0300. Admin cannot modify setup in production.  
Given I click on the link labeled "Project Setup"
And I click on the button labeled "Set up randomization"
And I click on the icon in the column labeled "Setup" and the row labeled "1"

# # # #verify unable to erase randomization model
And I should see the button labeled "Erase randomization model" is disabled

# # # # #Verify unable to modify Stratification
And I should see a checkbox labeled "A) Use stratified randomization?" that is checked

# #Verify unable to change randomize by group/site
And I should see a checkbox labeled "B) Randomize by group/site?" that is in the disabled state

#verify unable to change randomization field
And I should see the dropdown labeled "rand_group (Randomization group 1)" is disabled

#verify unable to upload or download allocation table for use in Development
And I should see a button labeled "Download table" that is disabled 

Scenario: C.3.30.0900.0400. Admin can download existing allocation table in production.  
#verify able to download allocation table for use in Production
Then I should see a link labeled "Upload more allocations? (Administrators only)"
And I should see a button labeled "Download table"
And I should see "(only REDCap admins may download the allocation table while in production)"

Given I click on the second button labeled "Download table"
Then I should see a downloaded file named "RandomizationAllocationTable_Prod.csv"

# Scenario: C.3.30.0900.0500. Admin cannot modify existing allocation table in production. 
# #verify unable to delete or change allocation table for use in Production
And I should NOT see "Delete allocation table?" 

Scenario: C.3.30.0900.0600. Admin can upload additional allocations to existing table in production.
#verify able to upload more allocations (Administrators only)
When I click on the link labeled "Upload more allocations? (Administrators only)"
When I upload a "csv" format file located at "import_files/RandomizationAllocationTable_Prod0900.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload File" to upload the file
Then I should see "Success! New assignments were appended to your existing randomization allocation table!"

#verify logging for the upload
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported           |
| mm/dd/yyyy hh:mm | test_admin | Manage/Design |Upload randomization allocation table to append - production (rid=2)|

And I logout

#End