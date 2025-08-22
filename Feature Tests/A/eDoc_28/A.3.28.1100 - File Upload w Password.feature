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
    And I click on the link labeled "File Upload Settings "
    Then I should see "Microsoft Azure Blob Storage"
#M REDCap Administrators may need to work with their Azure Administrator to get the Account Name, Account Key, and Blob Container information    
    When I enter "staeusp11prod01" in the box labeled "Azure storage account name:"
    And I enter "xxx" in the box labeled "Azure storage account key"
    And I click on the button labeled "Save Changes"
    And I should see "Your configuration values have now been changed"
#FUNCTIONAL_REQUIREMENT   
#File Vault Storage is required for Part 11 Compliance 
##ACTION: Configure the File Vault for File Uploads 
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see " Enable this system-level setting for password verification" for the section labeled "'File Upload' field enhancement: Password verification & automatic external file storage"
#M REDCap Administrators may need to work with their Azure Administrator to get the Account Name, Account Key, and Blob Container information    
    And I select "Microsoft Azure Blob Storage"
    And I enter "redcap-part11" in the field labeled Azure/S3-only settings"
    And I click on the button labeled "Save Changes"
    And I should see "Your system configuration values have now been changed"
#SETUP 
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named " A.3.28.1100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#M Once the project is created, you must add Additional Customizations 
#SETUP ADDITIONAL CUSTOMIZATIONS 
    When I click the button labeled "Additional Customizations"
    And I enable "File Version History for File Upload Fields"
    And I enable "File Upload' field enhancement: Password verification & automatic external file storage"
#M for testing for Part 11 this must be enabled 
    And I enable "Require a 'reason' when making changes to existing records?"
    And I click the button labeled "Save"
    Then I should see "Success"
##ACTION: add record to file upload 
    When I click on the link labeled "Add/Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on the bubble labeled "Data Types" for event "Event 1"
    Then I should see "Adding new Record ID 5"
    When I click on the button labeled "Save & Stay"
    And I click on the link labeled "File Upload" in the dialog box
    And I click the button labeled "Choose File"
    And I select xxx.pdf
    And I click the button labeled "Upload"
    And I enter "My password or PIN"
    And I click the button labeled "Confirm"
    And I click the button labeled "Upload file"
    Then I should see "File successfully uploaded"
    And I should see "xxx.pdf"
    And I click on the button labeled "Save & Stay"
#VERIFY LOGGING 
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
    And I log out
#M Test_Admin Logs out  and logs back in to ensure that when they enter another record with a file upload that it requires the PIN again 
#SETUP 
    Given I login to REDCap with the user "Test_Admin"
    And I open a project named " A.3.28.1100"
##ACTION: add record to file upload 
    When I click on the link labeled "Add/Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on the bubble labeled "Data Types" for event "Event 1"
    Then I should see "Adding new Record ID 6"
    When I click on the button labeled "Save & Stay"
    And I click on the link labeled "File Upload" in the dialog box
    And I click the button labeled "Choose File"
    And I select xxx.pdf
    And I click the button labeled "Upload"
    And I enter "My password or PIN"
    And I click the button labeled "Confirm"
    And I click the button labeled "Upload file"
    Then I should see "File successfully uploaded"
    And I should see "xxx.pdf"
    And I click on the button labeled "Save & Stay"
#VERIFY LOGGING 
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
    And I log out
#FUNCTIONAL_REQUIREMENT  
###ACTION: Setup in control center - admin only 
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see " Security & Authentication "
    And I select "Disable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
#SETUP 
    Given I login to REDCap with the user "Test_Admin"
    And I open a project named " A.3.28.1100"
##ACTION: add record to file upload 
    When I click on the link labeled "Add/Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on the bubble labeled "Data Types" for event "Event 1"
    Then I should see "Adding new Record ID 7"
    When I click on the button labeled "Save & Stay"
    And I click on the link labeled "File Upload" in the dialog box
    And I click the button labeled "Choose File"
    And I select xxx.pdf
    And I click the button labeled "Upload"
    And I enter " PIN"
    And I click the button labeled "Confirm"
    Then I should see "Error the username or password that you entered is incorrect"
    And I click the button labeled "Close"
    And I click the button labeled "Cancel"
#VERIFY LOGGING 
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
    And there will not be an entry for a File upload with Record 7
    And I log out
