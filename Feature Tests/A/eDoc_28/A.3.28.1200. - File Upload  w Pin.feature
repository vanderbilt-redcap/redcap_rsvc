Feature: A.3.28.1200. Control Center: The system shall support Record-level Locking Enhancement with Password verification to external storage solutions (i.e., Amazon S3, Google Cloud Storage, and Microsoft Azure Blob Storage).
  As a REDCap administrator
  I want to verify Record-level Locking Enhancement with Password verification to external storage
#M This is being tested as a full part 11 test so that REDCap Admins learn how to use part 11 features 
#M The test requires several things to be setup. First in Security and Authentication ensure that you enable "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password." Also, The regular File Upload Storage is configure (eDocs) Then finally Configure the File Vault for Record Level Locking Enhancement in the Modules/Services Configuration. User will need access to lock records and E-Sign. 
#Later in the test, we enable When e-signing, allow users to provide their 6-digit PIN only once per session. (Requires the immediate setting above to be enabled.) 

  Scenario: Start external storage services
    # Start these right away to give them plenty of time to spin up before we need them
    Then if running via automation, start external storage services

  Scenario: Setup in control center - admin only
#FUNCTIONAL_REQUIREMENT A.2.19.1000. 
###ACTION: Setup in control center - admin only 
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see " Security & Authentication "
    And I select "Enable" on the dropdown field labeled "Two-Factor Authentication"
    And I select "Enable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
#FUNCTIONAL_REQUIREMENT A.3.28.1100. 
#M this script assumes File Storage Methods is configured (File storage is needed for base REDCap file Storage) 

  Scenario: ##ACTION: Configure the File Storage
    And I click on the link labeled "File Upload Settings"
    And I click on the radio labeled "Send an email containing your verification code"
    And I enter the code that was emailed to the current user into the input field labeled "Enter the verification code"
    And I click on the button labeled "Submit"
#M REDCap Administrators may need to work with their Azure Administrator to get the Account Name, Account Key, and Blob Container information    
    And I select "Microsoft Azure Blob Storage" on the dropdown field labeled "STORAGE LOCATION OF UPLOADED FILES"
    When I enter "devstoreaccount1" into the input field labeled "Azure storage account name:"
    And I enter "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==" into the input field labeled "Azure storage account key"
    And I enter "mycontainer" into the input field labeled "Azure storage blob container"
    And I click on the button labeled "Save Changes"
    And I should see "Your system configuration values have now been changed"
#FUNCTIONAL_REQUIREMENT  C.2.19.1300. 
#File Vault Storage is required for Part 11 Compliance 

  Scenario: ##ACTION: Configure the File Vault for Record-level Locking Enhancement: PDF confirmation & automatic external file storage
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Record-level Locking Enhancement: PDF confirmation & automatic external file storage"
    And I select "Microsoft Azure Blob Storage" on the dropdown field labeled "Enable the external storage device and choose storage method (SFTP, WebDAV, Azure, S3):"
    And I click on the button labeled "Save Changes"
    And I should see "Your system configuration values have now been changed"
#SETUP 
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.3.28.1200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#M Once the project is created, you must add User Rights, Locking with Signatures, and Additional Customizations 

  Scenario: #SETUP User Rights to lock and sign
#USER_RIGHTS 
    When I click on the link labeled "User Rights"
    And I click on the link labeled "test_admin"
    And I click on the button labeled "Edit user privileges"
    And I click on the radio labeled "Locking / Unlocking with E-signature authority"
    And I should see "Please note that giving a user 'Locking / Unlocking with E-signature authority' privileges"
    And I click on the button labeled "Close"
    And I check the checkbox labeled "Lock/Unlock Entire Records (record level)"
    And I click on the button labeled "Save Changes"
#SETUP Form to lock with signature 
    And I click on the link labeled "Customize & Manage Locking/E-signatures"
    And I check the checkbox in the column labeled "Also display E-signature option on instrument?" and the row labeled "Text Validation"
#SETUP ADDITIONAL CUSTOMIZATIONS 
    When I click on the link labeled "Setup"
    When I click on the button labeled "Additional customizations"
    And I check the checkbox labeled "Enable the Record-level Locking Enhancement: PDF confirmation & automatic external file storage?"
#M for testing for Part 11 this must be enabled 
    And I check the checkbox labeled "Require a 'reason' when making changes to existing records?"
    And I click on the button labeled "Save"
    Then I should see "Success"

  Scenario: ##ACTION: Lock 1 form in a Record
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I check the checkbox labeled "Lock"
    And I check the checkbox labeled "E-signature"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I enter "lock form" into the textarea field labeled "Reason for changes"
    And I click on the button labeled "Save Changes"
    Then I enter "test_admin" into the input field labeled "Username:"
    And I click on the button labeled "Obtain PIN via email"
    And I enter the code that was emailed to the current user into the input field labeled "Password or 6-digit PIN:"
    And I click on the button labeled "Save"
    Then I should see "Instrument locked by test_admin"

  Scenario: ##ACTION: Lock entire record C.2.19.1400.
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "1"
    When I click on the button labeled "Choose action for record"
    And I click on the link labeled "Lock entire record"
    Then I should see "Review record data before locking record"
    And I check the checkbox labeled "I approve the data that is contained in this record."
    And I click on the button labeled "Lock entire record"
    And I click on the icon in the column labeled "Event 2" and the row labeled "Text Validation"
    Then I should see "The entire record was locked by test_admin"
  
  Scenario: #VERIFY LOGGING
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action                | List of Data Changes OR Fields Exported             |
        | mm/dd/yyyy hh:mm | test_admin | Lock/Unlock Record 1  | Action: Lock entire record Record: 1 - Arm 1: Arm 1 |

  Scenario: #VERIFY FILE REPO
    And I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Archive of Locked Records"
    And I should see "Showing 1 to 1 of 1 entries"
    Then I should see a link labeled ".pdf" in the row labeled "1"
    Then I should see the following values in the most recent file in the Azure Blob Storage container
      | E-signed by test_admin |
      | Record ID 1 |
      | Please complete the survey below |

#FUNCTIONAL_REQUIREMENT A.2.19.1100. 

  Scenario: ###ACTION: Setup in control center - admin only
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see " Security & Authentication "
    And I select "Enable" on the dropdown field labeled "When e-signing, allow users to provide their 6-digit PIN only once per session. (Requires the immediate setting above to be enabled.)"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

  Scenario: ##ACTION: Lock entire record Record 2 confirms that PIN is not usedC.2.19.1400.
    Then I click on the link labeled "My Projects"
    Then I click on the link labeled "A.3.28.1200"
    And I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "2" and click on the bubble
    And I check the checkbox labeled "Lock"
    And I check the checkbox labeled "E-signature"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I enter "lock form" into the textarea field labeled "Reason for changes"
    And I click on the button labeled "Save Changes"
    Then I enter "test_admin" into the input field labeled "Username:"
    And I click on the button labeled "Obtain PIN via email"
    And I enter the code that was emailed to the current user into the input field labeled "Password or 6-digit PIN:"
    And I click on the button labeled "Save"
    Then I should see "Instrument locked by test_admin"
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "3"
    When I click on the button labeled "Choose action for record"
    And I click on the link labeled "Lock entire record"
    Then I should see "Review record data before locking record"
    And I check the checkbox labeled "I approve the data that is contained in this record."
    And I click on the button labeled "Lock entire record"
    And I click on the icon in the column labeled "Event 2" and the row labeled "Text Validation"
    Then I should see "The entire record was locked by test_admin"
    And I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble
    And I check the checkbox labeled "Lock"
    And I check the checkbox labeled "E-signature"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I enter "lock form" into the textarea field labeled "Reason for changes"
    And I click on the button labeled "Save Changes"
    Then I see "my usename" and PIN have been filled in
    And I type "my 6-digit" PIN"
#M you should see black dots in the password field 
    And I click on the button labeled "Save"
    Then I should see " Instrument locked by test_admin@test.edu (Admin User) on 08-01-2025 16:51"

  Scenario: #VERIFY LOGGING
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | this is a placeholder table to ensure full automation failure of this step until we can finish this feature |
  Scenario: #VERIFY FILE REPO
    And I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Archive of Locked Records"
    Then I should see a file named " pid274_id2_2025-08-01_172633.pdf"
    And I confirm with System Admin that the file is on the External Storage

  Scenario: Stop external storage services
    Then if running via automation, stop external storage services