Feature: A.3.30.0100 Control Center: The system shall support enabling or disabling the Randomization module system-wide.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

  #A.3.30.0100.0100: Enabled at system level allows randomization module option at the project level.
  Scenario: A.3.30.0100.0100. Enable randomization at control center
    #FUNCTIONAL_REQUIREMENT
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Randomization"

    When I select "Enable" on the dropdown field labeled "Randomization"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

  Scenario: #VERIFY randomization module avaialbe project level
    #SETUP
    Given I create a new project named "A.3.30.0100." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see "Main project settings"
    And I click on the link labeled "Setup"
    Then I should see a button labeled "Enable" in the row labeled "Randomization module"
    
  #A.3.30.0100.0200: Disabled at system level removes randomization module option at the project level.
  Scenario: A.3.30.0100.0200. Disable randomization at system level
    #FUNCTIONAL_REQUIREMENT
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Randomization"

    When I select "Disable" on the dropdown field labeled "Randomization"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

  Scenario: #VERIFY randomization module NOT avaialbe project level
    #SETUP
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.30.0100."
    And I click on the link labeled "Setup"
    Then I should NOT see "Randomization module"
    And I logout
#END