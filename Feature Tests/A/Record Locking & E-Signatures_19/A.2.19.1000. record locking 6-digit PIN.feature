Feature: A.2.19.1000 PIN usage instead of password
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
        
#END

