Feature: Creating a Record and Entering Data: The system shall support the ability to create a record

    As a REDCap end user
    I want to see that record creation is functioning as expected

    Scenario: B.3.14.0100.100 Create new record
        #SETUP_PRODUCTION
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.14.0100.100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        ##SETUP_USER_RIGHTS
        # User with create access
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Add new user"
        And I click on the button labeled "Add with custom rights"
        And I check the User Right named "Create Records"
        And I check the User Right named "Logging"
        And I click on the button labeled "Add user"
        Then I should see "Test User1"

        # User without create access
        And I enter "Test_User2" into the field with the placeholder text of "Add new user"
        And I click on the button labeled "Add with custom rights"
        And I uncheck the User Right named "Create Records"
        And I check the User Right named "Logging"
        And I click on the button labeled "Add user"
        Then I should see "Test User2"
        And I logout

        ##ACTION: login as user with create record access - and can edit record
        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.14.0100.100"
        #FUNCTIONAL REQUIREMENT
        ##ACTION: create record
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

        ##VERIFY
        Then I should see "Record ID 7 successfully added"

        ##VERIFY_LOG:
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user1 | Create record7 | record_id = '7'                         |

        #VERIFY_RSD:
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "7"
        Then I should see "Record ID 7"

        ##VERIFY_DE
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see a table header and rows containing the following values in the report data table:
            | Record ID |
            | 7         |

        ###VERIFY Can edit existing record
        Given I click on the link labeled "Add / Edit Records"
        And I select record ID "1" from arm name "Arm 1: Arm 1" on the View / Edit record page
        And I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
        And I clear field and enter "EDIT1" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        Then I should see "Record ID 1 successfully edited"
        And I logout

        ##ACTION: login as user without create record access - but can edit record
        Given I login to REDCap with the user "Test_User2"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.14.0100.100"
        And I click on the link labeled "View / Edit Records"
        ##VERIFY: Cannot add record
        Then I should NOT see the button labeled "Add new record for the arm selected above"

        ###VERIFY Can edit existing record
        And I select record ID "1" from arm name "Arm 1: Arm 1" on the View / Edit record page
        And I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
        And I clear field and enter "EDIT2" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        Then I should see "Record ID 1 successfully edited"

        ##VERIFY_LOG: Existing record updated
        And I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_user2 | Update record 1 | name = 'EDIT2'                         |
            | mm/dd/yyyy hh:mm | test_user1 | Update record 1 | name = 'EDIT1'                         |
#END