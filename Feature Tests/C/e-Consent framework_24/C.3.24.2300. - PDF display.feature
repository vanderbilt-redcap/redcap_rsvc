Feature: User Interface: The system shall support the hide/unhide active and inactive triggers within PDF Snapshots.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario:  C.3.24.2300.100 hide/unhide active and inactive triggers within PDF Snapshots.

      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      ##ACTION: New Active PDF Trigger
      When I click on the link labeled "Designer"
      And I click on the button labeled "PDF Snapshot"
      And I click on the button labeled "Add new trigger"
      And I enter "Snapshot" into the input field labeled "Name of trigger"
      And I select '"Participant Consent" - [Any Event]' on the dropdown field labeled "Every time the following survey is completed:"
      And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
      And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
      And I check the checkbox labeled "Save to File Repository"
      And I check the checkbox labeled "Save to specified field:"
      And I select "participant_file" in the dropdown field labeled "Save to specified field:"
      And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
      And I enter "Custom" into the input field labeled "File name:"
      And I click on the button labeled "Save"
      Then I should see "Saved!"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name     | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Copy trigger
      ##ACTION: Copy trigger
      When I click on the button labeled "Copy trigger" in the row labeled "Participant Consent"
      Then I should see "Do you wish to copy this PDF Snapshot Trigger?"

      When I click on the button labeled "Copy trigger"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name     | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | [x]    |               | Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Edit trigger
      ##ACTION: Edit trigger
      When I click on the button labeled "Edit trigger" in the column labeled "Edit settings" and the row labeled "2"
      And I enter "Hide Snapshot" into the input field labeled "Name of trigger"
      And I enter "CustomHide" into the input field labeled "File name:"
      And I click on the button labeled "Save"
      Then I should see "Trigger for PDF Snapshot was successfully modified"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | [x]    |               | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

      ##VERIFY_Logging
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
         | Username   | Action        | List of Data Changes OR Fields Exported        |
         | test_admin | Manage/Design | Modify trigger for PDF Snapshot (snapshot_id = |
         | test_admin | Manage/Design | Copy PDF Snapshot Trigger (copy snapshot_id =  |
         | test_admin | Manage/Design | Create trigger for PDF Snapshot (snapshot_id = |

   Scenario: Add record in data survey mode (pdf snapshot created)
      #Add record in data survey mode (pdf snapshot created)
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
      And I should see the "Incomplete" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1" for record "1"

      # Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name        | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | CustomHide_ | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
         | Custom_     | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |


   Scenario: Cancel Inactivate triggers
      When I click on the link labeled "Designer"
      And I click on the button labeled "PDF Snapshot"
      Then I should see a checkbox labeled "Hide inactive" that is checked
       Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | [x]    |               | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

      When I click on the checkbox in the row labeled "Hide Snapshot"
      Then I should see "Are you sure you wish to disable this PDF Snapshot Trigger?"

      When I click on the button labeled "Cancel"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | [x]    |               | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |


   Scenario: Inactivate triggers
      Then I should see a checkbox labeled "Hide inactive" that is checked
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Hide Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | [x]    |               | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

      When I click on the checkbox in the row labeled "Hide Snapshot"
      Then I should see "Are you sure you wish to disable this PDF Snapshot Trigger?"

      When I click on the button labeled "Set as inactive"
      Then I should NOT see "Hide Snapshot"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name     | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]    |               | Snapshot | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |

   Scenario: Unhide inactive
      When I uncheck the checkbox labeled "Hide inactive"
      Then I should see a table header and rows containing the following values in a table:
         | Active  | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]     |               | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | [ ]     |               | Hide Snapshot | Survey completion | Complete survey "Participant Consent" |                       |                                                                    |

   Scenario: Inactivate triggers
      When I click on the checkbox in the column labeled "Active" and the row labeled "Snapshot"
      Then I should see "Are you sure you wish to disable this PDF Snapshot Trigger?"

      When I click on the button labeled "Set as inactive"
      Then I should see a table header and rows containing the following values in a table:
         | Active  | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [ ]     |               | Snapshot      | Survey completion | Complete survey "Participant Consent" |                       |                                                                    |
         | [ ]     |               | Hide Snapshot | Survey completion | Complete survey "Participant Consent" |                       |                                                                    |


   Scenario: Hide inactive
      When I check the checkbox labeled "Hide inactive"
      Then I should see a table header and rows containing the following values in a table:
         | Active | Edit settings | Name | Type of trigger | Save snapshot when... | Scope of the snapshot | Location(s) to save the snapshot |

      And I should NOT see "Hide Snapshot"
      # Below doesn't work due to text - No PDF Snapshot triggers to display
      # And I should NOT see "Snapshot"
      And I should NOT see 'Complete survey "Participant Consent"'
      And I should see "No PDF Snapshot triggers to display"

   Scenario: Add record in data survey mode (pdf snapshot NOT created)
      #Add record
      When I click on the link labeled "Add / Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 2."

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
      Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"
      And I should see the "Incomplete (no data saved)" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1" for record "2"

      # Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name       | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | CustomHide | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
         | Custom_    | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
   #I should NOT see Record 2

   Scenario: Reactivate triggers
      When I click on the link labeled "Designer"
      And I click on the button labeled "PDF Snapshot"
      And I uncheck the checkbox labeled "Hide inactive"
      Then I should see a table header and rows containing the following values in a table:
         | Active  | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [ ]     |               | Snapshot      | Survey completion | Complete survey "Participant Consent" |                       |                                                                    |
         | [ ]     |               | Hide Snapshot | Survey completion | Complete survey "Participant Consent" |                       |                                                                    |


      When I click on the checkbox in the column labeled "Active" and the row labeled "1"
      Then I should see a table header and rows containing the following values in a table:
         | Active  | Edit settings | Name          | Type of trigger   | Save snapshot when...                 | Scope of the snapshot | Location(s) to save the snapshot                                   |
         | [x]     |               | Snapshot      | Survey completion | Complete survey "Participant Consent" | All instruments       | File Repository Specified field: [event_1_arm_1][participant_file] |
         | [ ]     |               | Hide Snapshot | Survey completion | Complete survey "Participant Consent" |                       |                                                                    |

   Scenario: Add record in data survey mode (pdf snapshot created)
      #Add record
      When I click on the link labeled "Add / Edit Records"
      And I click on the button labeled "Add new record for the arm selected above"
      And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
      Then I should see "Adding new Record ID 3."

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
      Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "3"
      And I should see the "Incomplete" icon for the "Pdfs And Combined Signatures Pdf" longitudinal instrument on event "Event 1" for record "3"

      # Verification pdf saved and logged correctly
      ##VERIFY_FiRe
      When I click on the link labeled "File Repository"
      And I click on the link labeled "PDF Snapshot Archive"
      Then I should see a table header and rows containing the following values in a table:
         | Name       | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type |
         | Custom_    | -                                | 3      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
         | CustomHide | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
         | Custom_    | -                                | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) |                        |         |      |
#I should NOT see Record 2
#END