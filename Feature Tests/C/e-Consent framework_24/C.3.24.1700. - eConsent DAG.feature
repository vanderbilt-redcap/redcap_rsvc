Feature: User Interface: The system shall support the e-Consent Framework to limit user view access (i.e., DAG).
   As a REDCap end user
   I want to see that eConsent is functioning as expected

  Scenario: C.3.24.1700.100 Limit user view access by DAG
      #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.1700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

  Scenario: #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Project status:  Production"

  Scenario: Cancel an add consent form version
      #SETUP_eConsent
    When I click on the link labeled "Designer"
    And I click on the button labeled "e-Consent"
    Then I should see "Participant Consent"

  Scenario: #Add consent with no DAG
    When I click on the link labeled "Add consent form" in the row labeled "Participant Consent"
    And I enter "NO DAG" into the input field labeled "Consent form version:"
    And I select "Consent file" on the dropdown field labeled "Placement of consent form:"
    And I select "When record is not assigned to a DAG (default)" on the dropdown field labeled "Display for specific DAG"
    And I select "No languages defined on MLM page" on the dropdown field labeled "Display for specific language"
    And I enter "This is my NO DAG consent form" into the textarea field labeled "Consent Form (Rich Text)"
    And I click on the button labeled "Add new consent form"
    And I wait for 1 second
    Then I should see "vNO DAG" in the row labeled "Participant Consent"

  Scenario: #VERIFY: view all versions for NO DAG
    When I click on the link labeled "View all versions" in the row labeled "Participant Consent"
    Then I should see a table header and rows containing the following values in a table:
      | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
      |            |     1.0 |                    |                         |                           0 |                   |              | _Fake_Consent[311203].pdf               |                              |
      |            | NO DAG  |                    | Test_Admin (Admin User) |                           0 |                   |              | "This is my NO DAG consent form"        |                              |
    And I should see a button labeled "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "NO DAG"
    When I click on the button labeled "Close"
    Then I should see "vNO DAG" in the row labeled "Participant Consent"

  Scenario: #Add consent with DAG TestGroup1
      #Add consent with DAG TestGroup1
    When I click on the link labeled "Add consent form" in the row labeled "Participant Consent"
    And I enter "DAG 1" into the input field labeled "Consent form version:"
    And I select "Consent file" on the dropdown field labeled "Placement of consent form:"
    And I select "TestGroup1" on the dropdown field labeled "Display for specific DAG"
    And I select "No languages defined on MLM page" on the dropdown field labeled "Display for specific language"
    And I click on the button labeled "Consent Form (Inline PDF)"
    And I upload a "pdf" format file located at "import_files/DAG1.pdf", by clicking the button near "Upload your PDF consent form" to browse for the file, and clicking the button labeled "Add new consent form" to upload the file
    And I wait for 1 second
    Then I should see "vDAG 1" in the row labeled "Participant Consent"
    And I should see "vNO DAG" in the row labeled "Participant Consent"

  Scenario: #Add consent with DAG TestGroup2
      #Add consent with DAG TestGroup2
    When I click on the link labeled "Add consent form" in the row labeled "Participant Consent"
    And I enter "DAG 2" into the input field labeled "Consent form version:"
    And I select "Consent file" on the dropdown field labeled "Placement of consent form:"
    And I select "TestGroup2" on the dropdown field labeled "Display for specific DAG"
    And I select "No languages defined on MLM page" on the dropdown field labeled "Display for specific language"
    And I click on the button labeled "Consent Form (Inline PDF)"
    And I upload a "pdf" format file located at "import_files/DAG2.pdf", by clicking the button near "Upload your PDF consent form" to browse for the file, and clicking the button labeled "Add new consent form" to upload the file
    And I wait for 1 second
    Then I should see "vDAG 2" in the row labeled "Participant Consent"
    And I should see "vDAG 1" in the row labeled "Participant Consent"
    And I should see "vNO DAG" in the row labeled "Participant Consent"

  Scenario: #VERIFY: view all versions
      #VERIFY: view all versions
    When I click on the link labeled "View all versions" in the row labeled "Participant Consent"
    Then I should see a table header and rows containing the following values in a table:
      | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
      |            |     1.0 |                    |                         |                           0 |                   |              | _Fake_Consent[311203].pdf               |                              |
      |            | NO DAG  |                    | Test_Admin (Admin User) |                           0 |                   |              | "This is my NO DAG consent form"        |                              |
      |            | DAG 1   |                    | Test_Admin (Admin User) |                           0 |                   |              | DAG1.pdf                                |                              |
      |            | DAG 2   |                    | Test_Admin (Admin User) |                           0 |                   |              | DAG2.pdf                                |                              |
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "1.0"
    And I should see a button labeled "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "NO DAG"
    And I should see a button labeled "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "DAG 1"
    And I should see a button labeled "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "DAG 2"
    When I click on the button labeled "Close"
    Then I should see "vDAG 2" in the row labeled "Participant Consent"
    And I should see "vDAG 1" in the row labeled "Participant Consent"
    And I should see "vNO DAG" in the row labeled "Participant Consent"

  Scenario: ##VERIFY_Logging
      ##VERIFY_Logging
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported                                      |
      | test_admin | Manage/Design | Add new consent form for instrument "participant_consent" (consent_form_id = |
      | test_admin | Manage/Design | Add new consent form for instrument "participant_consent" (consent_form_id = |
      | test_admin | Manage/Design | Add new consent form for instrument "participant_consent" (consent_form_id = |

  Scenario: ##ACTION: add NO DAG record
      ##ACTION: add NO DAG record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 1."
    And I should see "This is my NO DAG consent form"

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"
    And I should see "This is my NO DAG consent form"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

  Scenario: ##ACTION: add DAG1 record
      ##ACTION: add DAG1 record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 2."
      #Assign record to DAG
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the link labeled "Record ID 2"
    And I click on the button labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"
    And I select "TestGroup1" on the dropdown field labeled "[No Assignment]"
    And I click on the button labeled "Assign to Data Access Group"

  Scenario: ##VERIFY
      ##VERIFY
    Then I should see "Record ID 2 was successfully assigned to a Data Access Group!"
    And I should see "Arm 1: Arm 1 — TestGroup1"
    When I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see the consent pdf has loaded in the iframe
    #Manual: Then I should see "CONSENT DAG 1" in the PDF content displayed within the page
    And I should NOT see "This is my NO DAG consent form"

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"
    And I should see the consent pdf has loaded in the iframe
    #Manual: Then I should see "CONSENT DAG 1" in the PDF content displayed within the page
    And I should NOT see "This is my NO DAG consent form"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"

  Scenario: ##ACTION: add DAG2 record
      ##ACTION: add DAG2 record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 3."

  Scenario: #Assign record to DAG
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the link labeled "Record ID 3"
    And I click on the button labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"
    And I select "TestGroup2" on the dropdown field labeled "[No Assignment]"
    And I click on the button labeled "Assign to Data Access Group"

  Scenario: ##VERIFY
    Then I should see "Record ID 3 was successfully assigned to a Data Access Group!"
    And I should see "Arm 1: Arm 1 — TestGroup2"
    When I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see the consent pdf has loaded in the iframe
    #Manual: Then I should see "CONSENT DAG 2" in the PDF content displayed within the page
    And I should NOT see "This is my NO DAG consent form"

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"
    And I should see the consent pdf has loaded in the iframe
    #Manual: Then I should see "CONSENT DAG 2" in the PDF content displayed within the page
    And I should NOT see "This is my NO DAG consent form"
    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "3"

  Scenario: # Verification e-Consent saved and logged correctly
      #Verification e-Consent saved and logged correctly
      ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)        | Version | Type                  |
      | .pdf |                                  |      3 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 | DAG 2   | e-Consent Participant |
      | .pdf |                                  |      2 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 | DAG 1   | e-Consent Participant |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 | NO DAG  | e-Consent Participant |

  Scenario: ##VERIFY_Logging
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action                    | List of Data Changes OR Fields Exported                                                                                                                                   |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "3" identifier = "email@test.edu" consent_form_version = "DAG 2" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id  |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "2" identifier = "email@test.edu" consent_form_version = "DAG 1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id  |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "NO DAG" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id |
#END