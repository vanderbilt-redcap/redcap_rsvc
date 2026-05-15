Feature: D.8.97.0500. User Interface - Permission Enforcement: The system shall restrict access to Mosio project-level enablement and configuration settings based on permissions defined in the Control Center.

As a user I want to see or not see the option to enable and configure Mosio SMS services at the project level based on the permissions set by the administrator in the Control Center, so that access to these settings is appropriately restricted.

This is an optional feature that allows for a direct launch of REDCap within the EHR clinical workflow. This is not required for a client to use CDIS.

For D-level functional requirements, RVP does not provide and executed validation test. These items require site-authored testing if the functionality is in use.
Please include test guidance only, describing:
• The user action or configuration to be exercised
• The system behavior that should be observed
• The expected outcome that would satisfy the requirement
This guidance is intended to support local script development, not to serve as a validated test artifact.

Scenario: D.8.97.0500.0100. Administrator can enable and configure Mosio
Scenario: D.8.97.0500.0200. Non-authorized user cannot view or enable Mosio
Scenario: D.8.97.0500.0300. Project Design user requests Mosio enablement requiring administrator approval

Scenario: #SETUP
Given I login to REDCap with the user "Test_Admin"
#Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
And I create a new project named "D.8.97.0500.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
Then I should see “Mosio SMS services for surveys and alerts"
Scenario: #SETUP_PRODUCTION
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see Project status: "Production"
And I click on the link labeled "User Rights"
And I add "Test_User1" with custom rights
And I select "Project Design and Setup"
And I click the button labeled "Add user"
Then I should see User "Test_user1 successfully added"
And I add "Test_User2" with custom rights
And I DO NOT select "Project Design and Setup"
And I click the button labeled "Add user"
Then I should see User "Test_user2 successfully added"
Scenario: D.8.97.0500.0100. Administrator can enable and configure Mosio
When I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I click the button labeled "Enable"
And I type "" in the box labeled "Mosio API Key"
And I click the button labeled "Save"
Then I should see that "Mosio SMS services for surveys and alerts " is Enabled
And I should see "Mosio SMS services have been enabled

Scenario: D.8.97.0500.0200. Non-authorized user cannot view or enable Mosio

Scenario: Verify Test User 2 cannot view and enable Mosio
Given I login with "Test_user2"
When I click on the link labeled "My Projects"
And I click on the link labeled " D.8.97.0500.0100"
Then I should NOT see "Mosio SMS services for surveys and alerts"
Scenario: D.8.97.0500.0300. Project Design user requests Mosio enablement requiring administrator approval
Given I login to REDCap with the user "Test_user1"
#Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
And I create a new project named "D.8.97.0500.0300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
Then I should see “Mosio SMS services for surveys and alerts"
When I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I click the button labeled "Enable"
And I type "" in the box labeled "Mosio API Key"
And I click the button labeled "Save"
Then I should see that "Mosio SMS services for surveys and alerts " is Enabled
And I should see "Mosio SMS services have been enabled

#End