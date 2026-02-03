Feature: User Interface: The system shall support the e-Consent Framework for repeatable instruments and repeatable events.
    As a REDCap end user
    I want to see that eConsent is functioning as expected

  Scenario: C.3.24.0805.100 e-Consent framework & Repeatable instruments/events
        #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.0805.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
        #Verify Longitudinal
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 1"
    Then I should see a table header and rows containing the following values in a table:
      | Event # [event-number] | Days Offset | Offset Range Min / Max | Event Label [event-label] | Custom Event Label | Unique event name  (auto-generated) [event-name] |
      |                      1 |           1 |                  -0/+0 | Event 1                   |                    | event_1_arm_1                                    |
      |                      2 |           2 |                  -0/+0 | Event 2                   |                    | event_2_arm_1                                    |
      |                      3 |           3 |                  -0/+0 | Event Three               |                    | event_three_arm_1                                |

  Scenario:
    When I click on the link labeled "Arm 2"
    Then I should see a table header and rows containing the following values in a table:
      | Event # [event-number] | Days Offset | Offset Range Min / Max | Event Label [event-label] | Custom Event Label | Unique event name  (auto-generated) [event-name] |
      |                      1 |           1 |                  -0/+0 | Event 1                   |                    | event_1_arm_2                                    |
    When I click on the link labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 1"
    Then I should see a table header and rows containing the following values in a table:
      | Data Collection Instrument       | Event 1 (1) | Event 2 (2) | Event Three (3) |
      | Participant Consent(survey)      | [x]         |             | [x]            |
      | Coordinator Signature(survey)    | [x]         |             | [x]            |
      | Pdfs And Combined Signatures Pdf | [x]         |             | [x]            |

  Scenario:
    When I click on the link labeled "Arm Two"
    And I click on the button labeled "Begin Editing"
    And I enable the Data Collection Instrument named "Participant Consent" for the Event named "Event 1"
    And I click on the button labeled "Save"
    Then I should see a table header and rows containing the following values in a table:
      | Data Collection Instrument  | Event 1 (1) |
      | Participant Consent(survey) | [x]         |
        #Verify Repeatable

  Scenario:
    When I click on the link labeled "Setup"
    And I click on the button labeled "Modify" in the row labeled "Repeating instruments and events"
    And I select "Repeat Entire Event" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And I select "Repeat Instruments" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
    And I check the second checkbox labeled "Participant Consent"
    And I select "Repeat Entire Event" on the dropdown field labeled "Event 1 (Arm 2: Arm Two)"
    And I click on the button labeled "Save"
    Then I should see a dialog containing the following text: "Your settings for repeating instruments and/or events have been successfully saved."
    And I click on the button labeled "Close"
        #SETUP_PRODUCTION

  Scenario:
    When I click on the link labeled "Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Project status:  Production"

  Scenario: add record with consent framework
        ##ACTION: add record with consent framework in Arm 1 Event 1  (repeatable event)
    When I click on the link labeled "Add / Edit Records"
    And I wait for 1 second
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
    When I clear field and enter "FirstName" into the input field labeled "Name"
    And I clear field and enter "LastName" into the input field labeled "Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see the button labeled "Submit" that is disabled

  Scenario:
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

  Scenario: add instance 2 for record with consent framework in Arm 1 Event 1  (repeatable event)
        ##ACTION: add instance 2 for record with consent framework in Arm 1 Event 1  (repeatable event)
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I wait for 1 second
    When I click on the button labeled "Add new"
    And I click on the icon in the column labeled "NEW" and the row labeled "Participant Consent"

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "Name"
    And I clear field and enter "LastName" into the input field labeled "Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see the button labeled "Submit" that is disabled
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Many Completed Survey Responses" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

  Scenario: add instance 1 for record with consent framework in Arm 1 Event Three  (repeatable instance)
        ##ACTION: add instance 1 for record with consent framework in Arm 1 Event Three  (repeatable instance)
    When I locate the bubble for the "Participant Consent" instrument on event "Event Three" for record ID "1" and click on the bubble
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "Name"
    And I clear field and enter "LastName" into the input field labeled "Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see the button labeled "Submit" that is disabled
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    When I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event Three" for record "1"

  Scenario: add instance 2 for record with consent framework in Arm 1 Event Three  (repeatable instance)
        ##ACTION: add instance 2 for record with consent framework in Arm 1 Event Three  (repeatable instance)
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I wait for 1 second
    When I click on the button labeled "Add new" in the row labeled "Participant Consent"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "Name"
    And I clear field and enter "LastName" into the input field labeled "Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area

  Scenario:
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see the button labeled "Submit" that is disabled

  Scenario:
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Many Completed Survey Responses" icon for the "Participant Consent" longitudinal instrument on event "Event Three" for record "1"

  Scenario: add record in arm 2 with consent framework
        ##ACTION: add record with consent framework in Arm 1 Event 1  (repeatable event)
    When I click on the link labeled "Add / Edit Records"
    And I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
    And I wait for 1 second
    And I click on the button labeled "Add new record for the arm selected above"
    Then I should see "Adding new Record ID 2."

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "Name"
    And I clear field and enter "LastName" into the input field labeled "Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see the button labeled "Submit" that is disabled
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 2"
    And I wait for 1 second
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"

  Scenario: add instance 2 for record with consent framework in Arm 2 Event 1  (repeatable event)
        ##ACTION: add instance 2 for record with consent framework in Arm 1 Event 1  (repeatable event)
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "2" from arm name "Arm 2: Arm Two" on the Add / Edit record page
    And I wait for 1 second
    When I click on the button labeled "Add new"
    And I click on the icon in the column labeled "NEW" and the row labeled "Participant Consent"
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "Name"
    And I clear field and enter "LastName" into the input field labeled "Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see the button labeled "Submit" that is disabled
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Many Completed Survey Responses" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"

  Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                                    | Identifier (Name, DOB) | Version | Type      |
      | .pdf |                                  |      2 | Participant Consent (Event 1 (Arm 2: Arm Two)) #2   |                        |     1.0 | e-Consent |
      | .pdf |                                  |      2 | Participant Consent (Event 1 (Arm 2: Arm Two)) #1   |                        |     1.0 | e-Consent |
      | .pdf |                                  |      1 | Participant Consent (Event Three (Arm 1: Arm 1)) #2 |             2000-01-01 |     1.0 | e-Consent |
      | .pdf |                                  |      1 | Participant Consent (Event Three (Arm 1: Arm 1)) #1 |             2000-01-01 |     1.0 | e-Consent |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) #2     |             2000-01-01 |     1.0 | e-Consent |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) #1     |             2000-01-01 |     1.0 | e-Consent |
        ##VERIFY_Logging

  Scenario:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action                    | List of Data Changes OR Fields Exported                                                                                                                                       |                                                                                                                                           |
      | [survey respondent] | Save PDF Snapshot 2       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_1_arm_2)" record = "2" event = "event_1_arm_2" instrument = "participant_consent" instance = "2"         |
      | [survey respondent] | e-Consent Certification 2 | e-Consent Certification record = "2" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_2" instrument = "participant_consent" instance = "2"     |                                                                                                                                           |
      | [survey respondent] | Save PDF Snapshot 2       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_1_arm_2)" record = "2" event = "event_1_arm_2" instrument = "participant_consent" instance = "1"         |
      | [survey respondent] | e-Consent Certification 2 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_2" instrument = "participant_consent" instance = "1"     |                                                                                                                                           |
      | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_three_arm_1)" record = "1" event = "event_three_arm_1" instrument = "participant_consent" instance = "2" |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_three_arm_1" instrument = "participant_consent" instance = "2" |                                                                                                                                           |
      | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_three_arm_1)" record = "1" event = "event_three_arm_1" instrument = "participant_consent" instance = "1" |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_three_arm_1" instrument = "participant_consent" instance = "1" |                                                                                                                                           |
      | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent" instance = "2"         |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_1" instrument = "participant_consent" instance = "2"     |                                                                                                                                           |
      | [survey respondent] | Save PDF Snapshot 1       | Save PDF Snapshot to File Upload Field                                                                                                                                        | field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent" instance = "1"         |
      | [survey respondent] | e-Consent Certification 1 | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_1" instrument = "participant_consent" instance = "1"     |                                                                                                                                           |
#END