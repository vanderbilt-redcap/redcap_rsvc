Feature: Control Center: The system shall provide the ability to enable/disable sharing of files via a public link.


  As a REDCap end user
  I want to see that file repository is functioning as expected

  Scenario: A.3.26.0100.100 Enable/Disable file repository public links via Control Center
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.3.26.0100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.26.0100.100"

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #ACTION Upload to top tier file repo (all users will see file) - using the Select files to upload button
    When I click on the link labeled "File Repository"
    Then I should see "All Files"

    When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
      | import_files/testusers_bulkupload.csv |

    When I click on the link labeled "File Repository"
    ##VERIFY file uploaded in folder
    Then I should see a table header and rows containing the following values in the file repository table:
      | Name                     | Time Uploaded    | Comments                |
      | Data Export Files        |                  |                         |
      | Recycle Bin              |                  |                         |
      | testusers_bulkupload.csv | mm/dd/yyyy hh:mm | Uploaded by test_admin. |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Disable File Repository Module
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    Then I should see "Configuration Options for Various Types of Stored Files"

    When I select "Disabled" on the dropdown field labeled "File Repository: Users are able to share files via public links"
    And I click on the button labeled "Save Changes"

    ##VERIFY File Repository Module Disabled
    Then I should see "Your system configuration values have now been changed!"
    ##VERIFY Project settings share ability in File Repository
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.26.0100.100"
    When I click on the link labeled "File Repository"

    Given I click on the icon in the column labeled "Share" and the row labeled "testusers_bulkupload.csv"
    Then I should see "Send the file securely using Send-It"
    And I should NOT see "Share a public link to view the file" in the dialog box
    And I click on the button labeled "Close" in the dialog box

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Enable File Repository Module
    When I click on the link labeled "Control Center"
    And I click on the link labeled "File Upload Settings"
    And I select "Enabled" on the dropdown field labeled "File Repository: Users are able to share files via public links"
    And I click on the button labeled "Save Changes"

    ##VERIFY File Repository Module Enabled
    Then I should see "Your system configuration values have now been changed!"
    ##VERIFY Project settings shareability in File Repository
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.26.0100.100"
    And I click on the link labeled "File Repository"

    Given I click on the icon in the column labeled "Share" and the row labeled "testusers_bulkupload.csv"
    Then I should see "Send the file securely using Send-It"
    And I should see "Share a public link to view the file"
    And I click on the button labeled "Close" in the dialog box
#End