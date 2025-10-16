Feature: User Interface: Survey Project Settings: The system shall support a participant list for each survey in the project. A dropdown menu will list each survey or if a longitudinal project, each survey/event pairing from which to select the survey of interest.

  As a REDCap end user
  I want to see that Participant List is functioning as expected

  Scenario:  B.3.15.1000.100 Distribution tools for longitudinal project
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.3.15.1000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see Project status: "Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Change survey distribution to form not in position 1
    When I click on the link labeled "Survey Distribution Tools"
    When I select '"Consent" - Event 1 (Arm 1: Arm 1)' on the dropdown field labeled "Participant List"
    ##VERIFY: YOU SEE RECORD 1
    Then I should see a table header and rows containing the following values in the a table:
      | Email             | Record | Participant Identifier | Responded | Invitation Scheduled? | Invitation Sent? | Link   | Survey Access Code |
      | [No email listed] |        | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | [No email listed] |        | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | email@test.edu    | 1      | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | email@test.edu    | 2      | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |

    ###ACTION: Change survey distribution to form not in position 1
    When I select '"Survey" - Event Three (Arm 1: Arm 1)' on the dropdown field labeled "Participant List"
    ##VERIFY: YOU SEE RECORD 1
    Then I should see a table header and rows containing the following values in the a table:
      | Email             | Record | Participant Identifier | Responded | Invitation Scheduled? | Invitation Sent? | Link   | Survey Access Code |
      | [No email listed] |        | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | [No email listed] |        | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | email@test.edu    | 1      | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | email@test.edu    | 2      | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
#END