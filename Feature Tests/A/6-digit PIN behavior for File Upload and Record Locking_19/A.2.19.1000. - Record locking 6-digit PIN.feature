Feature: A.2.19.1000. Control Center: The system shall support enabling or disabling of  allowing users to provide their 6-digit PIN only once per session.
    #Integrated Part 11 Validation – 6-digit PIN behavior for File Upload and Record Locking
        As a REDCap administrator
        I want to verify Control Center, project-level, and UI behavior for PIN-verified actions
        So that REDCap correctly supports Part 11 compliance across sessions and file destinations

    Scenario: #Setup Create project
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.2.19.1000" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

    Scenario: A.2.19.1000.0100. Disable Security & Authentication Configuration – Password only   
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Modules/Services Configuration"
        And I select "Enabled using SFTP" on the dropdown field labeled "Enable this system-level setting for password verification for File Upload fields AND enable the external storage device?"
        And I select "Enabled using SFTP" on the dropdown field labeled "Enable the external storage device and choose storage method (SFTP, WebDAV, Azure, S3):"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        When I click on the link labeled "Security & Authentication"
        Then I should see "Security & Authentication Configuration"
        And I select "Disable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"
        
    #Verify project-level options are still visible
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.19.1000"
        When I click on the button labeled "Additional customizations"
        Then I should see "Enable 'File Upload' field enhancement: Password verification & automatic external file storage"
        When I check the checkbox labeled "Enable 'File Upload' field enhancement: Password verification & automatic external file storage"
        And I click on the button labeled "Save" 
        Then I should see "Success! Your changes have been saved."

        Given I click on the link labeled "Add / Edit Records"
        And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        Then I should see "Editing existing Record ID 1"
        When I click on the link labeled "Upload file" in the row labeled "File Upload"
        And I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_new.csv", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
        Then I should see "By providing your REDCap password and clicking the Confirm button below, you are confirming that the following file is the correct file that you wish to upload here:" 
        And I should see "Your file will be uploaded once you successfully initiate this confirmation process"
        And I should see "Username"
        And I should see "Password"
        When I enter "Testing123" into the input field labeled "Password:"
        And I click on the button labeled "Confirm" 
        And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        Then I should see "Record ID 1 successfully edited."

    Scenario: A.2.19.1000.0200. Enable Security & Authentication Configuration – PIN instead of password
    #Enable 6-digit PIN setting
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Security & Authentication"
        Then I should see "Security & Authentication Configuration"
        When I select "Enable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    #Verify PIN is new method 
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.19.1000"
        And I click on the link labeled "Add / Edit Records"
        When I click on the button labeled "Add new record for the arm selected above"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
        Then I should see "Adding new Record ID 5"
        When I click on the link labeled "Upload file" in the row labeled "File Upload"
        And I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_new.csv", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
        Then I should see "By providing your REDCap password and clicking the Confirm button below, you are confirming that the following file is the correct file that you wish to upload here:" 
        And I should see "Your file will be uploaded once you successfully initiate this confirmation process"
        And I should see "Username"
    #Manual Steps until Cypress can be updated for authentication
        #And I should see "Password or 6-digit PIN"
        #When I click on the button labeled "Obtain PIN via SMS"
        # OR
        #When I click on the button labeled "Obtain PIN via email"
        #Then I should recieve a 6-digit PIN via SMS or email
        #When I enter the 6-digit PIN into the input field labeled "Password or 6-digit PIN"
        #And I click on the button labeled "Confirm" 
        #And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
        #Then I should see "Record ID 5 successfully added"
        
# REQUIREMENTS VERIFIED: These tests should be redundent via the test above. 
# A.2.19.1000 – Enable/disable PIN usage instead of password
# A.2.19.1100 – Enable/disable PIN once-per-session
# A.3.28.1100 – Configure File Upload Enhancement with external storage
# A.3.28.1200 – Configure Record Locking Enhancement with external storage
# A.3.28.1300 – Configure e-Consent PDF external storage
# C.2.19.1200 – Provide 6-digit PIN once per session for File Upload field enhancement
# C.2.19.1300 – Provide 6-digit PIN once per session for Record-locking processes
# C.2.19.1400 – Project-level option: Record Locking PDF enhancement for external storage
# C.3.28.1400 – Project-level option: File Upload field enhancement with password-verified uploads
# C.3.28.1500 – Project-level option: Record Locking PDF enhancement for external storage

        # #IMPLEMENTATION NOTE: This scenario uses Microsoft Azure Blob Storage for external storage validation. Sites may substitute Amazon S3 or GCS as appropriate.

        # # Full Part 11 Integrated Test – PIN Configuration, Uploads, Locking, and Session Validation
        # Scenario: Enable all system and project-level settings

        # #M Enable all required Control Center settings to support 6-digit PIN usage and Part 11 File/Lock enhancements
        # Given I login to REDCap with the user "Test_Admin"
        # And I click on the link labeled "Control Center"

        # #VERIFIES: A.2.19.1100
        # When I click on the link labeled "Security & Authentication"
        # Then I should see "Security & Authentication"

        # And I select "Enable" on the dropdown field labeled "When e-signing, allow users to provide their 6-digit PIN only once per session."
        # And I click on the button labeled "Save Changes"
        # Then I should see "Your system configuration values have now been changed!"

        # #VERIFIES: A.3.28.1100
        # #M Configure File Upload field enhancement with Password verification to external storage (Azure Blob Storage)
        # When I click on the link labeled "File Upload Settings"
        # Then I should see "Microsoft Azure Blob Storage"

        # And I enter "staeusp11prod01" into the input field labeled "Azure storage account name:"
        # And I enter "xxx" into the input field labeled "Azure storage account key"
        # And I click on the button labeled "Save Changes"
        # Then I should see "Your system configuration values have now been changed"

        # #VERIFIES: A.3.28.1200, A.3.28.1300
        # #M Enable File Vault for File Uploads and Record Locking with password verification and external storage
        # When I click on the link labeled "Modules/Services Configuration"
        # Then I should see "Enable this system-level setting for password verification" for the section labeled "'File Upload' field enhancement: Password verification & automatic external file storage"

        # And I select "Microsoft Azure Blob Storage"
        # And I enter "redcap-part11" into the field labeled Azure/S3-only settings"
        # And I click on the button labeled "Save Changes"
        # Then I should see "Your system configuration values have now been changed"

        # #M Create project with necessary modules enabled
        # Given I create a new project named "xxxxxxxxx" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project1.xml", and clicking the "Create Project" button

        # #VERIFIES: C.3.28.1400, C.2.19.1400, C.3.28.1500
        # #M Enable project-level File Upload and Record Locking enhancements
        # When I click on the button labeled "Additional Customizations"
        # And I enable "File Version History for File Upload Fields"
        # And I enable "File Upload field enhancement: Password verification & automatic external file storage"
        # And I enable "Require a 'reason' when making changes to existing records?"
        # And I enable "Record Locking PDF enhancement for external storage"
        # And I click the button labeled "Save"
        # Then I should see "Success"

        # Scenario: Create Record 1 – Session should reuse PIN
        # #SETUP
        # When I click on the link labeled "Add/Edit Records"
        # And I click on the button labeled "Add new record for the arm selected above"
        # And I click on the bubble labeled "Data Types" for event "Event 1"
        # Then I should see "Adding new Record ID 1"

        # # First file upload - should prompt for PIN
        # #VERIFIES: C.2.19.1200
        # When I click on the link labeled "File Upload" in the dialog box
        # And I click the button labeled "Choose File"
        # And I select "doc1.pdf"
        # And I click the button labeled "Upload"
        # And I enter "My 6-digit PIN"
        # And I click the button labeled "Confirm"
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc1.pdf"

        # # Second file upload - should NOT prompt again
        # When I click the button labeled "Choose File"
        # And I select "doc2.pdf"
        # And I click the button labeled "Upload"
        # #M PIN should not be requested again in same session
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc2.pdf"

        # # Locking form - should prompt again
        # #VERIFIES: C.2.19.1300
        # When I click on the link labeled "Lock/Unlock"
        # And I lock the "Data Types" form for record "1"
        # And I enter "My 6-digit PIN"
        # And I confirm the locking action
        # Then I should see "Form successfully locked"

        # # Locking record - should result in PDF upload to external storage
        # #VERIFIES: A.3.28.1200
        # When I click on the button labeled "Lock Entire Record"
        # And I enter "Reason for lock"
        # And I enter "My 6-digit PIN"
        # And I confirm the locking action
        # Then I should see "Record successfully locked"
        # #M Site Admin must confirm PDF landed in external storage

        # Scenario: Create Record 2 – Still same session, reuse PIN
        # #SETUP
        # When I click on the button labeled "Add new record for the arm selected above"
        # And I click on the bubble labeled "Data Types" for event "Event 1"
        # Then I should see "Adding new Record ID 2"

        # # First file upload – should prompt for PIN
        # #VERIFIES: C.2.19.1200
        # When I click on the link labeled "File Upload" in the dialog box
        # And I click the button labeled "Choose File"
        # And I select "doc3.pdf"
        # And I click the button labeled "Upload"
        # And I enter "My 6-digit PIN"
        # And I click the button labeled "Confirm"
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc3.pdf"

        # # Second file upload – should NOT prompt again
        # When I click the button labeled "Choose File"
        # And I select "doc4.pdf"
        # And I click the button labeled "Upload"
        # #M PIN should not be requested again in same session
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc4.pdf"

        # # Locking form – should NOT prompt again
        # #VERIFIES: C.2.19.1300
        # When I click on the link labeled "Lock/Unlock"
        # And I lock the "Data Types" form for record "2"
        # #M PIN should not be requested again in same session
        # Then I should see "Form successfully locked"

        # # Locking record – should upload external PDF
        # #VERIFIES: A.3.28.1200
        # When I click on the button labeled "Lock Entire Record"
        # And I enter "Reason for lock"
        # #M Should NOT request PIN again
        # And I confirm the locking action
        # Then I should see "Record successfully locked"
        # #M Site Admin must confirm PDF landed in external storage

        # Scenario: Log out and Create Record 3 – New session should require PIN again

        # #M End current session and begin a new one
        # When I log out
        # Then I should see "You have been logged out"

        # Given I login to REDCap with the user "Test_Admin"
        # And I open the project named "PIN Behavior Test Project"

        # #SETUP
        # When I click on the link labeled "Add/Edit Records"
        # And I click on the button labeled "Add new record for the arm selected above"
        # And I click on the bubble labeled "Data Types" for event "Event 1"
        # Then I should see "Adding new Record ID 3"

        # # First file upload – should prompt for PIN again
        # #VERIFIES: C.2.19.1200
        # When I click on the link labeled "File Upload" in the dialog box
        # And I click the button labeled "Choose File"
        # And I select "doc5.pdf"
        # And I click the button labeled "Upload"
        # And I enter "My 6-digit PIN"
        # And I click the button labeled "Confirm"
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc5.pdf"

        # # Second file upload – should NOT prompt again
        # When I click the button labeled "Choose File"
        # And I select "doc6.pdf"
        # And I click the button labeled "Upload"
        # #M PIN should not be requested again in this session
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc6.pdf"

        # # Locking form – should prompt again (new session)
        # #VERIFIES: C.2.19.1300
        # When I click on the link labeled "Lock/Unlock"
        # And I lock the "Data Types" form for record "3"
        # And I enter "My 6-digit PIN"
        # And I confirm the locking action
        # Then I should see "Form successfully locked"

        # # Locking record – should upload external PDF
        # #VERIFIES: A.3.28.1200
        # When I click on the button labeled "Lock Entire Record"
        # And I enter "Reason for lock"
        # And I enter "My 6-digit PIN"
        # And I confirm the locking action
        # Then I should see "Record successfully locked"
        # #M Site Admin must confirm PDF landed in external storage

        # Scenario: Disable once-per-session behavior → Create Record 4
        # #M Disable once-per-session PIN rule
        # #VERIFIES: A.2.19.1100
        # When I navigate to the "Control Center"
        # And I click on the link labeled "Security & Authentication"
        # Then I should see "Security & Authentication"

        # And I select "Disable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
        # And I click on the button labeled "Save Changes"
        # Then I should see "Your system configuration values have now been changed!"

        # # Return to project and add a new record
        # Given I open the project named "PIN Behavior Test Project"
        # When I click on the link labeled "Add/Edit Records"
        # And I click on the button labeled "Add new record for the arm selected above"
        # And I click on the bubble labeled "Data Types" for event "Event 1"
        # Then I should see "Adding new Record ID 4"

        # # First file upload – should prompt for PIN
        # #VERIFIES: C.2.19.1200
        # When I click on the link labeled "File Upload" in the dialog box
        # And I click the button labeled "Choose File"
        # And I select "doc7.pdf"
        # And I click the button labeled "Upload"
        # And I enter "My 6-digit PIN"
        # And I click the button labeled "Confirm"
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc7.pdf"

        # # Second file upload – should prompt again (now that one-time PIN is disabled)
        # When I click the button labeled "Choose File"
        # And I select "doc8.pdf"
        # And I click the button labeled "Upload"
        # #M PIN should be requested again, since one-time PIN is disabled
        # And I enter "My 6-digit PIN"
        # And I click the button labeled "Confirm"
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc8.pdf"

        # # Locking form – should prompt again
        # #VERIFIES: C.2.19.1300
        # When I click on the link labeled "Lock/Unlock"
        # And I lock the "Data Types" form for record "4"
        # And I enter "My 6-digit PIN"
        # And I confirm the locking action
        # Then I should see "Form successfully locked"

        # # Locking record – should upload external PDF
        # #VERIFIES: A.3.28.1200
        # When I click on the button labeled "Lock Entire Record"
        # And I enter "Reason for lock"
        # And I enter "My 6-digit PIN"
        # And I confirm the locking action
        # Then I should see "Record successfully locked"
        # #M Site Admin must confirm PDF landed in external storage
        # Scenario: Disable PIN Authentication → Create Record 5

        # #M Disable system-level PIN authentication
        # #VERIFIES: A.2.19.1000
        # When I navigate to the "Control Center"
        # And I click on the link labeled "Security & Authentication"
        # Then I should see "Security & Authentication"

        # And I select "Disable" on the dropdown field labeled "Allow users to e-sign using their Two-Factor Authentication 6-digit PIN in place of their password."
        # And I click on the button labeled "Save Changes"
        # Then I should see "Your system configuration values have now been changed!"

        # # Return to project and verify project-level options are still visible
        # Given I open the project named "PIN Behavior Test Project"
        # When I click on the button labeled "Additional Customizations"
        # Then I should see that "File Upload' field enhancement: Password verification & automatic external file storage" is enabled
        # And I should see that "Record Locking PDF enhancement for external storage" is enabled
        # #VERIFIES: C.3.28.1400, C.3.28.1500

        # # Add 5th record – no PINs required for any action
        # When I click on the link labeled "Add/Edit Records"
        # And I click on the button labeled "Add new record for the arm selected above"
        # And I click on the bubble labeled "Data Types" for event "Event 1"
        # Then I should see "Adding new Record ID 5"

        # # File upload – no PIN should be prompted
        # When I click on the link labeled "File Upload" in the dialog box
        # And I click the button labeled "Choose File"
        # And I select "doc9.pdf"
        # And I click the button labeled "Upload"
        # #M PIN prompt should not appear when setting is disabled
        # And I click the button labeled "Upload file"
        # Then I should see "File successfully uploaded"
        # And I should see "doc9.pdf"

        # # Locking form – no PIN prompt
        # When I click on the link labeled "Lock/Unlock"
        # And I lock the "Data Types" form for record "5"
        # #M PIN prompt should not appear
        # Then I should see "Form successfully locked"

        # # Locking record – PDF should still upload externally
        # #VERIFIES: A.3.28.1200
        # When I click on the button labeled "Lock Entire Record"
        # And I enter "Reason for lock"
        # #M PIN prompt should not appear
        # And I confirm the locking action
        # Then I should see "Record successfully locked"
        # #M Site Admin must confirm PDF landed in external storage
        # Scenario: Confirm Logging, File Repository, and External Storage

        # #VERIFY_LOGGING
        # When I click on the link labeled "Logging"
        # Then I should see a table header and rows containing the following values:
        # | Time / Date      | Username   | Action          | List of Data Changes OR Fields Exported                              |
        # | mm/dd/yyyy hh:mm | test_admin | Update record X | Document upload was confirmed with password (field = 'file_upload') |

        # #VERIFY_REPOSITORY
        # When I click on the link labeled "File Repository"
        # And I click on the link labeled "PDF Snapshot Archive"
        # Then I should see filenames like:
        # | pid*_form*DataTypes_id*_ |  #M Match actual record IDs used
        # | pdf |
        
        #VERIFY_EXTERNAL_STORAGE
        #M Manual verification required:
        #M Site administrator should confirm that uploaded PDFs and files for records 1–5 were stored in the configured external storage solution (e.g., Azure Blob Storage).

        #IMPLEMENTATION NOTE:
        # The test covers the following requirements via automated and manual checks:
        # A.2.19.1000, A.2.19.1100
        # A.3.28.1100, A.3.28.1200, A.3.28.1300
        # C.2.19.1200, C.2.19.1300, C.2.19.1400
        # C.3.28.1400, C.3.28.1500
#END

