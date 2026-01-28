Feature: User Interface: The system shall support conditional logic integration within PDF Snapshots.
   As a REDCap end user
   I want to see that eConsent is functioning as expected

  Scenario: C.3.24.2500.100 PDF snapshots conditional logic
      #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.2500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button
      #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Project status:  Production"

  Scenario: New PDF Trigger testing Every time the following survey is completed
      ##ACTION: New PDF Trigger with survey based Every time the following survey is completed
    When I click on the link labeled "Designer"
    And I click on the button labeled "PDF Snapshot"
    And I click on the button labeled "Add new trigger"
    And I enter "Snapshot 1" into the input field labeled "Name of trigger"
    And I select '"Participant Consent" - Event 1 (Arm 1: Arm 1)' on the dropdown field labeled "Every time the following survey is completed:"
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "Snapshot 1" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               | Snapshot 1 | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository                  |

  Scenario: New PDF Trigger testing When the following logic becomes true (only once per record)
      ##ACTION: When the following logic becomes true (only once per record)
    When I click on the button labeled "Add new trigger"
    And I enter "Snapshot 2" into the input field labeled "Name of trigger"
    And I select "--- select a survey ---" on the dropdown field labeled "Every time the following survey is completed:"
    And I click on "" in the textarea field labeled "When the following logic becomes true"
    And I wait for 1 second
    And I clear field and enter "[participant_consent_complete]='2'" in the textarea field labeled "Logic Editor"
    And I click on the button labeled "Update & Close Editor"
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "Snapshot 2" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                                  | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               | Snapshot 2 | Logic-based       | Logic becomes true: [participant_consent_complete]='2' | All instruments       | File Repository                  |
      | [x]    |               | Snapshot 1 | Survey completion | Complete survey "Participant Consent"                  | All instruments       | File Repository                  |

  Scenario: New PDF Trigger testing multi-form
   #C.3.24.2600.100 multi-form/survey PDF snapshots
   ##ACTION: When the following logic becomes true (only once per record)
    When I click on the button labeled "Add new trigger"
    And I enter "Snapshot 3" into the input field labeled "Name of trigger"
    And I select "--- select a survey ---" on the dropdown field labeled "Every time the following survey is completed:"
    And I click on "" in the textarea field labeled "When the following logic becomes true"
    And I wait for 1 second
    And I clear field and enter "[participant_consent_complete]='2' and [coordinator_signature_complete]='2'" into the textarea field labeled "Logic Editor"
    And I click on the button labeled "Update & Close Editor"
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "Snapshot 3" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name       | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               | Snapshot 3 | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | All instruments       | File Repository                  |
      | [x]    |               | Snapshot 2 | Logic-based       | Logic becomes true: [participant_consent_complete]='2'   | All instruments       | File Repository                  |
      | [x]    |               | Snapshot 1 | Survey completion | Complete survey "Participant Consent"                    | All instruments       | File Repository                  |
      ##VERIFY_Logging - Manage/Designof the triggers
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported        |
      | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |
      | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |
      | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |

  Scenario: Add record
      #Add record in
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
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"
    And I should see the "Incomplete (no data saved)" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1" for record "1"
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name      | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
      | Snapshot2 | -                                |      1 |                                              |                        |         |      |
      | Snapshot1 | -                                |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |

    When I click on the link labeled "Snapshot1_" in the row labeled "Participant Consent"
    Then I should see the following values in the last file downloaded
        | Page 1\nParticipant Consent |

    When I click on the link labeled "Snapshot2_" in the row labeled ""
    Then I should see the following values in the last file downloaded
        | Page 1\nParticipant Consent |
      #Manual: Close document
      #Add Instrument 2's response
    Given I click on the link labeled "Record Status Dashboard"
    When I locate the bubble for the "Coordinator Signature" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see "Editing existing Record ID 1."
    
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

    And I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

  Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name      | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
      | Snapshot3 | -                                |      1 |                                              |                        |         |      |
      | Snapshot2 | -                                |      1 |                                              |                        |         |      |
      | Snapshot1 | -                                |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username            | Action                                   | List of Data Changes OR Fields Exported                                                                                                                                 |
      | test_admin          | Save PDF Snapshot 1                      | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "coordinator_signature" snapshot_id = "3"                                        |
      | [survey respondent] | Save PDF Snapshot 1                      | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id = "2"                                          |
      | [survey respondent] | Save PDF Snapshot 1                      | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id = "1"                                          |
      | test_admin          | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                                                                                                                                                         |
#END
