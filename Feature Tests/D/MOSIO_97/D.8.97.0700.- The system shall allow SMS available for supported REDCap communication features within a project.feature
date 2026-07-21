Feature: D.8.97.0700. User Interface – SMS Provider Availability: The system shall allow SMS available for supported REDCap communication features within a project using the configured SMS provider once an SMS provider is enabled and configured.
    As a REDCap user, I want to be able to use SMS as a delivery option for supported REDCap communication features within a project once an SMS provider is enabled and configured.

Scenario: D.8.97.0700.0100 Alerts & Notifications display SMS as a delivery option when Mosio is enabled
    Given I login to REDCap with the user "Test_Admin"
    #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
    And I create a new project named " D.8.97.0700.0100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see “Mosio SMS services for surveys and alerts"
    When I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "
    Then I should see "Mosio Two-Way Text Messaging (SMS Services"
    And I click the button labeled "Enable"
    And I type "" in the box labeled "Mosio API Key"
    And I click the button labeled "Save"
    Then I should see that "Mosio SMS services for surveys and alerts " is Enabled
    And I should see "Mosio SMS services have been enabled

Scenario: #SETUP Configure Mosio
    When I Click the button labeled "Configure setting" in the section labeled" Mosio Two-way Text Messaging (SMS) Services"
    And I select " Alerts & Notifications only" for the dropdown "labeled " Select the project features for which the telephony services will be enabled (e.g., surveys and/or alerts)
    And I select the checkbox labeled "Send survey invitation with survey link via SMS'
    And I select "SMS Invitation (contains survey link)" from the dropdown labeled " Choose the default invitation preference for new survey participants"
    And I select "phone _number "Phone Number"" from the dropdown labeled " Designate a phone number field for survey invitations sent via SMS or voice call (optional)"
    And I click the button labeled "Save"

    And I click the link labeled "Alerts & Notifications
    And I click the button labeled "Add new alert"
    Then I should see "SMS Text Message" is enabled in the section labeled "Step 3 Message Setting"

Scenario: D.8.97.0700.0200 ASI display SMS as a delivery option when Mosio is enabled
    #MThe Green API key can only be used in 1 project or you get a message that the key is already in use.
    Given I login to REDCap with the user "Test_Admin"
    #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
    And I create a new project named " D.8.97.0700.0100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see “Mosio SMS services for surveys and alerts"
    When I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "
    Then I should see "Mosio Two-Way Text Messaging (SMS Services"
    And I click the button labeled "Enable"
    And I type " "Mosio API Key"
    And I click the button labeled "Save"
    Then I should see that "Mosio SMS services for surveys and alerts " is Enabled
    And I should see "Mosio SMS services have been enabled

Scenario: #SETUP Configure Mosio
    When I Click the button labeled "Configure setting" in the section labeled" Mosio Two-way Text Messaging (SMS) Services"
    And I select " Surveys and survey invitations only" for the dropdown "labeled " Select the project features for which the telephony services will be enabled (e.g., surveys and/or alerts)
    And I select the checkbox labeled "Send survey invitation with survey link via SMS'
    And I select "SMS Invitation (contains survey link)" from the dropdown labeled " Choose the default invitation preference for new survey participants"
    And I select "phone _number "Phone Number"" from the dropdown labeled " Designate a phone number field for survey invitations sent via SMS or voice call (optional)"
    And I click the button labeled "Save"

    And I click the link labeled "Designer"
    And I click the button labeled "Automated invitations"
    And I click the button labeled" "+Setup" for the event labeled " Event Three (Arm 1: Arm 1)"
    Then I should see "SMS Text Message (Contains survey link0" is enabled in the section labeled "Step 1: Invitation type - How the participant is invited "

Scenario: D.8.97.0700.0300 Survey Distribution Tools display SMS survey option when Mosio is enabled
    Given I login to REDCap with the user "Test_Admin"
    #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
    And I create a new project named " D.8.97.0700.0100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    Then I should see “Mosio SMS services for surveys and alerts"
    When I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "
    Then I should see "Mosio Two-Way Text Messaging (SMS Services"
    And I click the button labeled "Enable"
    And I type "l" in the box labeled "Mosio API Key"
    And I click the button labeled "Save"

#End