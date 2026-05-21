Feature: A.3.28.1600. Control Center: The system shall enforce the Restricted Upload File Types setting by validating the true (MIME) file type of uploaded files, regardless of the file's extension.

  As a REDCap administrator
  I want restricted upload settings to validate the real file type
  So that renamed files with misleading extensions are blocked

  Scenario: #SETUP
    Given I login to REDCap with the user "Test_Admin"

    #ACTION: Configure restricted upload types and keep File Upload enabled
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter ",csv" into the textarea field labeled "Restricted file types for uploaded files"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    
Scenario: A.3.28.1600.100 Enforce MIME validation when extension appears allowed
    #VERIFY: MIME type is enforced
    When I create a new project named "A.3.28.1600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "select record"
    And I click on the icon in the column labeled "Event 1" and the row labeled "Data Types"
    Given I click on the link labeled "Upload file" in the row labeled "File Upload"
    When I upload a "csv" format file located at "import_files/ACG_DownloadedGroups.csv", by clicking the button near "Upload file" to browse for the file, and clicking the button labeled "Upload file" to upload the file
    Then I should see "ERROR: The file cannot be uploaded because its file type is not permitted."
    And I wait for 2 seconds
    And I click on the button labeled "OK"
    And I click on the button labeled "Close"
    Then I should NOT see "ACG_DownloadedGroups.csv" in the row labeled "File Upload"    
#END
