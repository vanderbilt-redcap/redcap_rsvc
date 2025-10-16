Feature: Creating a Record and Entering Data: The system shall support data entry for the defined core field types.

  As a REDCap end user
  I want to see that data entry for field type is functioning as expected

  Scenario: B.3.14.0200.100 Appropriate data entry by field type
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
    And I create a new project named "B.3.14.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.3.14.0200.100"
    And I click on the link labeled "Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see Project status: "Production"

    #SETUP
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 7"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Data entry various field types
    Given I select the radio option "Choice99" for the field labeled "radio"
    And I select "DDChoice6" on the dropdown field labeled "Multiple Choice Dropdown Manual"
    And I enter "Notes box" into the data entry form field labeled "Notes box 2"
    And I select the checkbox option "Checkbox2" for the field labeled "Checkbox"

    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    Given I click on the link labeled "Upload file"
    And I upload a "docx" format file located at "import_files/File_Upload.docx", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file

    Given I select the radio option "True" for the field labeled "True/False"
    And I select the radio option "No" for the field labeled "Yes/No"
    And I move the slider field labeled "Slider" to the position of 65
    When I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Record ID 7 successfully added."

    ###VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action         | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | radio = '9..9'                          |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | multiple_dropdown_manual_2 = '6'        |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | notesbox2 = 'Notes box'                 |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | checkbox(1) = checked                   |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | checkbox(2) = checked                   |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | signature = '1'                         |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | file_upload = '2'                       |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | tf = '1'                                |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | yn = '0'                                |
      | mm/dd/yyyy hh:mm | test_user1 | Create record7 | slider = '65'                           |

    ###VERIFY_DE
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the a table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Data Access Group | Survey Identifier | Name | Email | Complete? | radio           | Multiple Choice Dropdown Manual | Notes box 2 | Checkbox    |             |               | Signature | File Upload | True/False | Yes/No | Slider |
      | 7         | Event 1 (Arm 1: Arm 1) | Data Types        | 1               |                   |                   |      |       |           | Choice99 (9..9) | DDChoice6 (6)                   | Notes box   | Checked (1) | Checked (1) | Unchecked (0) | [button]  | [button]    | True (1)   | No (0) | 65     |
#END