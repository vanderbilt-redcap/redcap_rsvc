Feature: Control Center: The system shall allow administrators to configure the availability and maximum file size of ‘File Upload’ fields used in forms and surveys.

  As a REDCap administrator
  I want to manage the behavior of 'File Upload' fields globally
  So that I can control their availability and file size limits

  Scenario: A.3.28.0300.100 Disable 'File Upload' field type globally
    #SETUP
    Given I login to REDCap with the user "Test_Admin"

    #ACTION: Disable File Upload fields
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Disabled" on the dropdown field labeled "ENABLE 'FILE UPLOAD' FIELD TYPES"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Existing fields no longer functional
    And I create a new project named "A.3.28.0300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "Designer"
    When I click on the link labeled "Data Types"
    Then I should see "The file upload feature is disabled" in the row labeled "File Upload"

  Scenario: A.3.28.0300.200 Enable 'File Upload' field type globally
    #ACTION: Enable File Upload fields
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Enabled" on the dropdown field labeled "ENABLE 'FILE UPLOAD' FIELD TYPES"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Existing fields functional again
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.0300"
    And I click on the link labeled "Designer"
    When I click on the link labeled "Data Types"
    Then I should see "Upload file" in the row labeled "File Upload"

  Scenario: A.3.28.0300.300 Enforce max file size for 'File Upload' fields
    #SETUP: Set small file size limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter "1" into the field labeled "Upload max file size for 'file' field types on forms/surveys"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Large file upload blocked
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.0300"
    Given I click on the link labeled "Add / Edit Records"
    Given I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    Given I click on the link labeled "Upload file" in the row labeled "File Upload"
    When I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_new.csv", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see an alert box with the following text: "thus exceeding the maximum file size limit of 1 MB"
    Then I should see "There was an error during file upload"
    Then I click on the button labeled "Close" 

    #VERIFY: Small file upload succeeds
    Given I click on the link labeled "Upload file" in the row labeled "File Upload"
    When I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see "File was successfully uploaded"
    #Manual: Wait for the dialog to close on its own after a few seconds
    Then I should see "testusers_bulkupload.csv" in the row labeled "File Upload"