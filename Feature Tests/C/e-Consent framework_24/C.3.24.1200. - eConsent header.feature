Feature: User Interface: The system shall support the e-Consent Framework to create a custom header for PDF snapshots, utilizing static text, smart variables, and piping.
    As a REDCap end user
    I want to see that eConsent is functioning as expected

  Scenario: C.3.24.1200.100 e-Consent framework custom header
        #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.1200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

  Scenario: #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Project status:  Production"

  Scenario: #SETUP_eConsent for custom header
        #SETUP_eConsent for participant consent process
    When I click on the link labeled "Designer"
    And I click on the button labeled "e-Consent"
    And I click on the button labeled "Enable the e-Consent Framework for a survey"
    And I select '"Participant Consent" (participant_consent)' in the dropdown field labeled "Enable e-Consent for a Survey"
    Then I should see "Enable e-Consent"
    And I should see "Primary settings"
    And I select "first_name" on the dropdown field labeled "First name field"
    And I select "last_name" on the dropdown field labeled "Last name field"
    And I select "dob" on the dropdown field labeled "Date of birth field"

  Scenario:
    When I enter "PID [project-id] - [last_name]" into the input field labeled "Custom label for PDF header"
    And I click on the button labeled "Save settings"
    Then I should see a table header and rows containing the following values in a table:
      | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot    | Custom tag/category | Notes |
      | [x]               | "Participant Consent" (participant_consent) | File Repository                                    | Participant         |       |

  Scenario: Add record
        ##ACTION: add record to get participant signature
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 1."

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."

  Scenario:
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

  Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)         | Version | Type                  |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 |         | e-Consent  |

  Scenario:
    When I click on the link labeled "pid13_formParticipantConsent_id1_"
    Then I should see the following values in the last file downloaded
      | PID 13 - LastName   |
        #Manual: Close document

  Scenario: ##VERIFY_Logging  ##e-Consent Framework not used, and PDF Snapshot is used
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action                    | List of Data Changes OR Fields Exported                                                          |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1"  event = "event_1_arm_1" instrument = "participant_consent" |
#END
