Feature: User Interface: The system shall not allow data to be changed on locked data entry forms.

  As a REDCap end user
  I want to see that Data import is functioning as expected

  Scenario: B.3.16.0900.100 Limit import to unlocked record forms

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.3.16.0900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    ##ACTION: Import data
    When I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files/B.3.16.900.100_ImportChangedUnlocked.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see a table header and rows containing the following values in a table:
      | record_id | name |
      | 1         | Name |

    When I click on the button labeled "Import Data"
    Then I should see "Import Successful!"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: lock record 1
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "1"
    #And I select the dropdown option labeled "Lock entire record" for the dropdown field labeled "Choose action for record"
    When I click on the button labeled "Choose action for record"
    And I click on the link labeled "Lock entire record"
    And I click on the button labeled "Lock entire record" on the dialog box
    Then I should see a dialog containing the following text: 'Record "1" is now LOCKED'
    # The previous step should likely wait for the page to refresh to prevent interference with the link click below.  For now, we wait:
    And I wait for 10 seconds

    #VERIFY_DI
    When I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files/B.3.16.900.100_ImportChangedLocked.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see a table header and rows containing the following values in a table:
      | Record | Field Name               | Error Message                                                                                 |
      | 1      | text_validation_complete | This record has been locked at the record level. No value within this record can be modified. |

    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      #Manual: should not see anything was imported after record was locked
      | Username   | Action               | List of Data Changes      |
      | test_admin | Lock/Unlock Record 1 | Action Lock entire record |
#End