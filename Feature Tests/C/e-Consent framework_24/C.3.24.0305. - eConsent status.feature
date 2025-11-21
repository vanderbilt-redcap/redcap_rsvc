Feature: C.3.24.0305. User Interface: The system shall support the e-Consent Framework to mark surveys as complete (with the submit button appearing) once the certification step is successfully completed. This includes functionality for single forms, repeatable forms, multi-signature forms, surveys with conditional logic, and surveys across multiple arms in both classic and longitudinal projects.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0305.100 Certification required to submit completed survey

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0305.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"


    Scenario: #SETUP_eConsent to allow for edit by users
        ##SETUP Allow e-Consent responses to be edited by users?
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        And I click on the button labeled "Enable the e-Consent Framework for a survey"
        And I select '"Participant Consent" (participant_consent)' in the dropdown field labeled "enable the e-Consent Framework for any survey" in the dialog box
        Then I should see "Enable e-Consent"
        And I should see "Primary settings"

        When I check the checkbox labeled "Allow e-Consent responses to be edited by users?"
        And I select 'part_sign "Participant signature field"' in the dropdown field labeled "Signature field #1"
        And I check the checkbox labeled "Save to specified field"
        And I select "participant_file" in the dropdown field labeled "Save to specified field:"
        And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
        And I click on the button labeled "Save settings"
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot | Custom tag/category | Notes |
            | [x]               | "Participant Consent" (participant_consent) | File Repository                                 |                     |       |

        ##ACTION: add record with consent framework
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 1."

        When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
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
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see the button labeled "Submit" is disabled

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        And I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        And I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

    Scenario: Test previous page erase signature
        ##ACTION: Test previous page button on certification page with signature erase
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 2."

        When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
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
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see the button labeled "Submit" is disabled

        And I click on the button labeled "Previous Page"
        Then I should see "Erase your signature(s) in this survey?"

        When I click on the button labeled "Cancel" in the dialog box
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see the button labeled "Submit" is disabled

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        And I click on the button labeled "Previous Page"
        Then I should see "Erase your signature(s) in this survey?"

        When I click on the button labeled "Erase my signature(s) and go to earlier page" in the dialog box
        Then I should NOT see "Remove signature"

        When I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Partial Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"

    Scenario: Test reopen partially completed this survey and start over
        ##ACTION: Test reopen partially completed this survey and start over
        When I locate the bubble for the "Participant Consent" instrument on event "Event 1" for record ID "2" and click on the bubble
        Then I should see "Survey response is editable"
        And I should NOT see "signature_"
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        Then I should see "You have partially completed this survey"
        And I click on the button labeled "Start Over"

        Then I should see "Participant Consent"

        When I clear field and enter "FirstName" into the input field labeled "Name"
        And I clear field and enter "LastName" into the input field labeled "Name"
        And I clear field and enter "email@test.edu" into the input field labeled "email"
        And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
        And I enter "MyName" into the input field labeled "Participant's Name Typed"
        
        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see the button labeled "Submit" is disabled

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
            | Name                              | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type      |
            | pid13_formParticipantConsent_id2_ |                                  | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         | e-Consent |
            | pid13_formParticipantConsent_id1_ |                                  | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         | e-Consent |


        Given I click on the link labeled "_formParticipantConsent_id1_"
        And I should see a signature for the "Participant signature field" field in the downloaded PDF for record "1" and survey "Participant Consent"

        Given I click on the link labeled "_formParticipantConsent_id2_"
        And I should see a signature for the "Participant signature field" field in the downloaded PDF for record "2" and survey "Participant Consent"
        #Manual: Close document


        ##VERIFY_Logging
        ##e-Consent Framework not used, and PDF Snapshot is used
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username            | Action                    | List of Data Changes OR Fields Exported                                                           |
            | [survey respondent] | e-Consent Certification 2 | e-Consent Certification            |
            |                     |                           | record = "2"                       |
            |                     |                           | event = "event_1_arm_1"            |
            |                     |                           | instrument = "participant_consent" |
            | [survey respondent] | e-Consent Certification 1 | e-Consent Certification            |
            |                     |                           | record = "1"                       |
            |                     |                           | event = "event_1_arm_1"            |
            |                     |                           | instrument = "participant_consent" |
#END