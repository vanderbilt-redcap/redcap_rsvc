Feature: A.3.28.1600. Control Center: The system shall enforce the Restricted Upload File Types setting by validating the true (MIME) file type of uploaded files, regardless of the file's extension.

  As a REDCap administrator
  I want restricted upload settings to validate the real file type
  So that renamed files with misleading extensions are blocked

  Scenario: A.3.28.1600.0100.Allowed MIME type with allowed extension
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    #VERIFY: Allowed extension + true MIME type should upload successfully
    And I create a new project named "A.3.28.1600.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "select record"
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    Given I click on the link labeled "Upload file" in the row labeled "File Upload"
    When I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see "File was successfully uploaded"
    And I should see "testusers_bulkupload.csv" in the row labeled "File Upload"
    When I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 1 successfully edited."

  Scenario: A.3.28.1600.0200. Disallowed MIME type with allowed extension
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter ",csv" into the textarea field labeled "Restricted file types for uploaded files"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    When I create a new project named "A.3.28.1600.0200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "select record"
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    And I click on the link labeled "Upload file" in the row labeled "File Upload"
    When I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see "ERROR: The file cannot be uploaded because its file type is not permitted."
    And I wait for 2 seconds
    And I click on the button labeled "OK"
    And I click on the button labeled "Close"
    Then I should NOT see "testusers_bulkupload.csv" in the row labeled "File Upload"   

  Scenario: A.3.28.1600.0300. Enforce across upload locations (i.e. File Upload field, Alerts and Notification Attachment, File Repository, Data Resolution Workflow, Send-It)
    #SETUP: Configure controls used by all upload locations
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Enabled" on the dropdown field labeled "ENABLE FILE UPLOADING FOR THE FILE REPOSITORY MODULE"
    And I select "Enabled" on the dropdown field labeled "Allow file attachments to be uploaded for data queries in the Data Resolution Workflow"
    And I select "Enabled for all locations" on the dropdown field labeled "ENABLE SEND-IT"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #LOCATION 1: File Upload field
    And I create a new project named "A.3.28.1600.0300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "select record"
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    And I click on the link labeled "Upload file" in the row labeled "File Upload"
    And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see "ERROR: The file cannot be uploaded because its file type is not permitted."
    And I wait for 2 seconds
    And I click on the button labeled "OK"
    And I click on the button labeled "Close"
    Then I should NOT see "testusers_bulkupload.csv" in the row labeled "File Upload"   

    #LOCATION 2: File Repository
    When I click on the link labeled "File Repository"
    And I click the button labeled "Select files to upload" to select and upload "/import_files/testusers_bulkupload.csv" to File Repository and see that the upload failed
    Then I should see "Upload Error!"
    And I should see "File did not upload: testusers_bulkupload.csv"

    #LOCATION 3: Data Resolution Workflow attachment
    When I click on the link labeled "Setup"
    And I click on the button labeled "Additional customizations"
    And I select "Data Resolution Workflow" on the dropdown field labeled "Enable"
    And I click on the button labeled "Save"
    Then I should see "The Data Resolution Workflow has now been enabled!"

    When I click on the button labeled "Close"
    And I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "select record"
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
    And I click on the radio labeled "Open query"
    And I enter "MIME validation check" into the textarea field labeled "Comment"
    And I click on the button labeled "Open query"
    And I click on the link labeled "Resolve Issues"
    And I click on the button labeled "1 comment" in the row labeled "Name"
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Select a file then click the 'Upload File' button" to browse for the file
    And I click on the button labeled "Upload document"
    Then I should see "ERROR: The file cannot be uploaded because its file type is not permitted."
    And I click on the button labeled "OK"
    And I click on the button labeled "Cancel"
    Then I should NOT see "testusers_bulkupload.csv"
    And I click on the button labeled "Cancel"

    #LOCATION 4: Send-It
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Send-It"
    And I enter "test@user.com" into the textarea field labeled "To:"
    And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Select a file" to browse for the file
    Then I should see "ERROR: The file cannot be uploaded because its file type is not permitted."
    And I click on the button labeled "OK"
    Then I should NOT see "testusers_bulkupload.csv"

    #LOCATION 5: Alerts and Notifications attachment
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.1600.0300"
    And I click on the link labeled "Alerts & Notifications"
    And I click on the button labeled "Add New Alert"
    And I wait for 1 second
    And I click on the button labeled "Add attachment"
    And I should see "Message Attachments"
    And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Choose File" to browse for the file
    Then I should see "ERROR: The file cannot be uploaded because its file type is not permitted."
    And I click on the button labeled "OK"
    Then I should NOT see "testusers_bulkupload.csv"

#END
