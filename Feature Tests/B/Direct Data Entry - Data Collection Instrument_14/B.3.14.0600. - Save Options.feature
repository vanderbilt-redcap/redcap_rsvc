Feature: Saving Data: The system shall support the ability to: (Save and stay | Save & Go To Next Form | Save & Mark as Complete | Save & Exit Form|  Save & Exit Record | Save & Go To Next Record | Cancel the data entered and leave the record without saving)

    As a REDCap end user
    I want to see that saving data is functioning as expected

    Scenario: B.3.14.0600.100 Save and Stay
        #ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        Then I should see "System-level User Settings"
        Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        When I click on the button labeled "Save Changes"
        And I see "Your system configuration values have now been changed!"
        Then I logout

        #SETUP
        Given I login to REDCap with the user "Test_User1"
        And I create a new project named "B.3.14.0600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #FUNCTIONAL_REQUIREMENT:
        ##ACTION: SAVE & STAY
        Given I click on the link labeled "Add / Edit Records"
        When I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        Then I should see "Adding new Record ID 7"

        When I enter "SAVE & STAY" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        ##VERIFY
        Then I should see "Record ID 7 successfully edited."
        
    Scenario: B.3.14.0600.200 Save & Go To Next Form
        #SETUP create record
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        Then I should see "Adding new Record ID 8"

        #FUNCTIONAL_REQUIREMENT:
        ##ACTION: SAVE & GO TO NEXT FORM       
        When I enter "SAVE & GO TO NEXT FORM" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Go To Next Form" on the Data Collection Instrument
        
        ##VERIFY
        And I should see "Data Types"

    Scenario: B.3.14.0600.300 Save & Mark as Complete
        #SETUP create record
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Leave without saving changes" in the dialog box
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        Then I should see "Adding new Record ID 9"
        
        #FUNCTIONAL_REQUIREMENT:
        ##ACTION  SAVE & MARK AS COMPLETE
        When I enter "SAVE & MARK AS COMPLETE" into the data entry form field labeled "Name"
        And I select "Complete" on the dropdown field labeled "Complete?"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        
        ##VERIFY
        Then I should see "Record ID 9 successfully added."

    Scenario: B.3.14.0600.400 Save & Exit Form
        #SETUP create record
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        Then I should see "Adding new Record ID 10"

        #FUNCTIONAL_REQUIREMENT:
        ##ACTION  SAVE & EXIT FORM
        When I enter "SAVE & EXIT FORM" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

        ##VERIFY
        Then I should see "Record ID 10 successfully added."

    Scenario: B.3.14.0600.500 Save & Exit Record
        #SETUP create record
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        
        ##VERIFY
        Then I should see "Adding new Record ID 11"

        #FUNCTIONAL_REQUIREMENT:
        ##ACTION Save & EXIT RECORD
        When I enter "SAVE & EXIT RECORD" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument
        
        ##VERIFY
        Then I should see "Record ID 11 successfully edited"

    Scenario: B.3.14.0600.600 Save & Go To Next Record
        #FUNCTIONAL_REQUIREMENT:
        ##ACTION Save & Go To Next Record
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        
        ##VERIFY
        Then I should see "Adding new Record ID 12"
        And I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument
        
        ##VERIFY
        Then I should see "Record ID 12 successfully edited"

        Given I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "11" and click on the bubble
        When I clear field and enter "SAVE & GO TO NEXT RECORD" into the data entry form field labeled "Name"
        And I select the submit option labeled "Save & Go To Next Record" on the Data Collection Instrument
        
        ##VERIFY
        Then I should see "Record ID 11 successfully edited."
        And I should see "Now displaying the next record: Record ID 12"

    Scenario: B.3.14.0600.700 Cancel
        #SETUP create record
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
        Then I should see "Adding new Record ID 13"

        #FUNCTIONAL_REQUIREMENT:
        ##ACTION: CANCEL DATA
        When I enter "CANCEL" into the data entry form field labeled "Name"
        And I click on the button labeled "Cancel"

        #MANUAL-ONLY step: Automated accepts confirmation windows because of default Cypress behavior
        #And I click on the button labeled "OK" in the pop-up box

        ##VERIFY
        Then I should see "Record ID 13 data entry cancelled - not saved"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action          | List of Data Changes OR Fields Exported |
            | test_user1 | Update record11 | name = 'SAVE & GO TO NEXT RECORD'       |
            | test_user1 | Create record11 | name = 'SAVE & EXIT RECORD'             |
            | test_user1 | Create record10 | name = 'SAVE & EXIT FORM'               |
            | test_user1 | Create record9  | name = 'SAVE & MARK COMPLETE'           |
            | test_user1 | Create record8  | name = 'SAVE & GO TO NEXT FORM'         |
            | test_user1 | Create record7  | name = 'SAVE & STAY'                    |

        ##VERIFY_DE:
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see "All data (all records and fields)"
        And I should see a table header and rows containing the following values in the report data table:
            | Record ID | Event Name             | Name                     |
            | 7         | Event 1 (Arm 1: Arm 1) | SAVE & STAY              |
            | 8         | Event 1 (Arm 1: Arm 1) | SAVE & GO TO NEXT FORM   |
            | 9         | Event 1 (Arm 1: Arm 1) | SAVE & MARK COMPLETE     |
            | 10        | Event 1 (Arm 1: Arm 1) | SAVE & EXIT FORM         |
            | 11        | Event 1 (Arm 1: Arm 1) | SAVE & GO TO NEXT RECORD |
            | 12        | Event 1 (Arm 1: Arm 1) |                          |

#END