Feature: D.8.97.0400. User Interface: The system shall support project-level enable/disable of Mosio SMS services

As a user I want to see that Mosio SMS services can be enabled and disabled at the project leve.

This is an optional feature that allows for a direct launch of REDCap within the EHR clinical workflow. This is not required for a client to use CDIS.

For D-level functional requirements, RVP does not provide and executed validation test. These items require site-authored testing if the functionality is in use.
Please include test guidance only, describing:
• The user action or configuration to be exercised
• The system behavior that should be observed
• The expected outcome that would satisfy the requirement
This guidance is intended to support local script development, not to serve as a validated test artifact.

D.8.97.0400. User Interface: The system shall support project-level enable/disable of Mosio SMS services
Scenario: D.8.97.0400.0100 Enable Mosio SMS services for a project
Scenario: D.8.97.0400.0200 Disable Mosio SMS services for a project
Scenario: D.8.97.0400.0300 Verify Mosio options appear or are removed based on project enablement This one is redundant to D.8.97.0200 and D.8.97.0300

Scenario: Enable Mosio SMS services in Project
#SETUP
Given I login to REDCap with the user "Test_Admin"
#Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
And I create a new project named "D.8.97.0400.0100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
And I click on the link labeled "Designer"
#Verify Mosio framework enabled
Then I should see "Mosio"
When I click the button labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I click the button labeled "Enable"
And I type "" in the box labeled "Mosio API Key"
And I click the button labeled "Save"
Then I should see that "Mosio SMS services for surveys and alerts " is Enabled
And I should see "Mosio SMS services have been enabled.

Scenario: D.8.97.0400.0200  Disable Mosio SMS services in Project
When I click on the project named "D.8.97.0400.0100"
And I click the button labeled "Modify" in the row labeled labeled "Mosio SMS services for surveys and alerts "
And I click "Disable" in the row labeled labeled "Mosio SMS services for surveys and alerts "

Then I should see a button labeled labeled "Enable" in the row labeled "Mosio SMS services for surveys and alerts "

#End