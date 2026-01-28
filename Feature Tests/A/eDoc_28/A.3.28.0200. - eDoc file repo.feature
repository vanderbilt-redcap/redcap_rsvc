Feature: Control Center: The system shall allow administrators to configure the File Repository, including upload permissions, file size and storage limits, and public link sharing (tested in A.3.26.0100.100).

  As a REDCap administrator
  I want to control the upload behavior and limits of the File Repository module
  So that I can enforce institutional data storage policies

  # NOTE: Public link behavior is tested in A.3.26.0100.100 and not re-tested here.

  Scenario: A.3.28.0200.100 Disable manual uploads to the File Repository
    #SETUP
    Given I login to REDCap with the user "Test_Admin"

    #ACTION: Disable File Repository
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Disabled" on the dropdown field labeled "ENABLE FILE UPLOADING FOR THE FILE REPOSITORY MODULE"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Upload interface not visible
    And I create a new project named "A.3.28.0200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "File Repository"
    Then I should NOT see the button labeled "Select files to upload"

  Scenario: A.3.28.0200.200 Enable manual uploads to the File Repository
    #ACTION: Enable File Repository
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Enabled" on the dropdown field labeled "ENABLE FILE UPLOADING FOR THE FILE REPOSITORY MODULE"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Upload interface is visible and functional
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.0200"
    When I click on the link labeled "File Repository"
    Then I should see the button labeled "Select files to upload"
    When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
      | /import_files/testusers_bulkupload.csv |
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name                        | Time Uploaded    | Comments                |
      | testusers_bulkupload.csv    | mm/dd/yyyy hh:mm | Uploaded by test_admin. |

  Scenario: A.3.28.0200.300 Enforce max file size for uploads to File Repository
    #SETUP: Set small file size limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter "1" into the field labeled "File Repository upload max file size"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #VERIFY: Blocked upload for large file
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.0200"
    When I click on the link labeled "File Repository"
    When I click the button labeled "Select files to upload" to select and upload "/import_files/RandomizationAllocationTemplate_new.csv" to File Repository and see that the upload failed
    Then I should see "File could not be loaded because it is too large"

    #VERIFY: Successful upload for small file
    When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
      | /import_files/testusers_bulkupload.csv |
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name                         | Time Uploaded    | Comments                |
      | testusers_bulkupload (1).csv             | mm/dd/yyyy hh:mm | Uploaded by test_admin. |

  Scenario: A.3.28.0200.400 Enforce per-project storage limit
    #SETUP: Set low project storage limit
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I enter "2" into the field labeled "File Repository: File storage limit (in MB) for all projects"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #ACTION: Upload until limit reached
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.28.0200"
    When I click on the link labeled "File Repository"
    When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
      | /import_files/BigDataTestProjectDATA2100.csv |
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name                               | Time Uploaded    | Comments                |
      | BigDataTestProjectDATA2100.csv     | mm/dd/yyyy hh:mm | Uploaded by test_admin. |
    When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
      | /import_files/BigDataTestProjectDATA2100.csv |
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name                               | Time Uploaded    | Comments                |
      | BigDataTestProjectDATA2100 (1).csv | mm/dd/yyyy hh:mm | Uploaded by test_admin. |
    
    #VERIFY: Upload blocked beyond limit
    When I click the button labeled "Select files to upload" to select and upload "/import_files/BigDataTestProjectDATA2100.csv" to File Repository and see that the upload failed
    Then I should see "You can not upload the file because doing so will exceed the project storage limit"
