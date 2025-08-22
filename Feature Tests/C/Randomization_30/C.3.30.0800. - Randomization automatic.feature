Feature: User Interface: The system shall ensure users with Randomization Setup can create or modify the automatic triggering options: Manual, Users with Randomize permission, all users (including survey).
  As a REDCap end user
  I want to see that Randomization is functioning as expected

Scenario: #SETUP project with randomization enabled
Given on automation only I get this feature working before removing this line
Given I login to REDCap with the user "Test_User1"
And I create a new project named "C.3.30.0800" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "C.3.30 TriggerRand.REDCap.xml", and clicking the "Create Project" button

#SETUP User Rights
Scenario: #SETUP User Rights
  When I click on the link labeled "User Rights"
  And I click on the link labeled "Test User1"
  And I click on the button labeled "Assign to role" on the tooltip
  And I select "1_FullRights" on the dropdown field labeled "Select Role"
  And I click on the button labeled exactly "Assign"
  Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
  
    #Adding user Test_User2 (No randomization rights)
  When I click on the link labeled "User Rights"
  And I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
  And I click on the button labeled "Assign to role"
  And I select "5_NoRand" on the dropdown field labeled "Select Role" on the role selector dropdown
  When I click on the button labeled exactly "Assign" on the role selector dropdown
  Then I should see "Test User2" within the "5_NoRand" row of the column labeled "Username" of the User Rights table

  #SETUP randomization for 0100
  When I click on the link labeled "Project Setup"
  And I click on the button labeled "Set up randomization"
  And I click on the button labeled "Add new randomization model"
  Then I should see "STEP 1: Define your randomization model"
  And I select "rand_group (Randomization group)" on the first dropdown field labeled "- select a field -"
  And I click on the button labeled "Save randomization model" and accept the confirmation window
  When I upload a "csv" format file located at "import_files/AlloRand rand_group1.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
  When I upload a "csv" format file located at "import_files/AlloRand rand_group2.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload" to upload the file

Scenario: C.3.30.0800.0100. Manual only, using Randomize button (default)  
  When I click on the link labeled "Add / Edit Records"
  And I select "1" on the dropdown field labeled "Choose an existing Record ID"
  And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
  Then I should see "Randomization group"

  #VERIFY User can Randomize Manually, using Randomize Button
  When I click on a button labeled "Randomize"
  Then I should see a dialog containing the following text: 'Below you may perform randomization for Record ID "1" on the field Randomization group (rand_group).'
  And I click on the button labeled "Randomize"
  Then I should see a dialog containing the following text: 'Record ID "1" was randomized for the field "Randomization group" and assigned the value "Drug A" (1).'
  And I click on the button labeled "Close"
  And I click on the button labeled "Save & Exit Form"

  #VERIFY - Logging
  When I click on the link labeled "Logging"
  Then I should see a table header and rows containing the following values in the logging table:
    | Username   | Action             | List of Data Changes OR Fields Exported      |
    | test_user1 | Update record 1    |                                              |
    | test_user1 | Randomize Record 1 | Randomize record |
    | test_user1 | Update record 1  | rand_group = '1' |

#SETUP Randomization for 0200
Scenario: C.3.30.0800.0200. Trigger logic, for users with Randomize permissions only  
  When I click on the link labeled "Setup"
  And I click on the button labeled "Set up randomization"
  And I click on the button labeled "Add new randomization model"
  Then I should see "STEP 1: Define your randomization model"
  And I select "auto_rand (Automatic Randomization)" on the first dropdown field labeled "- select a field -"
  And I click on the button labeled "Save randomization model" and accept the confirmation window
  And I upload a "csv" format file located at "import_files/AlloRand rand_group1.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
  And I upload a "csv" format file located at "import_files/AlloRand rand_group2.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload" to upload the file
  And I select "Trigger logic, for users with Randomize permission only" on the dropdown field labeled "Trigger option" on the tooltip

  And I select "Demographics" on the dropdown field labeled "Instrument" on the tooltip
  And I click on "" in the textarea field labeled "Trigger logic"
  And I wait for 1 second
  And I enter "[fname]<>'' and [lname]<>''" into the textarea field labeled "Logic Editor" in the dialog box
  And I click on the button labeled "Update & Close Editor" in the dialog box
  And I click on the button labeled "Save trigger option"

  When I click on the link labeled "Add / Edit Records"
  And I click on the button labeled "Add new record"
  And I click the bubble for the row labeled "Demographics" on the column labeled "Status"
  And I enter "Donald" into the data entry form field labeled "First name" 
  And I enter "Duck" into the data entry form field labeled "Last name" 
  And I click on the button labeled "Save & Exit Form"
  Then I should see "Record ID 6 successfully added." 

  #VERIFY Trigger logic, for users with Randomize permissions only
  When I click the bubble for the row labeled "Randomization" on the column labeled "Status"
  Then I should see "Already randomized"
  Then I should see the radio labeled "Automatic Randomization" with option "Group 1" selected

  #VERIFY - Logging
  When I click on the link labeled "Logging"
  Then I should see a table header and rows containing the following values in the logging table:
    | Username   | Action             | List of Data Changes OR Fields Exported|
    | test_user1 | Randomize Record 6 | Randomize record (via trigger)|
    | test_user1 | Update record 6    | auto_rand = '1'|
    | test_user1 | Create record 6    | fname = 'Donald', lname = 'Duck', demographics_complete = '0', record_id = '6' |
    | test_user1 | Manage/Design      | Save randomization execute option (rid = 3) |

  #SETUP randomization for 0300 and 0400
  When I click on the link labeled "Setup"
  And I click on the button labeled "Set up randomization"
  And I click on the button labeled "Add new randomization model"
  Then I should see "STEP 1: Define your randomization model"
  And I select "rand_survey (Go to:)" on the first dropdown field labeled "- select a field -"
  And I click on the button labeled "Save randomization model" and accept the confirmation window
  And I upload a "csv" format file located at "import_files/AlloRand rand_group1.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
  And I upload a "csv" format file located at "import_files/AlloRand rand_group2.csv", by clicking the button near "for use in PRODUCTION status" to browse for the file, and clicking the button labeled "Upload" to upload the file
  And I select "Trigger logic, for all users (including survey respondents)" on the dropdown field labeled "Trigger option" on the tooltip 
  And I select "Survey" on the dropdown field labeled "Instrument" on the tooltip
  And I click on "" in the textarea field labeled "Trigger logic"
  And I wait for 1 second
  And I enter "[survey_complete]='2'" into the textarea field labeled "Logic Editor" in the dialog box
  And I click on the button labeled "Update & Close Editor"
  And I click on the button labeled "Save trigger option"
  And I click on the link labeled "Home"
  And I logout

Scenario: C.3.30.0800.0300 Trigger logic, for all users based on form  
  Given I login to REDCap with the user "Test_User2"
  And I click on the link labeled "My Projects"
  And I click on the link labeled "C.3.30.0800"
  And I click on the link labeled "Add / Edit Records"
  And I click on the button labeled "Add new record"
  And I click the bubble for the row labeled "Survey" on the column labeled "Status"
  Then I should see "Not yet randomized"
  And I should see a radio labeled "Survey A" in the row labeled "Not yet randomized" that is disabled
  And I should see a radio labeled "Survey B" in the row labeled "Not yet randomized" that is disabled
  And I should see a radio labeled "Survey C" in the row labeled "Not yet randomized" that is disabled
  And I should see a radio labeled "Survey D" in the row labeled "Not yet randomized" that is disabled
  And I select the radio option "Yes" for the field labeled "Will you complete the survey?" 

  And I select the dropdown option "Complete" for the Data Collection Instrument field labeled "Complete?" 
  And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  #VERIFY Trigger logic, for all users based on form
  Then I should see "Already randomized"  
  And I should see the radio labeled "Go to:" with option "Survey A" selected

Scenario: C.3.30.0800.0400 Trigger logic, for all users based on survey  
  When I click on the link labeled "Add / Edit Records"
  And I click on the button labeled "Add new record"
  And I click the bubble for the row labeled "Survey" instrument on the column labeled "Status"
  Then I should see "Not yet randomized"
  And I should see a radio labeled "Survey A" in the row labeled "Not yet randomized" that is disabled
  And I should see a radio labeled "Survey B" in the row labeled "Not yet randomized" that is disabled
  And I should see a radio labeled "Survey C" in the row labeled "Not yet randomized" that is disabled
  And I should see a radio labeled "Survey D" in the row labeled "Not yet randomized" that is disabled
  And I select the radio option "Yes" for the field labeled "Will you complete the survey?"
  And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
  And I click on the button labeled "Survey options"
  And I click on the survey option label containing "Log out+ Open survey" label
  And I click on the button labeled "Submit"
  And I click on the button labeled "Close survey"
  And I return to the REDCap page I opened the survey from

  #VERIFY Trigger Logic, for all users based on survey
  Given I login to REDCap with the user "Test_User1"
  And I click on the link labeled "My Projects"
  And I click on the link labeled "C.3.30.0800"
  And I click on the link labeled "Add / Edit Records"
  And I select "8" on the dropdown field labeled "Choose an existing Record ID"
  And I click the bubble for the row labeled "Survey" instrument on the column labeled "Status" 
  Then I should see "Already randomized"
  And I should see the radio labeled "Go to:" with option "Survey B" selected

  When I click on the link labeled "User Rights"
  And I enter "Test_Admin" into the field with the placeholder text of "Add new user"
  And I click on the button labeled "Add with custom rights"
  And I click on the button labeled "Add user"
  And I logout

  #SETUP move project to production
  Given I login to REDCap with the user "Test_Admin"
  And I click on the link labeled "My Projects"
  And I click on the link labeled "C.3.30.0800"
  And I click on the button labeled "Move project to production"
  And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
  And I click on the button labeled "YES, Move to Production Status" in the dialog box
  Then I should see Project status: "Production"
  And I logout
  

   #VERIFY - Logging
  Given I login to REDCap with the user "Test_User1"
  And I click on the link labeled "My Projects"
  And I click on the link labeled "C.3.30.0800"
  When I click on the link labeled "Logging"
  Then I should see a table header and rows containing the following values in the logging table:
    | Time / Date      | Username            | Action             | List of Data Changes OR Fields Exported |
    | mm/dd/yyyy hh:mm | [survey respondent] | Randomize Record 8 | Randomize record (via trigger) |
    | mm/dd/yyyy hh:mm | [survey respondent] | Update Response 8  | rand_survey = '2' |
    | mm/dd/yyyy hh:mm | [survey respondent] | Update Response 8  | survey_complete = '2' |
    | mm/dd/yyyy hh:mm | test_user2          | Create record 8    | will_survey = '1', survey_complete = '0', record_id = '8' |
    | mm/dd/yyyy hh:mm | test_user2          | Randomize Record 7 | Randomize record (via trigger) |
    | mm/dd/yyyy hh:mm | test_user2          | Update record 7    | rand_survey = '1' |
    | mm/dd/yyyy hh:mm | test_user2          | Create record 7    | survey_complete = '2', record_id = '7' |
    | mm/dd/yyyy hh:mm | test_user1          | Manage/Design      | Save randomization execute option (rid = 4) |

Scenario: C.3.30.0800.0500 Modify trigger while in production
  When I click on the link labeled "Setup"
  And I click on the button labeled "Set up randomization"
  And I click on the icon in the column labeled "Setup" and the row labeled "3"
  And I select "Trigger logic, for users with Randomize permission only" on the dropdown field labeled "Trigger option" on the tooltip
  And I select "Demographics" on the dropdown field labeled "Instrument" on the tooltip
  And I click on "" in the textarea field labeled "Trigger logic"
  And I wait for 1 second
  And I clear field and enter "[demographics_complete]='2'" into the textarea field labeled "Logic Editor" in the dialog box
  And I click on the button labeled "Update & Close Editor"
  And I click on the button labeled "Save trigger option"
  And I logout

  #VERIFY Modify trigger while in production
  Given I login to REDCap with the user "Test_User2"
  And I click on the link labeled "My Projects" 
  And I click on the link labeled "C.3.30.0800"
  And I click on the link labeled "Add / Edit Records"
  And I select "7" on the dropdown field labeled "Choose an existing Record ID"
  And I click the bubble for the row labeled "Survey" on the column labeled "Status"
  Then I should see the radio labeled "Will you complete the survey?" with option "Yes" selected
  Then I should see the radio labeled "Go to" with option "Survey A" unselected
  Then I should see "Not yet randomized"

  #VERIFY Test_User2 can no longer randomize this record
  When I click on the link labeled "Demographics"
  And I wait for 2 seconds
  And I select the dropdown option "Complete" for the Data Collection Instrument field labeled "Complete?"
  And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
  And I click the bubble for the row labeled "Survey" on the column labeled "Status"
  Then I should see a dialog containing the following text: "Not yet randomized" 
  And I logout 

  #VERIFY Test_User1 can randomize this record
  Given I login to REDCap with the user "Test_User1"
  And I click on the link labeled "My Projects"
  And I click on the link labeled "C.3.30.0800"
  And I click on the link labeled "Add / Edit Records"
  And I select "7" on the dropdown field labeled "Choose an existing Record ID"
  And I click the bubble for the row labeled "Survey" on the column labeled "Status"
  Then I should see a button labeled "Randomize" 
  And I click on the "Randomize" button for the field labeled "Go to"
  And I click on the button labeled "Randomize"
  And I click on the button labeled "Close"
  And I should see the radio labeled "Go to" with option "Survey C" selected
  And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

  #VERIFY - Logging
  When I click on the link labeled "Logging"
  Then I should see a table header and rows containing the following values in the logging table:
    | Username   | Action        | List of Data Changes OR Fields Exported      |
    | test_user1 | Update record 7 | survey_complete = '2' |
    | test_user1 | Randomize Record 7 | Randomize record |
    | test_user1 | Update record 7 | rand_survey = '3', survey_complete = '0' |
    | test_user2 | Update record 7  | demographics_complete = '2' |
    | test_user1 | Manage/Design | Save randomization execute option (rid = 2) |
    | test_admin | Manage/Design | Move project to Production status |
    | test_admin | Update record 8 | rand_survey = '' |
    | test_admin | Update record 7 | rand_survey = '' |
    | test_admin | Update record 6 | auto_rand = '' |
    | test_admin | Update record 1 | rand_group = '' |

  And I logout
#END
