Feature: D.8.97.0600. User Interface - External Configuration: The system shall require entry of a Mosio API key to complete project-level enablement of Mosio SMS services.

As a user I want to see a field for entering a Mosio API key when enabling Mosio SMS services at the project level, so that I can complete the enablement process and use the Mosio SMS services in my project.

This is an optional feature that allows for a direct launch of REDCap within the EHR clinical workflow. This is not required for a client to use CDIS.

For D-level functional requirements, RVP does not provide and executed validation test. These items require site-authored testing if the functionality is in use.
Please include test guidance only, describing:
• The user action or configuration to be exercised
• The system behavior that should be observed
• The expected outcome that would satisfy the requirement
This guidance is intended to support local script development, not to serve as a validated test artifact.

Scenario: D.8.97.0600.0100. Prevent Mosio enablement without an API key
Scenario: D.8.97.0600.0200. Allow Mosio enablement with a valid API key
Scenario: D.8.97.0600.0300. Cancel Mosio configuration without saving changes

Scenario: D.8.97.0600.0100. Prevent Mosio enablement without an API key
Given I login to REDCap with the user "Test_Admin"
#Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
And I create a new project named "D.8.97.0600.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
Then I should see “Mosio SMS services for surveys and alerts"
When I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I click the button labeled "Enable"
And I click the button labeled "Save"
Then I should see "ERROR Mosio API Key is missing"

Scenario: D.8.97.0600.0200. Allow Mosio enablement with a valid API key
This is redundant with D.8.97.0500.0100
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

Scenario: D.8.97.0600.0300. Cancel Mosio configuration without saving changes
Given I login to REDCap with the user "Test_user1"
#Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
And I create a new project named "D.8.97.0500.0300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
Then I should see “Mosio SMS services for surveys and alerts"
When I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I click the button labeled "Enable"
And I type "" in the box labeled "Mosio API Key"
And I click the button labeled "Cancel"
Then I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "

#End