Feature: User Interface: The system shall support the creation, modification, and copying of custom triggers for PDF snapshots.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.2200.100 creation, modification, and copying of custom triggers for PDF snapshots.

      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project status:  Production"

      When I click on the link labeled "Designer"
      And I click on the button labeled "PDF Snapshot"

   Scenario: Cancel New PDF Trigger
      ##ACTION: New PDF Trigger
      And I click on the button labeled "Add new trigger"
      And I click on the button labeled "Cancel"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name | Type of trigger | Save snapshot when... | Scope of the snapshot | Location(s) to save the snapshot |

   Scenario: New PDF Trigger for survey completion all instruments
      ##ACTION: New PDF Trigger
      And I click on the button labeled "Add new trigger"
      And I enter "Custom Dropdown 1 Form Snapshot" into the input field labeled "Name of trigger"
      And I select '"Participant Consent" - [Any Event]' on the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
      And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I check the checkbox labeled "Save to File Repository"
      And I check the checkbox labeled "Save to specified field:"
      And I select "participant_file" in the dropdown field labeled "Save to specified field:"
        And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
      And I enter "Custom" into the input field labeled "File name:"
      And I click on the button labeled "Save"
      Then I should see "Saved!"
      Then I click on the button labeled "OK"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Cancel Copy trigger
      ##ACTION: Cancel Copy trigger
      When I click on the button labeled "Copy trigger" in the row labeled "Custom Dropdown 1 Form Snapshot"
      Then I should see "Do you wish to copy this PDF Snapshot Trigger?"

      When I click on the button labeled "Cancel"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Copy trigger
      ##ACTION: Copy trigger
      When I click on the button labeled "Copy trigger" in the row labeled "Custom Dropdown 1 Form Snapshot"
      Then I should see "Do you wish to copy this PDF Snapshot Trigger?"
      And I click on the button labeled "Copy trigger"

     Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   | Snapshot ID |
         | [x]    |               | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] | 1           |
         | [x]    |               | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] | 2           |

   Scenario: Cancel Edit trigger
      ##ACTION: Cancel Edit trigger
      When I click on the second button labeled "Edit trigger"
      Then I verify "Custom Dropdown 1 Form Snapshot" is within the field labeled "Name of trigger:"

      When I click on the button labeled "Cancel"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | [x]    |               | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Edit trigger with Logic-based and selected instruments
      ##ACTION: Edit trigger
      When I click on the second button labeled "Edit trigger"
      Then I verify "Custom Dropdown 1 Form Snapshot" is within the field labeled "Name of trigger:"

      When I enter "Edit trigger name" into the input field labeled "Name of trigger"
      And I select "--- select a survey ---" on the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I click on "" in the textarea field labeled "When the following logic becomes true"
      And I wait for 2 seconds
      And I clear field and enter "[participant_consent_complete]='2' and [coordinator_signature_complete]='2'" into the textarea field labeled "Logic Editor" in the dialog box
      And I click on the button labeled "Update & Close Editor" in the dialog box  
      And I click on the icon labeled '[All instruments]'
      And I click on the link labeled 'deselect all'
      And I check the first checkbox labeled 'Participant Consent'
      And I check the first checkbox labeled 'Coordinator Signature'
      And I click on the button labeled "Update"
      And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
      And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I check the checkbox labeled "Save to File Repository"
      And I check the checkbox labeled "Save to specified field:"
      And I select "combo_file" in the dropdown field labeled "Save to specified field:"
      And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
      And I enter "Custom" into the input field labeled "File name:"
      And I click on the button labeled "Save"
      Then I should see "Trigger for PDF Snapshot was successfully modified"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name                            | Type of trigger   | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Edit trigger name               | Logic-based       | Logic becomes true: [participant_consent_complete]='2... | Selected instruments  | File Repository Specified field: [event_1_arm_1][combo_file]       |
         | [x]    |               | Custom Dropdown 1 Form Snapshot | Survey completion | Complete survey "Participant Consent"                    | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

      ##VERIFY_Logging
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username   | Action        | List of Data Changes OR Fields Exported        |
         | test_admin | Manage/Design | Modify trigger for PDF Snapshot (snapshot_id = |
         | test_admin | Manage/Design | Copy PDF Snapshot Trigger (copy snapshot_id =  |
         | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |

   Scenario: Add record in data form mode (no pdf snapshot)
      #Add record in data form mode (no pdf snapshot)
      When I click on the link labeled "Add / Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 1."

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

      And I select "Complete" on the dropdown field labeled "Complete?"
      And I click on the button labeled "Save & Exit Form"
      Then I should see "Record Home Page"
      And I should see the "Complete" icon for the "Participant Consent" longitudinal instrument on event "Event 1" 
      And I should see the "Incomplete (no data saved)" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1"

   Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name | PDF utilized e-Consent Framework | Record | Survey Completed | Identifier (Name, DOB) | Version | Type |

      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username   | Action                                   | List of Data Changes OR Fields Exported |
         | test_admin | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                         |

   Scenario: Add record in survey mode (pdf snapshot created)
      #Add record in data survey mode (pdf snapshot created)
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

      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I return to the REDCap page I opened the survey from
      And I click on the link labeled "Record Status Dashboard"
      Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"
      And I should see the "Incomplete" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1" for record "2"

      When I locate the bubble for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record ID "2" and click on the bubble
      Then I should see "Editing existing Record ID 2."
      Then I should see "Custom_" in the row labeled "Participant Consent file"

      When I click on the link labeled "Custom_"
      Then I should see the following values in the last file downloaded
        | Page 1\nParticipant Consent |
      #Manual: Close document

      #Add Instrument 2's response
      When I click on the link labeled "Coordinator Signature"
      Then I should see "Coordinator's Name Typed"

      When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
      And I click on the button labeled "Okay" in the dialog box
      And I click on the button labeled "Survey options"
      And I click on the survey option label containing "Open survey" label
      Then I should see "Please complete the survey"
      And I clear field and enter "Coo" into the input field labeled "Coordinator's Name Typed"
      
      Given I click on the link labeled "Add signature"
      And I see a dialog containing the following text: "Add signature"
      And I draw a signature in the signature field area
      When I click on the button labeled "Save signature" in the dialog box
      Then I should see a link labeled "Remove signature"

      And I click on the button labeled "Submit"
      Then I should see "Thank you for taking the survey."

      When I click on the button labeled "Close survey"
      And I return to the REDCap page I opened the survey from
      And I click on the link labeled "Record Status Dashboard"
      Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"
      Then I should see the "Completed Survey Response" icon for the "Coordinator Signature" longitudinal instrument on event "Event 1" for record "2"
      And I should see the "Incomplete" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1" for record "2"


      When I locate the bubble for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record ID "2" and click on the bubble
      Then I should see "Editing existing Record ID 2."
      Then I should see "Custom_" in the row labeled "Participant Consent file"
      And I should see "Custom_" in the row labeled "Combine both files together"

      When I click on the link labeled "Custom_" in the row labeled "Combine both files together"
      And I should see the following values in the last file downloaded
        | Page 1\nParticipant Consent |
        | Page 3\nCoordinator Signature |
   #Manual: Close document


   Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name       | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | Custom_    | -                                | 2      | (Event 1 (Arm 1: Arm 1))                     |                        |         |      |
         | Custom_    | -                                | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |

      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username            | Action                                   | List of Data Changes OR Fields Exported                                                                                                                                 |
         | [survey respondent] | Save PDF Snapshot 2                      | Save PDF Snapshot to File Upload Field field =  "combo_file (event_1_arm_1)" record = "2" event = "event_1_arm_1" instrument =  "coordinator_signature" snapshot_id =     |
         | [survey respondent] | Save PDF Snapshot 2                      | Save PDF Snapshot to File Repository record = "2" event = "event_1_arm_1" instrument = "coordinator_signature" snapshot_id =                                            |
         | test_admin          | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                                                                                                                                                         |
         | [survey respondent] | Save PDF Snapshot 2                      | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "2" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id = |
         | [survey respondent] | Save PDF Snapshot 2                      | Save PDF Snapshot to File Repository record = "2" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id =                                              |
         | test_admin          | Create record 1 (Event 1 (Arm 1: Arm 1)) | record_id = '1'                                                                                                                                                         |
#END