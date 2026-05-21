Feature: B.2.6.0600. User Interface: The system shall support instrument level delete privileges.

  As a REDCap end user
  I want to see that instrument level delete privileges is functioning as expected.

  Scenario: #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.6.0600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    When I click on the link labeled "User Rights"
    And I click on the button labeled "Upload or download users, roles, and assignments"
    Then I should see "Upload users (CSV)"

    When I click on the link labeled "Upload users (CSV)"
    Then I should see "Upload users (CSV)"

    Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Displayed below is a preview of all the changes you are about to commit."

    Given I click on the button labeled "Upload"
    Then I should see "SUCCESS!"
    ##ACTION: Configure instrument-level delete privilege
    When I click on the button labeled "Close"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges"
    Then I should see a "Editing existing user"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Configure instrument-level delete privilege
    When I uncheck the User Right named "Delete Records"
    Then I should see "The Delete right has been cleared for all forms"

    When I click on the button labeled "Close"
    And I click on the button labeled "Save Changes"
    Then I should see 'User "test_user1" was successfully edited'

    Given I logout
    And I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.0600"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Consent" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should NOT see a button labeled "Delete data for THIS FORM only"

    Given I logout
    And I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.0600"
    And I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges"
    Then I should see "Editing existing user"

Scenario: B.2.6.0600. User Interface: The system shall support instrument level delete privileges.
    #FUNCTIONAL REQUIREMENT
    ##ACTION: Configure instrument-level delete privilege
    When I check the checkbox in the column labeled "Delete" and the row labeled "Consent"
    And I click on the button labeled "Save Changes"
    Then I should see 'User "test_user1" was successfully edited'

    ##VERIFY_LOG: Verify Update user rights
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action      | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Update user | user = 'test_user1'                     |

    ##VERIFY: test_user1 can delete an individual consent form
    Given I logout
    And I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.0600"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Consent" instrument on event "Event 1" for record ID "1" and click on the bubble
    Then I should see a button labeled "Delete data for THIS FORM only"

    When I click on the button labeled "Delete data for THIS FORM only"
    Then I should see 'DELETE ALL DATA ON THIS FORM FOR RECORD "1"?'

    When I click on the button labeled "Delete data for THIS FORM only"
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action       | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Update record 1 | consent_complete = '', dob = '', email_consent = '', name_consent = ''| 
#End