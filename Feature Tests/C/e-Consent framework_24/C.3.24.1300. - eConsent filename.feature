Feature: User Interface: The system shall support the e-Consent Framework to customize the file name for PDF snapshots using static text or piping, appended with the date-time of the snapshot generation.
   As a REDCap end user
   I want to see that eConsent is functioning as expected

  Scenario: C.3.24.1300.100 e-Consent Framework custom file name
      #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.1300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button
      #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Project status:  Production"
      #SETUP_eConsent for participant consent process
      #SETUP_eConsent for participant consent process
    When I click on the link labeled "Designer"
    And I click on the button labeled "e-Consent"
    And I click on the button labeled "Enable the e-Consent Framework for a survey"
    And I select '"Participant Consent" (participant_consent)' in the dropdown field labeled "Enable e-Consent for a Survey"
    Then I should see "Enable e-Consent"
    And I should see "Primary settings"
      #C.3.24.1300.100 e-Consent Framework custom file name
    When I enter "Custom" into the input field labeled "File name:"
      #C.3.24.1400.100 - eConsent Framework custom note
    And I enter "My custom note" into the input field labeled "Notes:"
    And I check the checkbox labeled "Save to specified field"
    And I select "participant_file" in the dropdown field labeled "Save to specified field:"
    And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
    And I click on the button labeled "Save settings"
    Then I should see a table header and rows containing the following values in a table:
      | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot    | Custom tag/category | Notes          |
      | [x]               | "Participant Consent" (participant_consent) | File Repository                                    | Participant         | My custom note |

  Scenario: #SETUP_eConsent for coordinator signature (second signature) process
    #SETUP_eConsent for coordinator signature (second signature) process
    When I click on the button labeled "Enable the e-Consent Framework for a survey"
    And I wait for 1 second
    And I select '"Coordinator Signature" (coordinator_signature)' in the dropdown field labeled "Enable e-Consent for a Survey"
    Then I should see "Enable e-Consent"
    And I should see "Primary settings"

    When I check the checkbox labeled "Allow e-Consent responses to be edited by users?"
    And I enter "Coordinator" into the input field labeled "Custom tag/category for PDF footer:"
    And I enter "PID [project-id] - [last_name]" into the input field labeled "Custom label for PDF header"
    And I select 'coo_sign1 "Coordinator\'s Signature"' in the dropdown field labeled "Signature field #1"
    And I check the checkbox labeled "Save to specified field"
    And I select "coo_sign" in the dropdown field labeled "Save to specified field:"
    And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
    And I click on the button labeled "Save settings"
    Then I should see a table header and rows containing the following values in a table:
        | e-Consent active? | Survey                                          |
        | [x]               | "Coordinator Signature" (coordinator_signature) |

  Scenario: Test e-Consent by adding record
      ##ACTION: add record to get participant signature
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 1."
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

      ##ACTION: add Coordinator Signature
    When I locate the bubble for the "Coordinator Signature" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see "Coordinator's Signature"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"
    And I clear field and enter "Coordinator Name" into the input field labeled "Coordinator's Name Typed"

    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    And I return to the REDCap page I opened the survey from
    When I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"
    And I should see the "Incomplete" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1" for record "1"
    When I locate the bubble for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I should see "Editing existing Record ID 1."
    Then I should see "Custom_" in the row labeled "Participant Consent file"
    Then I should see "pid13_formCoordinatorSign..."

  Scenario: Verification e-Consent saved and logged correctly
      ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name                                    | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type                  |
      | Custom_ |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         | e-Consent |
      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action                    | List of Data Changes OR Fields Exported                                                                                                         |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1"  event = "event_1_arm_1" instrument = "participant_consent" snapshot_file = "Custom_ |
#END
