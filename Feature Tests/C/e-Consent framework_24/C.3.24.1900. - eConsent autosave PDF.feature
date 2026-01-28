Feature: User Interface: The system shall support the e-Consent Framework to optionally automatically save a PDF copy of the survey response using the PDF Snapshot in a specified field.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.1900.100 Auto-save PDF to specified field
      #REDUNDANT - Auto-save PDF to specified field Tested in C.3.24.0205
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.1900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far"
      And I click on the button labeled "YES, Move to Production Status"
      Then I should see "Project status:  Production"

   Scenario: #SETUP_eConsent for participant consent process
      #SETUP_eConsent for participant consent process
      When I click on the link labeled "Designer"
      And I click on the button labeled "e-Consent"
      And I click on the button labeled "Enable the e-Consent Framework for a survey"
      And I select '"Participant Consent" (participant_consent)' in the dropdown field labeled "Enable e-Consent for a Survey"
      Then I should see "Enable e-Consent"
      And I should see "Primary settings"

      When I check the checkbox labeled "Allow e-Consent responses to be edited by users?"
      And I select "first_name" in the dropdown field labeled "First name field:"
      And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "First name field:"
      And I select "last_name" in the dropdown field labeled "Last name field:"
      And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Last name field:"
      And I select "dob" in the dropdown field labeled "Date of birth field:"
      And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Date of birth field:"
      And I enter "Participant" into the input field labeled "Custom tag/category for PDF footer:"
      And I enter "PID [project-id] - [last_name]" into the input field labeled "Custom label for PDF header"
      And I select 'part_sign "Participant signature field"' in the dropdown field labeled "Signature field #1"
      And I check the checkbox labeled "Save to specified field"
      And I select "participant_file" in the dropdown field labeled "Save to specified field:"
        And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
      And I click on the button labeled "Save settings"
      Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey              |
            | [x]               | Participant Consent |
      Then I should see a table header and rows containing the following values in a table:
         | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot    | Custom tag/category | Notes |
         | [x]               | "Participant Consent" (participant_consent) | File Repository Specified field:[event_1_arm_1][participant_file] | Participant         |       |

   Scenario: eConsent goverend PDF Snapshot
      When I click on the link labeled "PDF Snapshots of Record"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings         | Name | Type of trigger   | Save snapshot when...                 | Scope of the snapshot  | Location(s) to save the snapshot                     |
         | [x]    | Governed by e-Consent |      | Survey completion | Complete survey "Participant Consent" | Single survey response | File Repository Specified field: [participant_file] |

   Scenario: Test e-Consent by adding record
      ##ACTION: add record
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

      #Verify Auto-Save in specified field
      When I locate the bubble for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record ID "1" and click on the bubble
      And I wait for 3 seconds
      Then I should see a link labeled "Remove file" in the row labeled "Participant Consent file"

   Scenario: Verification e-Consent saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)        | Version | Type                  |
         | .pdf |                                  | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 |         | e-Consent Participant |

      When I click on the link labeled "pid13_formParticipantConsent_id1"
      Then I should see the following values in the last file downloaded
        | PID 13 - LastName   |
        | Participant Consent |
      #Manual: Close document


      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username            | Action                    | List of Data Changes OR Fields             |
         | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field     |
         |                     |                           | field = "participant_file (event_1_arm_1)" |
         |                     |                           | record = "1"                               |
         |                     |                           | event = "event_1_arm_1"                    |
         |                     |                           | instrument = "participant_consent"         |
         | [survey respondent] | e-Consent Certification 1 | e-Consent Certification                    |
         |                     |                           | record = "1"                               |
         |                     |                           | event = "event_1_arm_1"                    |
         |                     |                           | instrument = "participant_consent"         |
#END