Feature: The system shall allow creation of a participant list automatically using a designated email field when a survey is in any instrument position.

  As a REDCap end user
  I want to see that Participant List is functioning as expected

  Scenario: B.3.15.0300.100 Participant list linked to designated email field
    ##ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    When I click on the button labeled "Save Changes"
    And I see "Your system configuration values have now been changed!"
    Then I logout

    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "B.3.15.0300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see Project status: "Production"

    ##VERIFY_SETUP
    Given I click on the link labeled "Setup"
    Then I should see a button labeled "Disable" in the "Designate an email field for communications (including survey invitations and alerts)" row in the "Enable optional modules and customizations" section
    And I should see "Field currently designated: email"

    #SETUP_SURVEY enable survey in first position
    When I click on the link labeled "Designer"
    And I click on the "Enable" button for the instrument row labeled "Text Validation"
    And I click on the button labeled "Save Changes"
    Then I should see the enabled survey icon link for the instrument row labeled "Text Validation"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Verify Survey Distribution Tool
    When I click on the link labeled "Survey Distribution Tools"
    And I click on the tab labeled "Participant List"
    Then I should see the dropdown field labeled "belonging to" with the option '[Initial survey] "Text Validation" - Event 1 (Arm 1: Arm 1)' selected
    And I should see a table header and rows containing the following values in the a table:
      | Email          | Record | Participant Identifier | Responded | Invitation Scheduled? | Invitation Sent? | Link   | Survey Access Code |
      | email@test.edu | 1      | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
#END