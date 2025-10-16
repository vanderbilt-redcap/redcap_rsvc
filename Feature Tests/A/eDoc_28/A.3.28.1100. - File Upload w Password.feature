Feature: A.3.28.1100 Control Center: The system shall support File Upload field enhancement with Password verification to external storage solutions (i.e., Amazon S3, Google Cloud Storage, and Microsoft Azure Blob Storage).
As a REDCap administrator 
I want to verify that the File Upload field enhancement requires a password or PIN before routing files to external storage   
#IMPLEMENTATION NOTE: This requirement supports enhanced file upload with password verification to external storage.   
## Compatible storage types include: Microsoft Azure Blob Storage, Amazon S3, and Google Cloud Storage.   
## This script demonstrates Azure Blob Storage; sites may adjust values for S3 or GCS.   
## REDCap does not verify file delivery to external storage — site admins must confirm externally (D).   
#M This is being tested as a full part 11 test so that REDCap Admins learn how to use part 11 features 
#M The test requires several things to be setup. First in Security and Authentication ensure that you enable "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password." Also, The regular File Upload Storage is configure (eDocs) Then finally Configure the File Vault for File Uploads in the Modules/Services Configuration 
#Later in the test, we enable When e-signing, allow users to provide their 6-digit PIN only once per session. (Requires the immediate setting above to be enabled.) 

  Scenario: A.3.28.1100.0100 – One 6-digit PIN per session (trigger more than one File Upload event)
#FUNCTIONAL_REQUIREMENT  
###ACTION: Setup in control center - admin only 
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication"
#A.2.19.1100.0200. Enable e-signing, allow users to provide their 6-digit PIN 
    And I select "Enable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
#FUNCTIONAL_REQUIREMENT  
#M this script assumes File Storage Methods is configured (File storage is needed for base REDCap file Storage) 
##ACTION: Configure the File Storage   
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    Then I should see "Microsoft Azure Blob Storage"
#M REDCap Administrators may need to work with their Azure Administrator to get the Account Name, Account Key, and Blob Container information    
    When I enter "devstoreaccount1" into the input field labeled "Azure storage account name:"
    And I enter "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==" into the input field labeled "Azure storage account key"
    And I click on the button labeled "Save Changes"
    And I should see "Your system configuration values have now been changed"
#FUNCTIONAL_REQUIREMENT   
#File Vault Storage is required for Part 11 Compliance 
##ACTION: Configure the File Vault for File Uploads 
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I select "Microsoft Azure Blob Storage" on the dropdown field labeled "Enable this system-level setting for password verification"
    And I select "Microsoft Azure Blob Storage" on the dropdown field labeled "Enable the external storage device and choose storage method (SFTP, WebDAV, Azure, S3):"
#M REDCap Administrators may need to work with their Azure Administrator to get the Account Name, Account Key, and Blob Container information    
    And I enter "redcap-part11" into the first input field labeled "Bucket/container name"
    And I click on the button labeled "Save Changes"
    And I should see "Your system configuration values have now been changed"
#SETUP 
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named " A.3.28.1100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#M Once the project is created, you must add Additional Customizations 
#SETUP ADDITIONAL CUSTOMIZATIONS 
    When I click on the button labeled "Additional customizations"
    And I enable the checkbox labeled "Enable the File Version History for 'File Upload' fields?"
    And I enable the checkbox labeled "File Upload' field enhancement: Password verification & automatic external file storage"
#M for testing for Part 11 this must be enabled 
    And I enable the checkbox labeled "Require a 'reason' when making changes to existing records?"
    And I click on the button labeled "Save"
    Then I should see "Success"
##ACTION: add record to file upload 
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    Then I should see "Adding new Record ID 5"
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    
    And I click on the link labeled "Upload file" in the row labeled "File Upload"
    And I upload a "pdf" format file located at "import_files/consent.pdf", by clicking the button near "Select a file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    And I enter "Testing123" into the input field labeled "Password:"
    And I click on the button labeled "Confirm"
    Then I should see "consent.pdf" in the row labeled "File Upload"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I enter "lock form" into the textarea field labeled "Reason for changes"
    And I click on the button labeled "Save Changes"
#VERIFY LOGGING 
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported                             |
        | mm/dd/yyyy hh:mm | test_admin | Update record 5  | file_upload =                                                       |
        | mm/dd/yyyy hh:mm | test_admin | Update record 5  | Document upload was confirmed with password (field = 'file_upload') |
        | mm/dd/yyyy hh:mm | test_admin | Create record 5  |                                                                     |
    And I logout
#M Test_Admin Logs out  and logs back in to ensure that when they enter another record with a file upload that it requires the PIN again 
#SETUP 
    Given I login to REDCap with the user "Test_Admin"
##ACTION: add record to file upload 
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    Then I should see "Adding new Record ID 6"
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the link labeled "Upload file" in the row labeled "File Upload"
    And I upload a "pdf" format file located at "import_files/consent.pdf", by clicking the button near "Select a file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    And I enter "Testing123" into the input field labeled "Password:"
    And I click on the button labeled "Confirm"
    Then I should see "consent.pdf" in the row labeled "File Upload"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I enter "lock form" into the textarea field labeled "Reason for changes"
    And I click on the button labeled "Save Changes"
#VERIFY LOGGING 
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported                             |
        | mm/dd/yyyy hh:mm | test_admin | Update record 5  | file_upload =                                                       |
        | mm/dd/yyyy hh:mm | test_admin | Update record 5  | Document upload was confirmed with password (field = 'file_upload') |
        | mm/dd/yyyy hh:mm | test_admin | Update record 5  | file_upload =                                                       |
        | mm/dd/yyyy hh:mm | test_admin | Update record 5  | Document upload was confirmed with password (field = 'file_upload') |
        | mm/dd/yyyy hh:mm | test_admin | Create record 5  |                                                                     |
    And I logout
#FUNCTIONAL_REQUIREMENT  
###ACTION: Setup in control center - admin only
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see " Security & Authentication "
    And I select "Disable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
#SETUP 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.1100"
##ACTION: add record to file upload 
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    Then I should see "Adding new Record ID 7"
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the link labeled "Upload file" in the row labeled "File Upload"
    And I upload a "pdf" format file located at "import_files/consent.pdf", by clicking the button near "Select a file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    And I enter "something invalid" into the input field labeled "Password"
    And I click on the button labeled "Confirm"
    Then I should see "The username or password that you entered is incorrect"
    And I click on the button labeled "Close"
    And I click on the button labeled "Cancel"
    And I click on the button labeled "Close"
#VERIFY LOGGING 
    And I click on the link labeled "Logging"
    Then I should NOT see "Update record\n7"
    And I logout