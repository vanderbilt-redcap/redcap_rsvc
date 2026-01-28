Feature: User Interface: The system shall support the e-Consent Framework ability to insert select text fields into the footer of the PDF consent form. Selectors include e-Consent version | First name field | Last name field | e-Consent custom tag/category | Date of birth field.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0205.100 e-Consent text validation

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0205.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

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
            | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot    | Custom tag/category | Notes |
            | [x]               | "Participant Consent" (participant_consent) | File Repository Specified field:[event_1_arm_1][participant_file] | Participant         |       |

        When I click on the link labeled "Add consent form" in the row labeled "Participant Consent"
        And I enter "1.0" into the input field labeled "Consent form version:"
        And I select "Consent file" on the dropdown field labeled "Placement of consent form:"
        And I click on the button labeled "Consent Form (Inline PDF)"
        # Then I should see "ERROR: You must provide your consent form"
        # When I click on the button labeled "Close"
        And I upload a "pdf" format file located at "import_files/consent.pdf", by clicking the button near "Upload your PDF consent form" to browse for the file, and clicking the button labeled "Add new consent form" to upload the file
        And I wait for 1 second
        Then I should see "v1.0" in the row labeled "Participant Consent"

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

    Scenario: Combine the PDFs to one combined PDF
        #SETUP Trigger to combine the PDFs to one combined PDF
        When I click on the link labeled "PDF Snapshots of Record"
        Then I should see a table header and rows containing the following values in a table:
            | Active | Edit settings         | Name | Type of trigger   | Save snapshot when...                   | Scope of the snapshot  | Location(s) to save the snapshot                     |
            | [x]    | Governed by e-Consent |      | Survey completion | Complete survey "Participant Consent"   | Single survey response | File Repository Specified field: [participant_file] |
            | [x]    | Governed by e-Consent |      | Survey completion | Complete survey "Coordinator Signature" | Single survey response | File Repository Specified field: [coo_sign]         |

        When I click on the button labeled "Add new trigger"
        And I enter "Combine PDF file" into the input field labeled "Name of trigger"
        And I click on "" in the textarea field labeled "When the following logic becomes true"
        And I wait for 1 second
        And I clear field and enter "[participant_consent_complete]='2' and [coordinator_signature_complete]='2'" into the textarea field labeled "Logic Editor"
        And I click on the button labeled "Update & Close Editor"
        And I check the checkbox labeled "Save to File Repository"
        And I check the checkbox labeled "Save to specified field"
        And I select "combo_file" in the dropdown field labeled "Save to specified field:"
        And I select "Current event" in the dropdown field labeled "Save to specified field:"
        And I click on the button labeled "Save"
        Then I should see "Trigger for PDF Snapshot was successfully created"
        Then I should see a table header and rows containing the following values in a table:
            | Active | Edit settings         | Name             | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot  | Location(s) to save the snapshot                                   |
            | [x]    |                       | Combine PDF file | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | All instruments        | File Repository Specified field: [combo_file]                      |
            | [x]    | Governed by e-Consent |                  | Survey completion | Complete survey "Participant Consent"                    | Single survey response | File Repository Specified field: [event_1_arm_1][participant_file] |
            | [x]    | Governed by e-Consent |                  | Survey completion | Complete survey "Coordinator Signature"                  | Single survey response | File Repository Specified field: [event_1_arm_1][coo_sign]         |

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
        Then I should see the "Completed Survey Response" icon for the "Coordinator Signature" longitudinal instrument on event "Event 1" for record "1"
        And I should see the "Incomplete" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1" for record "1"

        When I locate the bubble for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record ID "1" and click on the bubble
        And I wait for 3 seconds
        Then I should see a link labeled "Remove file" in the row labeled "Participant Consent file"
        And I should see a link labeled "Remove file" in the row labeled "Coordinator Signature file"
        And I should see a link labeled "Remove file" in the row labeled "Combine both files together"

    Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows containing the following values in a table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed                               | Identifier (Name, DOB)        | Version | Type                  |
            | .pdf |                                  | 1      | (Event 1 (Arm 1: Arm 1))                       |                               |         |                       |
            | .pdf |                                  | 1      | Coordinator Signature (Event 1 (Arm 1: Arm 1)) |                               |         | e-Consent Coordinator |
            | .pdf |                                  | 1      | Participant Consent (Event 1 (Arm 1: Arm 1))   | FirstName LastName, 2000-01-01 |         | e-Consent Participant |

        When I click on the link labeled "pid13_formParticipantConsent_id1_"
        And I wait for 1 second
        Then I should see the following values in the last file downloaded
          | PID 13 - LastName   |
          | Participant Consent |
          | FirstName LastName, 2000-01-01, Version: 1.0, Participant |

        When I click on the second link labeled "pid13_formCoordinatorSignature_id1_"
        And I wait for 1 second
        Then I should see the following values in the last file downloaded
          | PID 13 - LastName   |
          | Coordinator Signature |

        When I click on the first link labeled "pid13_formCoordinatorSignature_id1_"
        And I wait for 1 second
        Then I should see the following values in the last file downloaded
          | PID 13 - LastName   |
          | Participant Consent |
          | Coordinator Signature |
          | Coordinator         |

        #Manual: Close document


        ##VERIFY_Logging
        ##e-Consent Framework not used, and PDF Snapshot is used
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username            | Action                    | List of Data Changes OR Fields Exported                                                                                                                    |
            | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "coordinator_signature"                                             |
            | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field field = "combo_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "coordinator_signature"      |
            | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field field = "coo_sign (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "coordinator_signature"        |
            | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" event = "event_1_arm_1" instrument = "coordinator_signature"                                                          |
            | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent"  |
            | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1"  event = "event_1_arm_1" instrument = "participant_consent"                                                           |
#END