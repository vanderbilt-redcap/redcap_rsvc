Feature: User Interface: The system shall support the capture and storage of multi-form/survey PDF snapshots.
   As a REDCap end user
   I want to see that eConsent is functioning as expected

  Scenario: C.3.24.2600.100 multi-form/survey PDF snapshots.
  #Portions of this feature test are REDUNDANT and can be viewed in C.3.24.2500.100 PDF snapshots conditional logic
      #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.2600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

  Scenario: #SETUP_DESIGNER #SETUP PDF Snapshot Field Trigger 1
    When I click on the link labeled "Designer"
    And I click on the link labeled "Participant Consent"
    And I click on the last button labeled "Add Field"
    And I select "Multiple Choice - Drop-down List (Single Answer)" in the dropdown field labeled "Field Type"
    And I enter "Form 1 Trigger" into the textarea field labeled "Field Label"
    And I enter "trigger1" into the input field labeled "Variable Name"
    And I enter "1, Data Mode\n2, Survey Mode" into the textarea field labeled "Choices (one choice per line)"
    And I click on the button labeled "Save"
    Then I should see the field labeled "Form 1 Trigger"

  Scenario: #SETUP_DESIGNER #SETUP PDF Snapshot Field Trigger
    When I click on the link labeled "Designer"
    And I click on the link labeled "Coordinator Signature"
    And I click on the last button labeled "Add Field"
    And I select "Multiple Choice - Drop-down List (Single Answer)" in the dropdown field labeled "Field Type"
    And I enter "Form 2 Trigger" into the textarea field labeled "Field Label"
    And I enter "trigger2" into the input field labeled "Variable Name"
    And I enter "1, Data Mode\n2, Survey Mode" into the textarea field labeled "Choices (one choice per line)"
    And I click on the button labeled "Save"
    Then I should see the field labeled "Form 2 Trigger"

  Scenario: #SETUP_PRODUCTION
    When I click on the link labeled "Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

  Scenario: New multi data form same event PDF Trigger
    When I click on the link labeled "Designer"
    And I click on the button labeled "PDF Snapshot"
    And I click on the button labeled "Add new trigger"
    And I enter "1 multi data form same event" into the input field labeled "Name of trigger"
    And I click on "" in the textarea field labeled "When the following logic becomes true"
    And I wait for 1 second
    And I clear field and enter "[trigger1]='1' and [trigger2]='1'" into the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "multi data form same event" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name                         | Type of trigger | Save snapshot when...                                 | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               | 1 multi data form same event | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1' | All instruments       | File Repository                  |

  Scenario: New mixed multi data form and survey same event PDF Trigger
      ##ACTION: New PDF Trigger
    When I click on the button labeled "Add new trigger"
    And I enter "2 multi data form and survey same event" into the input field labeled "Name of trigger"
    And I click on "" in the textarea field labeled "When the following logic becomes true"
    And I wait for 1 second
    And I clear field and enter "[trigger1]='2' and [trigger2]='1'" into the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "multi data form and survey same event" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name                                    | Type of trigger | Save snapshot when...                                 | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               |            1 multi data form same event | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1' | All instruments       | File Repository                  |
      | [x]    |               | 2 multi data form and survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1' | All instruments       | File Repository                  |

  Scenario: New multi survey same event PDF Trigger
      ##ACTION: New PDF Trigger
    When I click on the button labeled "Add new trigger"
    And I enter "3 multi survey same event" into the input field labeled "Name of trigger"
    And I click on "" in the textarea field labeled "When the following logic becomes true"
    And I wait for 1 second
    And I clear field and enter "[trigger1]='2' and [trigger2]='2'" into the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "multi survey same event" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name                                    | Type of trigger | Save snapshot when...                                 | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               |            1 multi data form same event | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1' | All instruments       | File Repository                  |
      | [x]    |               | 2 multi data form and survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1' | All instruments       | File Repository                  |
      | [x]    |               |               3 multi survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='2' | All instruments       | File Repository                  |

  Scenario: New multi data form different event PDF Trigger
      ##ACTION: New PDF Trigger
    When I click on the button labeled "Add new trigger"
    And I enter "4 multi data form different event" into the input field labeled "Name of trigger"
    And I click on "" in the textarea field labeled "When the following logic becomes true"
    And I wait for 1 second
    And I clear field and enter "[event_1_arm_1][trigger1]='1' and [event_three_arm_1][trigger1]='1'" into the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "multi data form different event" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name                                    | Type of trigger | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               |            1 multi data form same event | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1'    | All instruments       | File Repository                  |
      | [x]    |               | 2 multi data form and survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1'    | All instruments       | File Repository                  |
      | [x]    |               |               3 multi survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='2'    | All instruments       | File Repository                  |
      | [x]    |               |       4 multi data form different event | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |

  Scenario: New mixed multi data form and survey different event PDF Trigger
      ##ACTION: New PDF Trigger
    When I click on the button labeled "Add new trigger"
    And I enter "5 multi data form and survey different event" into the input field labeled "Name of trigger"
    And I click on "" in the textarea field labeled "When the following logic becomes true"
    And I wait for 1 second
    And I clear field and enter "[event_1_arm_1][trigger1]='1' and [event_three_arm_1][trigger1]='2'" into the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "multi data form and survey different event" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name                                         | Type of trigger | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               |                 1 multi data form same event | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1'    | All instruments       | File Repository                  |
      | [x]    |               |      2 multi data form and survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1'    | All instruments       | File Repository                  |
      | [x]    |               |                    3 multi survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='2'    | All instruments       | File Repository                  |
      | [x]    |               |            4 multi data form different event | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |
      | [x]    |               | 5 multi data form and survey different event | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |

  Scenario: New multi survey different event PDF Trigger
      ##ACTION: New PDF Trigger
    When I click on the button labeled "Add new trigger"
    And I enter "6 multi survey different event" into the input field labeled "Name of trigger"
    And I click on "" in the textarea field labeled "When the following logic becomes true"
    And I wait for 1 second
    And I clear field and enter "[event_1_arm_1][trigger1]='2' and [event_three_arm_1][trigger1]='2'" into the textarea field labeled "Logic Editor" in the dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I check the checkbox labeled "Save as Compact PDF (includes only fields with saved data)"
    And I uncheck the checkbox labeled "Store the translated version of the PDF(if using Multi-language Management)"
    And I check the checkbox labeled "Save to File Repository"
    And I uncheck the checkbox labeled "Save to specified field:"
    And I enter "multi survey different event" into the input field labeled "File name:"
    And I click on the button labeled "Save"
    Then I should see "Saved!"
    Then I should see a table header and rows containing the following values in a table:
      | Active | Edit settings | Name                                         | Type of trigger | Save snapshot when...                                    | Scope of the snapshot | Location(s) to save the snapshot |
      | [x]    |               |                 1 multi data form same event | Logic-based     | Logic becomes true: [trigger1]='1' and [trigger2]='1'    | All instruments       | File Repository                  |
      | [x]    |               |      2 multi data form and survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='1'    | All instruments       | File Repository                  |
      | [x]    |               |                    3 multi survey same event | Logic-based     | Logic becomes true: [trigger1]='2' and [trigger2]='2'    | All instruments       | File Repository                  |
      | [x]    |               |            4 multi data form different event | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |
      | [x]    |               | 5 multi data form and survey different event | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='1' and... | All instruments       | File Repository                  |
      | [x]    |               |               6 multi survey different event | Logic-based     | Logic becomes true: [event_1_arm_1][trigger1]='2' and... | All instruments       | File Repository                  |

  Scenario: Add record - 1 multi data form same event
      #Add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 1."

  Scenario:
    When I select "Data Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

  Scenario:
    When I click the bubble to select a record for the "Coordinator Signature" instrument on event "Event 1"
    When I select "Data Mode" on the dropdown field labeled "Form 2 Trigger"
    And I enter "Coordinator" into the input field labeled "Coordinator's Name Typed"
    
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

    And I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"
    And I should see the "Complete" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
    And I should see the "Complete" icon for the "Coordinator Signature" longitudinal instrument on event "Event 1"

  Scenario: Add record - 2 multi data form and survey same event
      #Add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 2."

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I select "Survey Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
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

  Scenario:
    When I click on the link labeled "Record ID 2"
    When I click the bubble to select a record for the "Coordinator Signature" instrument on event "Event 1"
    When I select "Data Mode" on the dropdown field labeled "Form 2 Trigger"
    And I enter "Coordinator" into the input field labeled "Coordinator's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
    And I should see the "Complete" icon for the "Coordinator Signature" longitudinal instrument on event "Event 1"

  Scenario: Add record -3 multi survey same event
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 3."
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I select "Survey Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from

  Scenario:
    When I click on the link labeled "Record ID 3"
    When I click the bubble to select a record for the "Coordinator Signature" instrument on event "Event 1"
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"
    And I select "Survey Mode" on the dropdown field labeled "Form 2 Trigger"
    And I enter "Coordinator" into the input field labeled "Coordinator's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    Then I click on the link labeled "Record ID 3"
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
    And I should see the "Completed Survey Response" icon for the "Coordinator Signature" longitudinal instrument on event "Event 1"

  Scenario: Add record - 4 multi data form different event
      #Add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 4."

  Scenario:
    When I select "Data Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

  Scenario:
    When I click the bubble to select a record for the "Participant Consent" instrument on event "Event Three"
    And I select "Data Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

  Scenario:
    And I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"
    And I should see the "Complete" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
    And I should see the "Complete" icon for the "Participant Consent" longitudinal instrument on event "Event Three"

  Scenario: Add record -  5 multi data form and survey different event
      #Add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event Three"
    Then I should see "Adding new Record ID 5."

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I select "Survey Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from

  Scenario:
    When I click on the link labeled "Record ID 5"
    When I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    And I select "Data Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I select "Complete" on the dropdown field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event Three"
    And I should see the "Complete" icon for the "Participant Consent" longitudinal instrument on event "Event 1"

  Scenario: Add record -  6 multi survey different event
      #Add record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 6."

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I select "Survey Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from

  Scenario:
    When I click on the link labeled "Record ID 6"
    When I click the bubble to select a record for the "Participant Consent" instrument on event "Event Three"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    And I should see "Please complete the survey below"
    And I select "Survey Mode" on the dropdown field labeled "Form 1 Trigger"
    And I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    Then I click on the link labeled "Record ID 6"
    Then I should see "Record Home Page"
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event Three"

  Scenario: Verification pdf saved and logged correctly
      ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name                                 | PDF utilized e-Consent Framework | Record | Survey Completed             | Identifier (Name, DOB) | Version | Type |
      | multisurveydifferentevent            | -                                |      6 |                              |                        |         |      |
      | multidataformandsurveydifferentevent | -                                |      5 |                              |                        |         |      |
      | multidataformdifferentevent          | -                                |      4 |                              |                        |         |      |
      | multisurveysameevent                 | -                                |      3 |                              |                        |         |      |
      | multidataformandsurveysameevent      | -                                |      2 |                              |                        |         |      |
      | multidataformsameevent               | -                                |      1 |                              |                        |         |      |
#END
