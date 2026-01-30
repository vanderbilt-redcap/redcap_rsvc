Feature:  C.3.24.0405. User Interface: The system shall support the e-Consent Framework to automatically enable a read-only PDF Snapshot trigger that will save a PDF copy of the survey response into the project's File Repository. This functionality must include support for single forms, repeatable forms, and surveys across multiple arms in both classic and longitudinal projects.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0405.100 Automatic PDF Governed by e-Consent

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.405.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Project status:  Production"

    Scenario: Verify eConsent Framework and PDF Snapshot setup
        #SETUP eConsent Framework and PDF Snapshot setup
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey                                          | Location(s) to save the signed consent snapshot    | Custom tag/category | Notes |
            | [x]               | "Participant Consent" (participant_consent)     | File Repository Specified field:[participant_file] | Participant         |       |
            | [x]               | "Coordinator Signature" (coordinator_signature) | File Repository Specified field:[coo_sign]         | Coordinator         |       |

        When I click on the link labeled "PDF Snapshots of Record"
        Then I should see a table header and rows containing the following values in a table:
            | Active | Edit settings         | Name | Type of trigger   | Save snapshot when...                   | Scope of the snapshot  | Location(s) to save the snapshot                     |
            | [x]    | Governed by e-Consent |      | Survey completion | Complete survey "Participant Consent"   | Single survey response | File Repository Specified field: [participant_file] |
            | [x]    | Governed by e-Consent |      | Survey completion | Complete survey "Coordinator Signature" | Single survey response | File Repository Specified field: [coo_sign]         |

    Scenario: Add record
        ##ACTION: add record with consent framework
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
        And I should see the button labeled "Submit" that is disabled

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        And I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        And I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

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
            | Username            | Action                    | List of Data Changes OR Fields Exported                                                          |
            | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1"  event = "event_1_arm_1" instrument = "participant_consent" |
#END