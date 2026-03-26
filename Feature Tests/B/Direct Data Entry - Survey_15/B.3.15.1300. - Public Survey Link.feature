Feature: User Interface: Survey distribution: The system shall allow creation of a public survey link when the survey is in the first instrument position.

  As a REDCap end user
  I want to see that Manage project user access is functioning as expected

  Scenario: B.3.15.1300.100 Public survey link
    #SETUP
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "B.3.15.1300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #FUNCTIONAL REQUIREMENT
    ##ACTION - 1st instrument is not set-up as survey
    When I click on the link labeled "Survey Distribution Tools"
    Then I should see "Survey Response Status"
    When I click on the link labeled "Public Survey Link"
    #VERIFY
    Then I should see "Public Survey not set up yet"

    #SETUP - enable first instrument survey
    When I click on the button labeled "Enable public survey"
    Then I should see "Set up my survey for data collection instrument"
    When I click on the button labeled "Save Changes"
    Then I should see "Data Collection Instruments"

    #FUNCTIONAL REQUIREMENT
    ##ACTION - public survey link
    When I click on the link labeled "Survey Distribution Tools"
    #VERIFY
    Then I should see "Public Survey URL:"

    When I click on the button labeled "Open public survey"
    Then I should see "Please complete the survey below."

    Given I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"
    Then I should see "You may now close this tab/window"

    #VERIFY_LOG
    Given I return to the REDCap page I opened the survey from
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username            | Action          |
      | mm/dd/yyyy hh:mm | [survey respondent] | Create Response |
#END