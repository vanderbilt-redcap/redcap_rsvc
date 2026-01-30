Feature: User Interface: The system shall support the e-Consent Framework for version control for forms, ensuring that new unique versions can be created, managed, and presented to participants as required. Historical versions shall be maintained for audit and compliance purposes.
    As a REDCap end user
    I want to see that eConsent is functioning as expected

  Scenario: C.3.24.1500.100 e-Consent create unique version using text box
        #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.24.1500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

  Scenario: #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far"
    And I click on the button labeled "YES, Move to Production Status"
    Then I should see "Project status:  Production"

  Scenario: Cancel an add consent form version
        #SETUP_eConsent
    When I click on the link labeled "Designer"
    And I click on the button labeled "e-Consent"
    Then I should see "Participant Consent"
    And I wait for 1 second

  Scenario:
    When I click on the link labeled "Add consent form" in the row labeled "Participant Consent"
    Then I should see "Consent form version"

  Scenario: #CROSS-REF ##C.3.24.1600.100 Add consent form version via rich text
    When I enter "test 1" into the input field labeled "Consent form version:"
    And I select "Consent file" on the dropdown field labeled "Placement of consent form:"
    And I select "When record is not assigned to a DAG (default)" on the dropdown field labeled "Display for specific DAG"
    And I select "No languages defined on MLM page" on the dropdown field labeled "Display for specific language"
    And I enter "This is my test 1 consent form" into the textarea field labeled "Consent Form (Rich Text)"
    And I click on the button labeled "Cancel"
    Then I should see "v1.0" in the row labeled "Participant Consent"

  Scenario: Add consent form version via rich text
    When I click on the link labeled "Add consent form" in the row labeled "Participant Consent"
    Then I should see "Consent form version"

  Scenario:
    When I enter "test 1" into the input field labeled "Consent form version:"
    And I select "Consent file" on the dropdown field labeled "Placement of consent form:"
    And I select "When record is not assigned to a DAG (default)" on the dropdown field labeled "Display for specific DAG"
    And I select "No languages defined on MLM page" on the dropdown field labeled "Display for specific language"
    And I enter "This is my test 1 consent form" into the textarea field labeled "Consent Form (Rich Text)"
    And I click on the button labeled "Add new consent form"
    And I wait for 1 second
    Then I should see "vtest 1" in the row labeled "Participant Consent"

  Scenario: #VERIFY: view all versions for Test 1
    When I click on the link labeled "View all versions" in the row labeled "Participant Consent"
    Then I should see a table header and rows containing the following values in a table:
      | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
      |            |     1.0 |                    |                         |                           0 |                   |              | _Fake_Consent[311203].pdf             |                              |
      |            | test 1  |                    | Test_Admin (Admin User) |                           0 |                   |              | "This is my test 1 consent form"      |                              |
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "1.0"
    And I should see a button labeled "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 1"
    When I click on the button labeled "Close"
    Then I should see "vtest 1" in the row labeled "Participant Consent"

  Scenario: ##VERIFY_Logging
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported                                      |
      | test_admin | Manage/Design | Add new consent form for instrument "participant_consent" (consent_form_id = |

  Scenario: #Test e-Consent by adding record
        ##ACTION: add record to get participant signature
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 1."
    And I should see "This is my test 1 consent form"

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"
    And I should see "This is my test 1 consent form"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."

  Scenario:
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

  Scenario: #Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)         | Version | Type |                       |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 | test 1  |      | e-Consent Participant |

  Scenario:
    When I click on the link labeled "pid13_formParticipantConsent_id1_"
    Then I should see the following values in the last file downloaded
      | This is my test 1 consent form |
    #Manual: Close document

  Scenario: C.3.24.1500.200 e-Consent create unique version using Inline PDF
  #CROSS-REF ##C.3.24.1600.200 e-Consent create unique version using Inline PDF
        #Add consent form version via file upload
        #SETUP_eConsent
    When I click on the link labeled "Designer"
    And I click on the button labeled "e-Consent"
    Then I should see "Participant Consent"
    And I wait for 1 second

  Scenario:
    When I click on the link labeled "Add consent form" in the row labeled "Participant Consent"
    Then I should see "Consent form version"
        # Unable to add an existing version name

  Scenario:
    When I enter "test 1" into the input field labeled "Consent form version:"
    And I click on the button labeled "Add new consent form"
        #Verify error
    Then I should see "ERROR: You must provide your consent form"

  Scenario:
    When I click on the button labeled "Close"
        #Add unique version
    And I clear field and enter "test 2" into the input field labeled "Consent form version:"
    And I select "Consent file" on the dropdown field labeled "Placement of consent form:"
    And I select "When record is not assigned to a DAG (default)" on the dropdown field labeled "Display for specific DAG"
    And I select "No languages defined on MLM page" on the dropdown field labeled "Display for specific language"
    And I click on the button labeled "Consent Form (Inline PDF)"
        #Adding a .png file will cause an error
    And I upload a "pdf" format file located at "import_files/consent.png", by clicking the button near "Upload your PDF consent form" to browse for the file, and clicking the button labeled "Add new consent form" to upload the file

  Scenario: Verify error
    Then I should see "ERROR: Only PDF files are allowed"

  Scenario:
    When I click on the button labeled "OK"
        #Adding a .pdf file will upload
    And I upload a "pdf" format file located at "import_files/consent.pdf", by clicking the button near "Upload your PDF consent form" to browse for the file, and clicking the button labeled "Add new consent form" to upload the file
    And I wait for 1 second

    Then I should see "vtest 2" in the row labeled "Participant Consent"

  Scenario: #view all versions for Test 1
    When I click on the link labeled "View all versions" in the row labeled "Participant Consent"
    Then I should see a table header and rows containing the following values in a table:
      | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
      |            |     1.0 |                    |                         |                           0 |                   |              | _Fake_Consent[311203].pdf               |                              |
      |            | test 1  |                    | Test_Admin (Admin User) |                           1 |                   |              | "This is my test 1 consent form"        |                              |
      |            | test 2  |                    | Test_Admin (Admin User) |                           0 |                   |              | consent.pdf                             |                              |
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "1.0"
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 1"
    And I should see a button labeled "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 2"
    When I click on the button labeled "Close"
    Then I should see "vtest 2" in the row labeled "Participant Consent"

  Scenario: ##VERIFY_Logging
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported                                      |
      | test_admin | Manage/Design | Add new consent form for instrument "participant_consent" (consent_form_id = |

  Scenario: # Test e-Consent by adding record
        ##ACTION: add record to get participant signature
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 2."
    And I should see the consent pdf has loaded in the iframe
    #Manual: Then I should see "CONSENT" in the PDF content displayed within the page

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"
    And I should see the consent pdf has loaded in the iframe
    #Manual: Then I should see "CONSENT" in the PDF content displayed within the page

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."

  Scenario:
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"

  Scenario: #Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)         | Version | Type |                       |
      | .pdf |                                  |      2 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 | test 2  |      | e-Consent Participant |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 | test 1  |      | e-Consent Participant |

  Scenario:
    When I click on the link labeled "pid13_formParticipantConsent_id2_"
    Then I should see the following values in the last file downloaded
      | Version: test 2 |
    #Manual: Close document

  Scenario: C.3.24.1500.300 Disable version
        #Add consent form version via file upload
        #SETUP_eConsent
    When I click on the link labeled "Designer"
    And I click on the button labeled "e-Consent"
    Then I should see "Participant Consent"
    And I wait for 1 second

  Scenario: #view all versions
    When I click on the link labeled "View all versions" in the row labeled "Participant Consent"
    Then I should see a table header and rows containing the following values in a table:
      | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
      |            |     1.0 |                    |                         |                           0 |                   |              | _Fake_Consent[311203].pdf               |                              |
      |            | test 1  |                    | Test_Admin (Admin User) |                           1 |                   |              | "This is my test 1 consent form"        |                              |
      |            | test 2  |                    | Test_Admin (Admin User) |                           1 |                   |              | consent.pdf                             |                              |
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "1.0"
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 1"
    And I should see a button labeled "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 2"

  Scenario:
    When I click on the button labeled "Set as inactive"
    Then I should see "Set consent form as inactive"

  Scenario: #Cancel inactivation of version
    When I click on the button labeled "Cancel"
    Then I should see a table header and rows containing the following values in a table:
      | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
      |            |     1.0 |                    |                         |                           0 |                   |              | _Fake_Consent[311203].pdf               |                              |
      |            | test 1  |                    | Test_Admin (Admin User) |                           1 |                   |              | "This is my test 1 consent form"        |                              |
      |            | test 2  |                    | Test_Admin (Admin User) |                           1 |                   |              | consent.pdf                             |                              |
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "1.0"
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 1"
    And I should see a button labeled "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 2"

  Scenario:
    When I click on the button labeled "Set as inactive"
    Then I should see "Set consent form as inactive"

  Scenario:
    When I click on the button labeled "Set consent form as inactive"
    Then I should see "Consent form has been successfully removed"
    And I wait for 5 seconds
    And I should see a table header and rows containing the following values in a table:
      | Active?    | Version | Time added         | Uploaded by             | Number of records consented | Data Access Group | MLM Language | Consent form text or file               | Set consent form as inactive |
      |            |     1.0 |                    |                         |                           0 |                   |              | _Fake_Consent[311203].pdf               |                              |
      |            | test 1  |                    | Test_Admin (Admin User) |                           1 |                   |              | "This is my test 1 consent form"        |                              |
      |            | test 2  |                    | Test_Admin (Admin User) |                           1 |                   |              | consent.pdf                             |                              |
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "1.0"
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 1"
    And I should NOT see "Set as inactive" in the column labeled "Set consent form as inactive" and the row labeled "test 2"

  Scenario: C.3.24.1500.400 View historical version
    When I click on the link labeled "consent.pdf"
    Then I should see "Displaying consent form content"
    #Manual: Then I should see "CONSENT" in the PDF content displayed within the page
    Then I click on the button labeled "Close"
    #Manual: Close document

  Scenario:
    When I click on the button labeled "Close"
    Then I should NOT see "Consent form vtest 2" in the row labeled "Participant Consent"

  Scenario: ##ACTION: Test e-Consent version is gone by adding record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 3."
    And I should NOT see "consent.pdf"

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay"
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"
    And I should NOT see "consent.pdf"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"

  Scenario:
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."

  Scenario:
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "3"

  Scenario: #Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)         | Version | Type                  |
      | .pdf |                                  |      3 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 |         | e-Consent Participant |
      | .pdf |                                  |      2 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 | test 2  | e-Consent Participant |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 | test 1  | e-Consent Participant |

  Scenario:
    When I click on the link labeled "pid13_formParticipantConsent_id3_"
    Then I should see the following values in the last file downloaded
      # Make sure the DOB is followed immediatly by "Participant", verifying that the consent "Version:" is omitted. 
      | 2000-01-01, Participant |
#Manual: Close document
#END
