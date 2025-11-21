Feature: User Interface: The system shall require changes made to data collection instruments in production status projects to be made only by entering draft mode.  Changes in draft mode are implemented upon acceptance of submission, not real time.

  As a REDCap end user
  I want to see that Draft Mode is functioning as expected

  Scenario: B.4.20.0300.100 Changes occur in draft mode non-real-time
    ##ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    When I click on the button labeled "Save Changes"
    And I see "Your system configuration values have now been changed!"
    Then I logout

    #SETUP
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "B.4.20.0300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Draft Mode
    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    #ACTION: Make changes to instrument
    When I click on the link labeled "Data Types"
    And I click on the Edit image for the field named "Radio Button Manual"
    And I enter Choices of "102, Choice102" into the open "Edit Field" dialog box
    And I click on the button labeled "Save"

    ##VERIFY INSTRUMENT
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 2" for record ID "1" and click on the bubble
    Then I should NOT see "Choice102"

    ##VERIFY: (look at a table that shows summary of changes)
    When I click on the link labeled "Designer"
    And I click on the link labeled "View detailed summary of all drafted changes"
    Then I should see a table header and rows containing the following values in a table:
      | Variable Name       | Section Header | Field Type | Field Label         | Choices or Calculations |
      | radio_button_manual |                | radio      | Radio Button Manual | 102, Choice102          |

    ##ACTION
    Given I click on the button labeled "RETURN TO PREVIOUS PAGE"
    And I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"
    And I click on the button labeled "Close" in the dialog box

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and row containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported              |
      | test_user1 | Manage/Design | Approve production project modifications (automatic) |

    ##VERIFY INSTRUMENT
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "1" in the column labeled "Record ID" and the row labeled "1" 
    And I click on the icon in the column labeled "Event 2" and the row labeled "Data Types" 
    Then I should see "Choice102"
#END