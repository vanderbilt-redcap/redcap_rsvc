Feature: D.8.97.0100. Control Center: The system shall support system level enable/disable of Mosio SMS services

 As a REDCap administrator, I want to be able to enable or disable Mosio SMS services at the system level, so that I can control the availability of this feature for all projects in REDCap.
    
This is an optional feature that allows for a direct launch of REDCap within the EHR clinical workflow. This is not required for a client to use CDIS.

For D-level functional requirements, RVP does not provide and executed validation test. These items require site-authored testing if the functionality is in use.
Please include test guidance only, describing:
• The user action or configuration to be exercised
• The system behavior that should be observed
• The expected outcome that would satisfy the requirement
This guidance is intended to support local script development, not to serve as a validated test artifact.

Tests Scenarios:
D.8.97.0100.0100. Control Center system-level enable Mosio SMS services
D.8.97.0100.0200. Control Center system-level disable Mosio SMS services

Scenario: Setup Mosio SMS services in Control Center
#SETUP
Given I login to REDCap with the user "Test_Admin"
#Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
And I create a new project named "A.Mosio" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
And I click on the link labeled "Designer"
#Verify Mosio framework enabled
Then I should see "Mosio"
When I click the button labeled "Enable" in the row labeled " Mosio SMS services for surveys and alerts "
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I click on the button labeled "Save"

Scenario:#SETUP_CONTROL_CENTER
And I click on the link labeled "Control Center"
And I click on the link labeled "Modules/Services Configuration"
Then I should see " Modules/Services Configuration "

Scenario: D.8.97.0100.0200. Control Center system-level disable Mosio SMS services
When I click the button labeled "Disabled" for "Enable Mosio web service for SMS services?"
When I click on the link labeled "My Projects"
And I click on the link labeled "A.Mosio"
#Verify Mosio disabled
And I should NOT see "Enable" in the row labeled " Mosio SMS services for surveys and alerts "

Scenario: D.8.97.0100.0100. Control Center system-level enable Mosio SMS services
#SETUP_CONTROL_CENTER
When I click on the link labeled "Control Center"
And I click on the link labeled "Modules/Services Configuration"
Then I should see "Mosio SMS surveys and alerts"
When I select "Enable" on the dropdown field labeled "Enable Mosio web service for SMS services?"
And I click on the button labeled "Save Changes"
Then I should see "Your system configuration values have now been changed!"
When I click on the link labeled "My Projects"
And I click on the link labeled "A.Mosio"

Scenario: #Verify Mosio enabled
Then I should see "Mosio SMS services for surveys and alerts"
When I click on the button labeled "Enable" on the dropdown field labeled "Enable Mosio web service for SMS services?"
Then I should see "Mosio Two-Way Text Messaging (SMS Services"

#End