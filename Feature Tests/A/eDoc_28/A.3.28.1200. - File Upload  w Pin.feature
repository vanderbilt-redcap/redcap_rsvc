Feature: A.3.28.1200. Control Center: The system shall support Record-level Locking Enhancement with Password verification to external storage solutions (i.e., Amazon S3, Google Cloud Storage, and Microsoft Azure Blob Storage).
  As a REDCap administrator
  I want to verify Record-level Locking Enhancement with Password verification to external storage
#M This is being tested as a full part 11 test so that REDCap Admins learn how to use part 11 features 
#M The test requires several things to be setup. First in Security and Authentication ensure that you enable "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password." Also, The regular File Upload Storage is configure (eDocs) Then finally Configure the File Vault for Record Level Locking Enhancement in the Modules/Services Configuration. User will need access to lock records and E-Sign. 
#Later in the test, we enable When e-signing, allow users to provide their 6-digit PIN only once per session. (Requires the immediate setting above to be enabled.) 

  Scenario: Setup in control center - admin only
#FUNCTIONAL_REQUIREMENT A.2.19.1000._NewManual 
###ACTION: Setup in control center - admin only 
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see " Security & Authentication "
    And I select "Enable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
    And I click on the button labeled "Save Changes"
    Then I should see " Your system configuration values have now been changed!"
#FUNCTIONAL_REQUIREMENT A.3.28.1100._NewManual 
#M this script assumes File Storage Methods is configured (File storage is needed for base REDCap file Storage) 

  Scenario: ##ACTION: Configure the File Storage
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings "
    Then I should see "Microsoft Azure Blob Storage"
#M REDCap Administrators may need to work with their Azure Administrator to get the Account Name, Account Key, and Blob Container information    
    When I enter "staeusp11prod01" in the box labeled "Azure storage account name:"
    And I enter "xxx" in the box labeled "Azure storage account key"
    And I click on the button labeled "Save Changes"
    And I should see "Your configuration values have now been changed"
#FUNCTIONAL_REQUIREMENT  C.2.19.1300._NewManual 
#File Vault Storage is required for Part 11 Compliance 

  Scenario: ##ACTION: Configure the File Vault for Record-level Locking Enhancement: PDF confirmation & automatic external file storage
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Record-level Locking Enhancement: PDF confirmation & automatic external file storage"
    And I enable Microsoft Azure Blob Storage for the section labeled " Enable the external storage device and choose storage method (SFTP, WebDAV, Azure, S3):"
#SETUP 
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.3.28.1200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#M Once the project is created, you must add User Rights, Locking with Signatures, and Additional Customizations 

  Scenario: #SETUP User Rights to lock and sign
#USER_RIGHTS 
    When I click on the link labeled "User Rights"
    And I select "Test_Admin"
    And I "Edit User privileges"
    And I select the button labeled Locking/Unlocking with E-signature authority
    And I check the box labeled " Lock/Unlock Entire Records (record level)"
    And I Click the button labeled "Save Changes"
#SETUP Form to lock with signature 
    And I click the link labeled "Customize & Manage Locking/E-signatures"
    And I check the box labeled "Also display E-signature option on instrument?" Next to "Text Validation"
#SETUP ADDITIONAL CUSTOMIZATIONS 
    When I click the button labeled "Additional Customizations"
    And I enable " Enable the Record-level Locking Enhancement: PDF confirmation & automatic external file storage?
#M for testing for Part 11 this must be enabled 
    And I enable "Require a 'reason' when making changes to existing records?"
    And I click the button labeled "Save"
    Then I should see "Success"

  Scenario: ##ACTION: Lock 1 form in a Record
    When I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Text Validation" for Record 1
    And I check the box labeled "Lock"
    And I check the box labeled "E-signature"
    And click the button labeled "Save and Stay"
    And I type "lock form" in the box labeled "Reason for changes"
    And I click "Save Changes"
    Then I type "my usename"
    And I type "my 6-digit" PIN"
    And I click the button labeled "Save"
    Then I should see " Instrument locked by teresa.bosler@vumc.org (Teresa Bosler) on 08-01-2025 16:51"

  Scenario: ##ACTION: Lock entire record C.2.19.1400._NewManual
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "1"
    And I select "Lock entire record" from the dropdown labeled "Choose action for record"
    Then I should see "Review record data before locking record"
    And I check the box labeled "I approved the data that is contained in this record."
    And I click the button labeled "Lock entire record"
    Then I should see "Record x is now locked"

  Scenario: #VERIFY LOGGING
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:

  Scenario: #VERIFY FILE REPO
    And I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Archive of Locked Records"
    Then I should see a file named " pid274_id1_2025-08-01_172633.pdf"
    And I confirm with System Admin that the file is on the External Storage
    And I logout
#FUNCTIONAL_REQUIREMENT A.2.19.1100._NewManual 

  Scenario: ###ACTION: Setup in control center - admin only
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see " Security & Authentication "
    And I select "Enable" on the dropdown field labeled "When e-signing, allow users to provide their 6-digit PIN only once per session. (Requires the immediate setting above to be enabled.)"
    And I click on the button labeled "Save Changes"
    Then I should see " Your system configuration values have now been changed!"

  Scenario: ##ACTION: Lock entire record Record 2 confirms that PIN is not usedC.2.19.1400._NewManual
    Given I login with Test_Admin
    And I select "A.3.28.1200" from "My Project"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Text Validation" for Record 2
    And I check the box labeled "Lock"
    And I check the box labeled "E-signature"
    And click the button labeled "Save and Stay"
    And I type "lock form" in the box labeled "Reason for changes"
    And I click "Save Changes"
    Then I type "my usename"
    And I type "my 6-digit" PIN"
    And I click the button labeled "Save"
    Then I should see " Instrument locked by teresa.bosler@vumc.org (Teresa Bosler) on 08-01-2025 16:51"
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "3"
    And I select "Lock entire record" from the dropdown labeled "Choose action for record"
    Then I should see "Review record data before locking record"
    And I check the box labeled "I approved the data that is contained in this record."
    And I click the button labeled "Lock entire record"
    Then I should see "Record x is now locked"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Text Validation" for Record 3
    And I check the box labeled "Lock"
    And I check the box labeled "E-signature"
    And click the button labeled "Save and Stay"
    And I type "lock form" in the box labeled "Reason for changes"
    And I click "Save Changes"
    Then I see "my usename" and PIN have been filled in
    And I type "my 6-digit" PIN"
#M you should see black dots in the password field 
    And I click the button labeled "Save"
    Then I should see " Instrument locked by teresa.bosler@vumc.org (Teresa Bosler) on 08-01-2025 16:51"

  Scenario: #VERIFY LOGGING
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:

  Scenario: #VERIFY FILE REPO
    And I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Archive of Locked Records"
    Then I should see a file named " pid274_id2_2025-08-01_172633.pdf"
    And I confirm with System Admin that the file is on the External Storage
