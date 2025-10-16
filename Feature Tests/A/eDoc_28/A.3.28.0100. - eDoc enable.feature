Feature: A.3.28.0100. Control Center: The system shall allow administrators to configure local or external file storage solutions for REDCap uploads (e.g., Local, Amazon S3, Google Cloud Storage, Microsoft Azure Blob Storage, WebDAV).
As a REDCap administrator   

 I want to verify that the File Upload Settings allow for local file storage   
 So that uploaded PDF snapshots are correctly saved and retrievable 

#IMPLEMENTATION NOTE: This requirement supports multiple REDCap file storage configuration options: 
## Local, Microsoft Azure Blob Storage, Amazon S3, Google Cloud Storage, and WebDAV. 
## Each method is tested in its own scenario. 
## Sites should only run the scenarios relevant to their environment. 
## REDCap does not confirm external file receipt; verification of external storage must be done at the site level (D). 

  Scenario: Start external storage services
    # Start these right away to give them plenty of time to spin up before we need them
    Then if running via automation, start external storage services

  Scenario: A.3.28.0100.0100. Configure Local File Storage
# Default REDCap configuration storing files in /edocs/ or another local path. No external setup or credentials required. 
      #SETUP 
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Local (on REDCap web server)" on the dropdown field labeled "STORAGE LOCATION OF UPLOADED FILES"
    Then I enter "" into the input field labeled "SET LOCAL FILE STORAGE LOCATION"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    When I create a new project named "A.3.28.0100.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastNameLocal" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "email"
    And I enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature" in the row labeled "Participant signature field"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Close survey"
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
      #VERIFY_RSD 
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid13_formParticipantConsent_id1_"
    Given I download the PDF by clicking on the link for Record "1" and Survey "Participant Consent" in the File Repository table
    Then I should see the following values in the last file downloaded
      | PID 13 - LastNameLocal |
      | FirstName LastNameLocal, 2000-01-01, Version: 1.0, Participant     |
      #Manual: Close document 
#VERIFY Confirm file exists in local server directory 
 # FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Then I should see the following values in the most recent file in the local storage path
      | PID 13 - LastNameLocal |
      | FirstName LastNameLocal, 2000-01-01, Version: 1.0, Participant      |

  Scenario: A.3.28.0100.0200 – Configure Microsoft Azure Blob Storage
# Requires Azure storage account name, key, container, and environment. Site must confirm that uploaded files are routed to the Azure container. 
#SETUP 
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Microsoft Azure Blob Storage" on the dropdown field labeled "STORAGE LOCATION OF UPLOADED FILES"
    #Manual: These settings will only work for automation.  Manual testing will require an account specific to your site.
    And I enter "devstoreaccount1" into the input field labeled "Azure storage account name"
    And I enter "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==" into the input field labeled "Azure storage account key"
    And I enter "mycontainer" into the input field labeled "Azure storage blob container"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    When I create a new project named "A.3.28.0100.0200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastNameAzure" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "email"
    And I enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature" in the row labeled "Participant signature field"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Close survey"
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
      #VERIFY_RSD 
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid14_formParticipantConsent_id1_"
    Given I download the PDF by clicking on the link for Record "1" and Survey "Participant Consent" in the File Repository table
    Then I should see the following values in the last file downloaded
      | PID 14 - LastNameAzure |
      | FirstName LastNameAzure, 2000-01-01, Version: 1.0, Participant     |
      #Manual: Close document 
 #VERIFY Confirm file exists in Azure Blob Storage 
 # Site must verify that the PDF file was saved in the configured Microsoft Azure Blob Storage container 
   # FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Then I should see the following values in the most recent file in the Azure Blob Storage container
      | PID 14 - LastNameAzure   |
      | FirstName LastNameAzure, 2000-01-01, Version: 1.0, Participant |

  Scenario: A.3.28.0100.0300 – Configure Amazon S3 Storage
# Requires AWS access key, secret key, bucket name, and region. # Site must verify file appearance in the configured S3 bucket. 
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Amazon S3" on the dropdown field labeled "STORAGE LOCATION OF UPLOADED FILES"
    #Manual: These settings will only work for automation.  Manual testing will require an account specified to your site.
    And I enter "minioadmin" into the input field labeled "AWS Access Key"
    And I enter "minioadmin" into the input field labeled "AWS Secret Key"
    And I enter "mybucket" into the input field labeled "Bucket"
    And I enter "http://minio.local:9000" into the input field labeled "S3 Custom Endpoint"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    When I create a new project named "A.3.28.0100.0300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastNameS3" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "email"
    And I enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature" in the row labeled "Participant signature field"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Close survey"
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
      #VERIFY_RSD 
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid15_formParticipantConsent_id1_"
    Given I download the PDF by clicking on the link for Record "1" and Survey "Participant Consent" in the File Repository table
    Then I should see the following values in the last file downloaded
      | PID 15 - LastNameS3 |
      | FirstName LastNameS3, 2000-01-01, Version: 1.0, Participant     |
      #Manual: Close document 
#VERIFY Confirm file exists in Amazon S3 Storage 
# FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Then I should see the following values in the most recent file in the Amazon S3 bucket
      | PID 15 - LastNameS3   |
      | FirstName LastNameS3, 2000-01-01, Version: 1.0, Participant |

  Scenario: A.3.28.0100.0400 – Configure Google Cloud Storage
# Supports GCS via API or App Engine configuration. Site must confirm file appears in the correct Google Cloud bucket. 
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Google Cloud Storage using API Service Account" on the dropdown field labeled "STORAGE LOCATION OF UPLOADED FILES"
    #Manual: These settings will only work for automation.  Manual testing will require an account specific to your site.
    And I enter "dummy-project" into the input field labeled "Google Cloud Platform project ID"
    And I enter "mybucket" into the input field labeled "Bucket name"
    And I enter "dummy secret" into the input field labeled "Secret"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    When I create a new project named "A.3.28.0100.0400" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastNameGCS" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "email"
    And I enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature" in the row labeled "Participant signature field"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Close survey"
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
      #VERIFY_RSD 
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid16_formParticipantConsent_id1_"
    Given I download the PDF by clicking on the link for Record "1" and Survey "Participant Consent" in the File Repository table
    Then I should see the following values in the last file downloaded
      | PID 16 - LastNameGCS |
      | FirstName LastNameGCS, 2000-01-01, Version: 1.0, Participant     |
      #Manual: Close document 
#VERIFY Confirm file exists in Google Cloud Storage 
# FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Then I should see the following values in the most recent file in the Google Cloud Storage bucket
      | PID 16 - LastNameGCS   |
      | FirstName LastNameGCS, 2000-01-01, Version: 1.0, Participant |

  Scenario: A.3.28.0100.0500 – Configure WebDAV Storage
# Uses a WebDAV-accessible path preconfigured on the REDCap server. Site must verify storage access and permissions. 
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "External server using WebDAV" on the dropdown field labeled "STORAGE LOCATION OF UPLOADED FILES"
    #Manual: These settings will only work for automation.  Manual testing will require an account specific to your site.
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    And I populate "webdav_connection.php" with the appropriate WebDAV credentials
    When I create a new project named "A.3.28.0100.0500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Then I enter "FirstName" into the input field labeled "First Name"
    And I enter "LastNameWebDAV" into the input field labeled "Last Name"
    And I enter "email@test.edu" into the input field labeled "email"
    And I enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature" in the row labeled "Participant signature field"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Close survey"
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
      #VERIFY_RSD 
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"
   #VERIFY_FiRe 
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid17_formParticipantConsent_id1_"
    Given I download the PDF by clicking on the link for Record "1" and Survey "Participant Consent" in the File Repository table
    Then I should see the following values in the last file downloaded
      | PID 17 - LastNameWebDAV |
      | FirstName LastNameWebDAV, 2000-01-01, Version: 1.0, Participant     |
      #Manual: Close document 
#VERIFY Confirm file exists in WebDAV storage location 
# FUNCTIONAL_REQUIREMENT: Files uploaded via REDCap actually land in the configured location (local or external) 
    Then I should see the following values in the most recent file in the WebDAV server
      | PID 17 - LastNameWebDAV |
      | FirstName LastNameWebDAV, 2000-01-01, Version: 1.0, Participant |

  Scenario: Stop external storage services
    Then if running via automation, stop external storage services
