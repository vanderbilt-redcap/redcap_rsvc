Feature: C.3.30.0200 User Interface: The system shall allow enabling/disabling Randomization at the project level.
  As a REDCap end user I want to see that Randomization is functioning as expected

  Scenario: #SETUP project
     #SETUP project with no randomization enabled
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.0200." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
     #SETUP User Rights
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Assign to role" on the tooltip
    And I select "1_FullRights" on the dropdown field labeled "Select Role"
    And I click on the button labeled exactly "Assign"
    Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

  Scenario: C.3.30.0200.0100. Enabling adds randomization module to project setup.
    When I click on the link labeled "Setup"
    And I click on the button labeled "Enable" in the row labeled "Randomization module"
     ##VERIFY Enabling adds randomization module to project setup.
    And I should see a button labeled "Disable" in the row labeled "Randomization module"
    And I should see "Set up a randomization model"

     #VERIFY _log Enabling adds randomization module to project setup.
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Modify project settings                 |

  Scenario: C.3.30.0200.0200. Enabling adds randomization module to application box
    When I click on the link labeled "Setup"
    Then I should see a button labeled "Set up randomization"

     #VERIFY Enabling adds randomization module to application box
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Modify project settings                 |

  Scenario: C.3.30.0200.0300. Enabling adds randomization module options Setup, Dashboard, and Randomize to user rights privilege setup page.
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1" 
    And I click on the button labeled "Remove from role"
    And I click on the button labeled "Close" in the dialog box
    And I click on the link labeled "Test User1" 
    And I click on the button labeled "Edit user privileges"
    Then I should see "Randomization"
    And I should see "Setup"
    And I should see "Dashboard"
    And I should see "Randomize"
    And I click on the button labeled "Cancel" on the dialog box

  Scenario: C.3.30.0200.0400. Disabling removes randomization module from project setup
    When I click on the link labeled "Setup"
    Then I should see a button labeled "Disable" in the row labeled "Randomization module"
    When I click on the button labeled "Disable" in the row labeled "Randomization module"
     #VERIFY Disabling removes randomization module from project setup
    Then I should see a button labeled "Enable" in the row labeled "Randomization module"
    And I should NOT see "Set up a randomization model" 
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Modify project settings                 |

  Scenario: C.3.30.0200.0500. Disabling removes randomization module from application box.
    When I click on the link labeled "Setup"
    Then I should see a button labeled "Enable" in the row labeled "Randomization module"
     #VERIFY Disabling removes randomization module from application box.
    And I should NOT see a link labeled "Randomization"
    And I should NOT see "Set up a randomization model"

  Scenario: C.3.30.0200.0600. Disabling removes randomization module options Setup, Dashboard, and Randomize to user rights privilege setup page.
    When I click on the link labeled "User Rights"
    And I click on the link labeled "1_FullRights"
     #VERIFY options Setup, Dashboard, and Randomize NOT in user rights privilege setup page.
    Then I should NOT see "Randomization"
    And I should NOT see a checkbox labeled "Setup"
    And I should NOT see a checkbox labeled "Dashboard"
    And I should NOT see a checkbox labeled "Randomize"
    And I click on the button labeled "Cancel" on the dialog box
    And I logout
#END
