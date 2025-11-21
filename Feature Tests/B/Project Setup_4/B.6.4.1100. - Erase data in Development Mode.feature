Feature: User Interface: General: The system shall support the ability to erase all data for a project at once only in development.

  As a REDCap end user
  I want to see that Project Setup is functioning as expected

  Scenario: B.6.4.1100.100 Erase all data only in development as User
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
    And I create a new project named "B.6.4.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    ##ACTION Verify record exist ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1         |
      | 2         |
      | 3         |
      | 4         |

    When I click on the link labeled "Setup"
    And I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Erase all data"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Erase data
    When I click on the button labeled "Erase all data"
    And I click on the button labeled "Erase all data" in the dialog box
    Then I should see "SUCCESS!"
    And I click on the button labeled "Close" in the dialog box

    ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    Then I should see "No records exist yet"

    ##SETUP_PRODUCTION
    When I click on the link labeled "Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Erase data button missing in production mode
    When I click on the link labeled "Other Functionality"
    ##VERIFY
    Then I should NOT see a button labeled "Erase all data"
    And I logout

  Scenario: B.6.4.1100.200 Erase all data in production mode as Admin
    ##SETUP_PRODUCTION
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I create a new project named "B.6.4.1100.200.PROD" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
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

    When I click on the link labeled "Setup"
    And I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Erase all data"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Erase data
    When I click on the button labeled "Erase all data"
    When I click on the button labeled "Erase all data"
    And I enter "ERASE ALL DATA" into the input field labeled 'TYPE "ERASE ALL DATA" BELOW'
    And I click on the button labeled "Erase all data" in the dialog box
    Then I should see "SUCCESS!"
    And I click on the button labeled "Close" in the dialog box

    ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    Then I should see "No records exist yet"
#END