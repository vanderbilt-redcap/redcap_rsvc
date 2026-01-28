Feature: Control Center: The system shall allow administrators to configure upload behavior for Send-It, including enabling/disabling the feature and enforcing file size limits.

  As a REDCap administrator
  I want to control Send-It upload availability and limits
  So that I can ensure secure file transfers comply with institutional policies

  Scenario: A.3.28.0400.100 Disable Send-It uploads globally
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I should see a link labeled "Send-It"
    And I select "Disabled" on the dropdown field labeled "ENABLE SEND-IT"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    And I click on the link labeled "File Upload Settings"
    And I should NOT see a link labeled "Send-It"

  Scenario: A.3.28.0400.200 Enable Send-It uploads
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Enabled for all locations" on the dropdown field labeled "ENABLE SEND-IT"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    Given I click on the link labeled "File Upload Settings"
    When I click on the link labeled "Send-It"
    Then I should see "Send-It is a secure data transfer application"

  Scenario: A.3.28.0400.300 Block large Send-It file uploads over limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    When I enter "1" into the field labeled "Send-It upload max file size"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    When I click on the link labeled "Send-It"
    And I enter "test@user.com" into the input field labeled "To:"
    And I upload a "csv" format file located at "import_files/RandomizationAllocationTemplate_new.csv", by clicking the button near "Select a file" to browse for the file
    And I should see "The file you are attempting to upload is too large"
    And I click on the button labeled "Close"

  Scenario: A.3.28.0400.400 Allow Send-It upload below size limit
    Given I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Select a file" to browse for the file
    And I click on the button labeled "Send It!"
    Then I should see "File successfully uploaded"