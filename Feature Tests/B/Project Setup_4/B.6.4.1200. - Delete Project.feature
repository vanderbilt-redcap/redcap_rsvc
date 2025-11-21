Feature: User Interface: General: The system shall support the ability to delete projects only in development for project users and in any status for administrators.

  As a REDCap end user
  I want to see that Project Setup is functioning as expected

  Scenario: B.6.4.1200.100 Projects in development can be deleted by user

    ##ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    When I click on the button labeled "Save Changes"
    And I see "Your system configuration values have now been changed!"
    Then I logout

    ##SETUP_DEV
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "New Project"
    And I enter "B.6.4.1200.100.DEV" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "B.6.4.1200.100.DEV"

    #FUNCTIONAL REQUIREMENT
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.4.1200.100.DEV"
    And I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Delete the project"

    ##ACTION Delete the project
    When I click on the button labeled "Delete the project"
    And I enter "DELETE" into the input field labeled 'TYPE "DELETE" BELOW' in the dialog box
    And I click on the button labeled "Delete the project" in the dialog box
    And I click on the button labeled "CONFIRM DELETION" in the dialog box
    Then I should see "Project successfully deleted!"
    And I click on the button labeled "Close" in the dialog box
    Given I logout

  Scenario: B.6.4.1200.200 Projects in production with no records can be deleted by user
    ##SETUP_PRODUCTION
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "New Project"
    And I enter "B.6.4.1200.200.PROD" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "B.6.4.1200.200.PROD"

    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    ##ACTION Verify record do NOT exist ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    Then I should see "No records exist yet"

    #FUNCTIONAL REQUIREMENT
    When I click on the link labeled "Setup"
    And I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Request delete project"

    ##ACTION Delete the project
    When I click on the button labeled "Request delete project"
    #When I click on the button labeled "OK" in the pop-up box
    Then I should see "Project successfully deleted!"
    And I click on the button labeled "Close" in the dialog box

  Scenario: B.6.4.1200.300 Projects in production with records require admin
    ##SETUP_PRODUCTION
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "B.6.4.1200.300.PROD" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    ##ACTION Verify record exist ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1         |
      | 2         |
      | 3         |
      | 4         |

    #FUNCTIONAL REQUIREMENT
    Given I click on the link labeled "Setup"
    When I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Request delete project"

    ##ACTION Request delete project
    And I click on the button labeled "Request delete project"
    #And I click on the button labeled "OK" in the pop-up box
    Then I should see "Success!"
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    Then I should see a link labeled "To-Do List"
    Given I click on the link labeled "To-Do List"

    Then I should see "Pending Requests"

    Given I should see the "Delete project" request created for the project named "B.6.4.1200.300.PROD" within the "Pending Requests" table
    When I click on the "process request" icon for the "Delete project" request created for the project named "B.6.4.1200.300.PROD" within the "Pending Requests" table
    Then I should see "Permanently delete this project?"

    ##ACTION Delete project
    Given I enter "DELETE" into the input field labeled 'TYPE "DELETE" BELOW' in the iframe
    And I click on the button labeled "Delete the project"
    And I click on the button labeled "Yes, delete the project"
    Then I should see "Project successfully deleted!"

    ##VERIFY
    And I close the iframe window
    Then I should see the "Delete project" request created for the project named "B.6.4.1200.300.PROD" within the "Completed & Archived Requests" table
    #END