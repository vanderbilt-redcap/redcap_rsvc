Feature: User Interface: The system shall support the saving PDF snapshots to specific fields and the file repository within PDF Snapshots.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.2700.100 PDF snapshots save location (specific fields/file repository)

      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project status:  Production"

      When I click on the link labeled "Designer"
      And I click on the button labeled "PDF Snapshot"

   Scenario: New PDF Trigger for survey completion all instruments
      ##ACTION: New PDF Trigger
      And I click on the button labeled "Add new trigger"
      And I enter "Snapshot" into the input field labeled "Name of trigger"
      And I select "--- select a survey ---" on the dropdown field labeled "Every time the following survey is completed:" in the dialog box
      And I click on "" in the textarea field labeled "When the following logic becomes true"
      And I wait for 1 second
      And I clear field and enter "[participant_consent_complete]='2'" into the textarea field labeled "Logic Editor" in the dialog box
      And I click on the button labeled "Update & Close Editor" in the dialog box
      And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
      And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I check the checkbox labeled "Save to File Repository"
      And I check the checkbox labeled "Save to specified field:"
      And I select "participant_file" in the dropdown field labeled "Save to specified field:"
        And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
      And I click on the button labeled "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name     | Type of trigger | Save snapshot when...                                  | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Snapshot | Logic-based     | Logic becomes true: [participant_consent_complete]='2' | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Add record
      #Add record
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
      And I should see the "Incomplete" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1"

   Scenario: Verification pdf saved and logged correctly
      ##VERIFY specified field
      When I click the bubble to select a record for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1"

      When I click on the link labeled "pid13_formParticipantCons" in the row labeled "Participant Consent file"
      Then I should see the following values in the last file downloaded
         | Page 1\nParticipant Consent |
      #Manual: Close document

      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name | PDF utilized e-Consent Framework | Record | Survey Completed         | Identifier (Name, DOB) | Version | Type |
         | .pdf | -                                | 1      |                          |                        |         |      |


      ##VERIFY_Logging
      ##e-Consent Framework not used, and PDF Snapshot is used
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username   | Action              | List of Data Changes OR Fields Exported                                                                                                                               |
         | test_admin | Save PDF Snapshot 1 | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id |
         | test_admin | Save PDF Snapshot 1 | Save PDF Snapshot to File Repository record = "1" event = "event_1_arm_1" instrument = "participant_consent" snapshot_id =                                            |
#END
