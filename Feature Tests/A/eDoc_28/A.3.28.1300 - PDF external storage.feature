Feature: A.3.28.1300 Control Center: The system shall support e-Consent framework PDF external storage solutions (i.e., Amazon S3, Google Cloud Storage, and Microsoft Azure Blob Storage).
  As a REDCap administrator
  I want to verify Record-level Locking Enhancement with Password verification to external storage
#M This is being tested as a full part 11 test so that REDCap Admins learn how to use part 11 features 
#M The test requires several things to be setup. First in Security and Authentication ensure that you enable "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password." Also, The regular File Upload Storage is configure (eDocs) Then finally Configure the File Vault for Record Level Locking Enhancement in the Modules/Services Configuration. User will need access to lock records and E-Sign. 
#Later in the test, we enable When e-signing, allow users to provide their 6-digit PIN only once per session. (Requires the immediate setting above to be enabled.) 
#FUNCTIONAL_REQUIREMENT A.3.28.1300._NewManual 

  Scenario: ###ACTION: Setup in control center - admin only
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see " Security & Authentication "
    And I select "Enable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
    And I click on the button labeled "Save Changes"
    Then I should see " Your system configuration values have now been changed!"
#FUNCTIONAL_REQUIREMENT A.3.28.1100._NewManual 
#M this script assumes File Storage Methods is configured (File storage is needed for base REDCap file Storage) 

  Scenario: ##ACTION: Configure the External File Storage
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings "
    Then I should see "Microsoft Azure Blob Storage"
#M REDCap Administrators may need to work with their Azure Administrator to get the Account Name, Account Key, and Blob Container information    
    When I enter "staeusp11prod01" in the box labeled "Azure storage account name:"
    And I enter "xxx" in the box labeled "Azure storage account key"
    And I click on the button labeled "Save Changes"
    And I should see "Your configuration values have now been changed"
#FUNCTIONAL_REQUIREMENT   
#File Vault Storage is required for Part 11 Compliance 

  Scenario: ##ACTION: Configure the File Vault for Record-level Locking Enhancement: PDF confirmation & automatic external file storage
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "e-Consent Framework: PDF External Storage Settings (for all projects)"
    And I enable Microsoft Azure Blob Storage for the section labeled " Enable the external storage device and choose storage method (SFTP, WebDAV, Azure, S3):"
        #SETUP 
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.3.28.1300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
        #SETUP_PRODUCTION 
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see Project status: "Production"

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
      | Active | Edit settings         | Name | Type of trigger   | Save snapshot when...                   | Scope of the snapshot  | Location(s) to save the snapshot                    |
      | [x]    | Governed by e-Consent |      | Survey completion | Complete survey "Participant Consent"   | Single survey response | File Repository Specified field: [participant_file] |
      | [x]    | Governed by e-Consent |      | Survey completion | Complete survey "Coordinator Signature" | Single survey response | File Repository Specified field: [coo_sign]         |

  Scenario: Add record
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

  Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)         | Version | Type                  |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 |         | e-Consent Participant |
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
    And I confirm with System Admin that the file is on the External Storage
#END 
