Feature: The system shall support Bulk Delete functionality, allowing users to delete entire records or instrument-level data for multiple records within the Bulk Delete interface.

    As a REDCap end user
    I want to see that Bulk Record Delete is functioning as expected

    Scenario: #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.32.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.32.0200.100"

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Project status:  Production"

        #SET UP_USER_RIGHTS
        When I click on the link labeled "User Rights"
        And I click on the button labeled "Upload or download users, roles, and assignments"
        Then I should see "Upload users (CSV)"
        When I click on the link labeled "Upload users (CSV)"
        Then I should see "Upload users (CSV)"

        Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "Displayed below is a preview of all the changes you are about to commit."
        And I should see a table header and rows containing the following values in a table in the dialog box:
            | username   |
            | test_admin |
            | test_user1 |
            | test_user2 |
            | test_user3 |
            | test_user4 |

        Given I click on the button labeled "Upload"
        Then I should see "SUCCESS!"
        And I click on the button labeled "Close"

        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | test_admin          |
            | —                       | test_user1          |
            | —                       | test_user2          |
            | —                       | test_user3          |
            | —                       | test_user4          |
            | 1_FullRights            | [No users assigned] |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | [No users assigned] |
            | 4_NoAccess_Noexport     | [No users assigned] |

        When I click on the link labeled "test_user1"
        And I click on the button labeled "Edit user privileges"
        Then I should see "Editing existing user"
        When I check the User Right named "Delete Records"
        And I click on the button labeled "Save Changes"

        When I click on the link labeled "test_user2"
        And I click on the button labeled "Edit user privileges"
        Then I should see "Editing existing user"
        When I uncheck the User Right named "Delete Records"
        And I should see "The Delete right has been cleared for all forms"
        And I click on the button labeled "Close"
        And I click on the button labeled "Save Changes"

        ##ACTION Verify record exist ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 1         |
            | 2         |
            | 3         |
            | 4         |
            | 5         |
            | 6         |
        And I logout

    ##FUNCTIONAL_REQUIREMENT Arm 1
    Scenario: B.3.32.0200.100: Bulk Delete Records Using Custom List for arm 1
        When I login to REDCap with the user "Test_User2"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.32.0200.100"
        And I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"
        Then I should NOT see a button labeled "Bulk Record Delete"
        And I logout

        When I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.32.0200.100"
        And I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"
        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"

        And I click on the radio labeled "Delete entire records"
        And I click on the radio labeled "Enter a custom list of records"
        And I wait for 2 seconds
        And I enter "3,5" into the textarea field labeled "Step 3: Enter records to delete"
        # The following step is positioned here to ensure the record list becomes unfocused, which is required for "Valid list entered" to appear.
        And I select "Arm 1: Arm 1" on the dropdown field labeled "Delete records from a specific arm:"
        Then I should see "Valid list entered"

        #Automated: JavaScript does not fire for the alert box unless clicked again ..
        When I click on the radio labeled "Delete entire records"
        And I select "Arm 1: Arm 1" on the dropdown field labeled "Delete records from a specific arm:"
        And I click on the button labeled "Delete"

        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted 2 record(s)"

        ##ACTION Verify records deleted
        ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 1         |
            | 2         |
            | 4         |
            | 6         |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 5 | record_id = '5'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 3 | record_id = '3'                         |


    Scenario: B.3.32.0200.200: Bulk Delete Records Using Select Records from List for arm 1
        When I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"

        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"

        And I wait for 2 seconds
        When I click on the radio labeled "Delete entire records"
        And I select "Arm 1: Arm 1" on the dropdown field labeled "Delete records from a specific arm:"
        And I click on the radio labeled "Select records from a list"
        Then I should see "Step 3: Select records to delete"
        And I wait for 2 seconds

        #Note: We need the space before the digits because REDCap has them in the label
        Given I click on the checkbox labeled " 2"
        And I click on the checkbox labeled " 6"
        And I click on the button labeled "Delete"

        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted 2 record(s)"


        ##ACTION Verify record deleted 
        ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 1         |
            | 4         |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 6 | record_id = '6'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 2 | record_id = '2'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 5 | record_id = '5'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 3 | record_id = '3'                         |


    Scenario: B.3.32.0200.300: Bulk Delete Partial Records Using Custom List for arm 1
        When I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"

        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"

        When I click on the radio labeled "Partial delete (instrument-level data only)"

        Given I click on the checkbox labeled "Data Types" in the row labeled "Event 1"
        When I click on the radio labeled "Enter a custom list of records"
        And I wait for 2 seconds
        And I enter "1" into the textarea field labeled "Step 3: Enter records to delete"
        # The following step is positioned here to ensure the record list becomes unfocused, which is required for "Valid list entered" to appear.
        And I select "Arm 1: Arm 1" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."
        Then I should see "Valid list entered"

        #Automated: JavaScript does not fire for the alert box unless clicked again .
        When I click on the radio labeled "Partial delete (instrument-level data only)"
        And I click on the button labeled "Delete"
        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted forms"
        And I should see "[event_1_arm_1] data_types"
        And I should see "for 1 record(s)"

        ##ACTION Verify record exist ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 1         |
            | 4         |
        And I should see the "Incomplete (no data saved)" icon for the "Data Types" instrument on event "Event 1" for record "1"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported   |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 1 | data_types_complete = ''                  |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 6 | record_id = '6'                           |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 2 | record_id = '2'                           |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 5 | record_id = '5'                           |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 3 | record_id = '3'                           |


    Scenario: B.3.32.0200.400: Bulk Delete Partial Records Using Select Records from List for arm 1
        When I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"
        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"

        When I click on the radio labeled "Partial delete (instrument-level data only)"

        Given I click on the checkbox labeled "Text Validation" in the row labeled "Event 1"
        And I click on the checkbox labeled "Data Types" in the row labeled "Event 1"
        And I click on the checkbox labeled "Consent" in the row labeled "Event 1"
        When I click on the radio labeled "Enter a custom list of records"
        And I wait for 2 seconds
        And I enter "4" into the textarea field labeled "Step 3: Enter records to delete"
        # The following step is positioned here to ensure the record list becomes unfocused, which is required for "Valid list entered" to appear.
        And I select "Arm 1: Arm 1" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."      
        Then I should see "Valid list entered"

        #Automated: JavaScript does not fire for the alert box unless clicked again .
        When I click on the radio labeled "Partial delete (instrument-level data only)"
        And I click on the button labeled "Delete"
        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted forms"
        And I should see "[event_1_arm_1] text_validation"
        And I should see "[event_1_arm_1] data_types"
        And I should see "[event_1_arm_1] consent"
        And I should see "for 1 record(s)"

        ##ACTION Verify record exist ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 1         |
            | 4         |
        And I should see the "Incomplete (no data saved)" icon for the "Data Types" instrument on event "Event 1" for record "4"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported                                                                                                                                                |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 4 | [instance = 3], checkbox(1) = unchecked, checkbox(2) = unchecked, checkbox(3) = unchecked, data_types_complete = '', required = '', date_ymd = '', datetime_ymd_hmss = ''              |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 4 | [instance = 2], checkbox(1) = unchecked, checkbox(2) = unchecked, checkbox(3) = unchecked, data_types_complete = '', required = '', date_ymd = '', datetime_ymd_hmss = ''              |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 4 | checkbox(1) = unchecked, checkbox(2) = unchecked, checkbox(3) = unchecked, data_types_complete = '', required = '', date_ymd = '', datetime_ymd_hmss = ''                              |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 1 | data_types_complete = ''                                                                                                                                                               |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 6 | record_id = '6'                                                                                                                                                                        |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 2 | record_id = '2'                                                                                                                                                                        |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 5 | record_id = '5'                                                                                                                                                                        |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 3 | record_id = '3'                                                                                                                                                                        |


 Scenario: #SETUP adding new records to arm 2
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Add / Edit Records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
        And I wait for 1 second
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Adding new Record ID 5."

        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 5 successfully added."

        When I click on the link labeled "Add / Edit Records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
        And I wait for 1 second
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Adding new Record ID 6."

        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 6 successfully added."     

        When I click on the link labeled "Add / Edit Records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
        And I wait for 1 second
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Adding new Record ID 7."

        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 7 successfully added."

        When I click on the link labeled "Add / Edit Records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
        And I wait for 1 second
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Adding new Record ID 8."

        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 8 successfully added."  

        When I click on the link labeled "Add / Edit Records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
        And I wait for 1 second
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Adding new Record ID 9."

        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 9 successfully added." 

        When I click on the link labeled "Add / Edit Records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
        And I wait for 1 second
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Adding new Record ID 10."

        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 10 successfully added."

        When I click on the link labeled "Add / Edit Records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
        And I wait for 1 second
        And I click on the button labeled "Add new record for the arm selected above"
        Then I should see "Adding new Record ID 11."

        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 11 successfully added."    
  
    Scenario: B.3.32.0200.500: Bulk Delete Records Using Custom List for arm 2
        When I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.32.0200.100"
        And I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"
        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"

        And I click on the radio labeled "Delete entire records"
        And I click on the radio labeled "Enter a custom list of records"
        And I wait for 2 seconds
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Delete records from a specific arm:"
        And I enter "5,7" into the textarea field labeled "Step 3: Enter records to delete"
        # The following step is positioned here to ensure the record list becomes unfocused, which is required for "Valid list entered" to appear.
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Delete records from a specific arm:"
        Then I should see "Valid list entered"

        #Automated: JavaScript does not fire for the alert box unless clicked again ..
        When I click on the radio labeled "Delete entire records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Delete records from a specific arm:"
        And I click on the button labeled "Delete"

        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted 2 record(s)"

        ##ACTION Verify records deleted
        ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 2:"

        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 10        |
            | 11        |
            | 6         |
            | 8         |
            | 9         |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 7 | record_id = '7'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 5 | record_id = '5'                         |


    Scenario: B.3.32.0200.600: Bulk Delete Records Using Select Records from List for arm 2
        When I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"

        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"

        And I wait for 2 seconds
        When I click on the radio labeled "Delete entire records"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Delete records from a specific arm:"
        And I click on the radio labeled "Select records from a list"
        Then I should see "Step 3: Select records to delete"
        And I wait for 2 seconds

        #Note: We need the space before the digits because REDCap has them in the label
        When I select "Arm 2: Arm Two" on the dropdown field labeled "Delete records from a specific arm:"
        And I click on the checkbox labeled " 6"
        And I click on the checkbox labeled " 8"
        And I click on the button labeled "Delete"

        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted 2 record(s)"


        ##ACTION Verify record deleted 
        ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 2:"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 10        |
            | 11        |
            | 9         |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 8 | record_id = '8'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 6 | record_id = '6'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 7 | record_id = '7'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 5 | record_id = '5'                         |


    Scenario: B.3.32.0200.700: Bulk Delete Partial Records Using Custom List for arm 2
        When I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"

        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"

        When I click on the radio labeled "Partial delete (instrument-level data only)"
        And I click on the radio labeled "Enter a custom list of records"
        And I wait for 2 seconds
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."
        And I click on the checkbox labeled "Data Types"
        And I enter "9" into the textarea field labeled "Step 3: Enter records to delete"
        # The following step is positioned here to ensure the record list becomes unfocused, which is required for "Valid list entered" to appear.
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."
        Then I should see "Valid list entered"

        #Automated: JavaScript does not fire for the alert box unless clicked again .
        When I click on the radio labeled "Partial delete (instrument-level data only)"
        And I click on the button labeled "Delete"
        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted forms"
        And I should see "[event_1_arm_2] data_types"
        And I should see "for 1 record(s)"

        ##ACTION Verify record exist ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 2:"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 10        |
            | 11        |
            | 9         |
        And I should see the "Incomplete (no data saved)" icon for the "Data Types" instrument on event "Event 1" for record "9"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported   |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 9 | data_types_complete = ''                  |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 8 | record_id = '8'                           |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 6 | record_id = '6'                           |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 7 | record_id = '7'                           |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 5 | record_id = '5'                           |


  Scenario: B.3.32.0200.800: Bulk Delete Partial Records Using Select Records from List for arm 2
        When I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"
        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"

        When I click on the radio labeled "Partial delete (instrument-level data only)"

        When I click on the radio labeled "Enter a custom list of records"
        And I wait for 2 seconds
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."        
        And I click on the checkbox labeled "Data Types"
        And I enter "10" into the textarea field labeled "Step 3: Enter records to delete"
        # The following step is positioned here to ensure the record list becomes unfocused, which is required for "Valid list entered" to appear.
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."
        Then I should see "Valid list entered"

        #Automated: JavaScript does not fire for the alert box unless clicked again .
        When I click on the radio labeled "Partial delete (instrument-level data only)"
        And I select "Arm 2: Arm Two" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."      
        And I click on the button labeled "Delete"
        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted forms"
        And I should see "[event_1_arm_2] data_types"
        And I should see "for 1 record(s)"

        ##ACTION Verify record exist ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 2:"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 10        |
            | 11        |
            | 9         |
        And I should see the "Incomplete (no data saved)" icon for the "Data Types" instrument on event "Event 1" for record "10"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 10 | checkbox(1) = unchecked, checkbox(2) = unchecked, checkbox(3) = unchecked, required = '', calc_test = '', data_types_complete = ''|
            | mm/dd/yyyy hh:mm | test_user1 | Update record 9  | checkbox(1) = unchecked, checkbox(2) = unchecked, checkbox(3) = unchecked, required = '', calc_test = '', data_types_complete = ''|          
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 8  | record_id = '8' |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 6  | record_id = '6' |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 7  | record_id = '7' |
            | mm/dd/yyyy hh:mm | test_user1 | Delete record 5  | record_id = '5' |        
            
    Scenario: B.3.32.0200.0900: Bulk Delete with Mixed Delete Privileges
        #No delete record rights
        When I click on the link labeled "User Rights"
        And I click on the link labeled "test_user1"
        And I click on the button labeled "Edit user privileges"
        Then I should see "Editing existing user"
        When I uncheck the User Right named "Delete Records"
        And I should see "The Delete right has been cleared for all forms"
        When I click on the button labeled "Close"
        And I click on the button labeled "Save Changes"
        And I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"
        Then I should NOT see "Bulk Record Delete"

        #Instrument level delete only rights
        When I click on the link labeled "User Rights"
        And I click on the link labeled "test_user1"
        And I click on the button labeled "Edit user privileges"
        Then I should see "Editing existing user"
        When I check the checkbox in the column labeled "Delete" and the row labeled "Consent"
        And I click on the button labeled "Save Changes"
        And I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"
        Then I should see "Bulk Record Delete"
        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"
        And I should NOT see "Delete entire records"
        And I select "Arm 1: Arm 1" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."
        And I should see "Consent"
        And I should NOT see "Text Validation"
        And I should NOT see "Data Types"
        And I should NOT see "Data Dictionary Form"
        And I should NOT see "Text Validation 2"

        When I click on the radio labeled "Enter a custom list of records"
        And I wait for 2 seconds
        And I select "Arm 1: Arm 1" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."
        And I click on the checkbox labeled "Consent" in the row labeled "Event 1"
        And I enter "1" into the textarea field labeled "Step 3: Enter records to delete"
        # The following step is positioned here to ensure the record list becomes unfocused, which is required for "Valid list entered" to appear.
        And I select "Arm 1: Arm 1" on the dropdown field labeled "Select the instruments to delete for the records specified below in Step 2."
        Then I should see "Valid list entered"
        And I click on the button labeled "Delete"
        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deleted forms"
        And I should see "[event_1_arm_1] consent"
        And I should see "for 1 record(s)"
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported   |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 1 | name_consent = '', email_consent = '', dob = '', consent_complete = ''|
        And I logout
    Scenario: B.3.32.0200.1000: Bulk Delete Records Using Background Process
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"

        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"
        And I wait for 2 seconds
        And I click on the radio labeled "Select records from a list"
        Then I should see "Step 3: Select records to delete"
        And I wait for 2 seconds

        #Note: We need the space before the digits because REDCap has them in the label
        Given I click on the checkbox labeled " 1"
        And I click on the checkbox labeled " 4"
        And I click on the button labeled "Delete"
        And I check the checkbox labeled "Delete records using a background process?"

        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see " SUCCESS! Your background deletion request was successfully submitted."
        And I click on the button labeled "Close"
        Then I should see "Showing 1 to 1 of 1 entries"
        And I should see a table header and rows containing the following values in a table:
            | Status      | Deletion Time   | Completion Time          | Uploader     | Records Provided| Records Deleted |Total Deletion Time (minutes)| Errors|
            | Queued      | mm/dd/yyyy hh:mm |                         | Test_Admin   | 2               |                 |                          | 0     |
        
        #Halt the background process
        And I click on the button labeled "Halt deletion"
        Then I should see "Halt this background delete?"
        And I click on the button labeled "Yes, halt it now"
        Then I should see "The background deletion process has been successfully cancelled."
        When I click on the button labeled "Close"
        And I click on the link labeled "Logging"
        Then I should NOT see "Delete record 1 (Arm 1: Arm 1)"
        And I should NOT see "Delete record 4 (Arm 1: Arm 1)"  
        
        #Create a new background deletion request and then run the background process and check that the deletion completes successfully
        Given I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"

        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"
        And I wait for 2 seconds
        And I click on the radio labeled "Select records from a list"
        Then I should see "Step 3: Select records to delete"
        And I wait for 2 seconds

        #Note: We need the space before the digits because REDCap has them in the label
        Given I click on the checkbox labeled " 1"
        And I click on the checkbox labeled " 4"
        And I click on the button labeled "Delete"
        And I check the checkbox labeled "Delete records using a background process?"

        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see " SUCCESS! Your background deletion request was successfully submitted."
        And I click on the button labeled "Close"
        Then I should see a table header and rows containing the following values in a table:
            | Status      | Deletion Time   | Completion Time          | Uploader     | Records Provided| Records Deleted |Total Deletion Time (minutes)| Errors|
            | Queued      | mm/dd/yyyy hh:mm |                         | Test_Admin   | 2               |                 |                          | 0     |
        
        And I wait for background processes to finish
        And I wait for 3 seconds
        And I click on the link labeled "View Background Deletions"
        Then I should see a table header and rows containing the following values in a table:
            | Status         | Deletion Time    | Completion Time         | Uploader     | Records Provided| Records Deleted |Total Deletion Time (minutes)| Errors|
            | Completed      | mm/dd/yyyy hh:mm |                         | Test_Admin   | 2               |                 |                          | 0     |
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported                             |
            | mm/dd/yyyy hh:mm |SYSTEM (Test_Admin) | Delete record 4 (Arm 1: Arm 1) | record_id = '4'                               |
            | mm/dd/yyyy hh:mm |SYSTEM (Test_Admin) | Delete record 1 (Arm 1: Arm 1) | record_id = '1'                               |
        #Delete Records from a report
        Given I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"

        When I click on the button labeled "Bulk Record Delete"
        Then I should see "Bulk Record Delete"
        When I select "Arm 2: Arm Two" on the dropdown field labeled "Delete records from a specific arm:"
        And I wait for 2 seconds
        And I click on the radio labeled "All records from a report"
        Then I should see a dropdown labeled "Select report"
        When I select "Test Report" on the dropdown field labeled "All records from a report"
        
        And I click on the link labeled "Test Report"
        And I click on the button labeled "Delete"
        And I check the checkbox labeled "Delete records using a background process?"
        And I enter "delete" into the input field labeled 'TYPE "DELETE" BELOW'
        And I click on the button labeled "Delete"
        Then I should see "Deletion request submitted and will be processed soon"
        And I click on the button labeled "Close"
        Then I should see a table header and rows containing the following values in a table:
            | Status         | Deletion Time    | Completion Time         | Uploader     | Records Provided| Records Deleted |Total Deletion Time (minutes)| Errors|
            | Queued      | mm/dd/yyyy hh:mm |                            | Test_Admin   | 3               |                 |                          | 0     |
       
        And I wait for background processes to finish
        And I wait for 3 seconds
        And I click on the link labeled "View Background Deletions"
        Then I should see a table header and rows containing the following values in a table:
            | Status         | Deletion Time    | Completion Time         | Uploader     | Records Provided| Records Deleted |Total Deletion Time (minutes)| Errors|
            | Completed      | mm/dd/yyyy hh:mm |                         | Test_Admin   | 3               |                 |                          | 0     |
       
        #Validate Logging
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username           | Action           | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm |SYSTEM (Test_Admin) | Delete record 11 (Arm 1: Arm 1) | record_id = '11'          |
            | mm/dd/yyyy hh:mm |SYSTEM (Test_Admin) | Delete record 10 (Arm 1: Arm 1) | record_id = '10'          |
            | mm/dd/yyyy hh:mm |SYSTEM (Test_Admin) | Delete record 9 (Arm 1: Arm 1)  | record_id = '9'          |

        #Verify Email was sent when background deletion is completed
        And I verify that an email was sent to "a@b.com" with a subject containing "D" and content containing "E"
#END