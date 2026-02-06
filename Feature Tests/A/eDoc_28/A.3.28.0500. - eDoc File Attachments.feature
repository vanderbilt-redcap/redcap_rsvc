Feature: Control Center: The system shall allow administrators to configure upload behavior for general attachments used in Descriptive fields and Data Resolution Workflow (DRW).

  As a REDCap administrator
  I want to manage upload permissions and file size limits for general attachments
  So that I can ensure appropriate file handling in descriptive content and query responses

  Scenario: A.3.28.0500.100 Disable general file attachments
    #SETUP
    Given I login to REDCap with the user "Test_Admin"

    #ACTION: Disable general attachments
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    When I select "Disabled" on the dropdown field labeled "Allow file attachments to be uploaded for data queries in the Data Resolution Workflow"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Upload blocked in DRW
    And I create a new project named "A.3.28.0500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    And I click on the button labeled "Additional customizations"
    When I select "Data Resolution Workflow" on the dropdown field labeled "Enable the Field Comment Log or Data Resolution Workflow"
    And I click on the button labeled "Save"
    And I click on the button labeled "Close"
    
    Given I click on the link labeled "Add / Edit Records"
    Given I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    And I click on the icon labeled "View data resolution workflow" in the row labeled "Name"
    And I click on the radio labeled "Open query"
    And I enter "My comment" into the textarea field labeled "Comment"
    And I click on the button labeled "Open query"
    And I should NOT see "This pop-up displays the Data Resolution Workflow"
    And I click on the link labeled "Resolve Issues"
    And I click on the button labeled "1 comment" in the row labeled "Name"
    Then I should NOT see a link labeled "Upload file"
    And I click on the button labeled "Cancel"

  Scenario: A.3.28.0500.200 Enable general file attachments with file size limit
    #SETUP: Enable with limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter "1" into the field labeled "Upload max file size for general file attachments"
    When I select "Enabled" on the dropdown field labeled "Allow file attachments to be uploaded for data queries in the Data Resolution Workflow"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Successful upload in Descriptive field
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.0500"
    And I click on the link labeled "Designer"
    And I click on the link labeled "Data Types"
    And I click on the Edit image for the field named "Descriptive Text with File"
    And I should see "Attach an image, file, or embedded audio"
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Select a file then click the 'Upload File' button" to browse for the file
    And I click on the button labeled "Upload file"
    And I should see "Document was successfully uploaded"
    And I click on the button labeled "Close"
    And I should see "testusers_bulkupload.csv"

    #VERIFY: Upload fails if file exceeds limit
    And I click on the link labeled "Remove"
    And I click on the button labeled "Delete"
    And I wait for 3 seconds
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_new.csv", by clicking the button near "Select a file then click the 'Upload File' button" to browse for the file
    And I click on the button labeled "Upload file"
    And I should see an alert box with the following text: "thus exceeding the maximum file size limit of 1 MB"
    And I should see "There was an error uploading your file."
    And I click on the button labeled "Close"
    And I click on the button labeled "Cancel"


    #VERIFY: Upload and fail in DRW
    And I click on the link labeled "Resolve Issues"
    And I click on the button labeled "1 comment" in the row labeled "Name"
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_new.csv", by clicking the button near "Select a file then click the 'Upload File' button" to browse for the file
    And I click on the button labeled "Upload document"
    And I should see an alert box with the following text: "thus exceeding the maximum file size limit of 1 MB"
    And I should see "There was an error during file upload"
    And I click on the button labeled "Close"

    #VERIFY: Upload and view in DRW
    And I click on the link labeled "Upload file"
    And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Select a file then click the 'Upload File' button" to browse for the file
    And I click on the button labeled "Upload document"
    And I should see "Document was successfully uploaded"
    And I click on the button labeled "Close"
    And I should see "testusers_bulkupload.csv"

#END
