Feature: D.8.97.0200. Control Center: The system shall support configuration privileges for Mosio SMS services when Mosio enablement authority is restricted to administrators.

As a REDCap end user
I want to see D.8.97.0200. Control Center: The system shall support configuration privileges for Mosio SMS services when Mosio enablement authority is restricted to administrators.

This is an optional feature that allows for a direct launch of REDCap within the EHR clinical workflow. This is not required for a client to use CDIS.

For D-level functional requirements, RVP does not provide and executed validation test. These items require site-authored testing if the functionality is in use.
Please include test guidance only, describing:
• The user action or configuration to be exercised
• The system behavior that should be observed
• The expected outcome that would satisfy the requirement
This guidance is intended to support local script development, not to serve as a validated test artifact.

Test Scenarios:
D.8.97.0200.0100. Only administrators can view and enable Mosio
D.8.97.0200.0200. Users with Project Design privileges require administrator approval to enable Mosio
D.8.97.0200.0300. All users with Project Design privileges can enable Mosio

Scenario: #SETUP
Given I login to REDCap with the user "Test_Admin"
#Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
And I create a new project named "A.Mosio2" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
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

Scenario: #SETUP_CONTROL_CENTER
When I click on the link labeled “Control Center”
And I click on the link labeled "Modules/Services Configuration"
Then I should see "Mosio SMS services for surveys and alerts"

Scenario: D.8.97.0200.0100. Only administrators can view and enable Mosio
When I select "Only Administrators can view the setting and enable it " on the dropdown field labeled "Who can enable Mosio SMS services in a given project"
And I click on the button labeled "Save Changes"
Then I should see "Your system configuration values have now been changed!"

Scenario: #D.8.97.0300.0100. Hide Mosio information from non-administrative users
When I select "No, hide all information about Mosio SMS services" on the dropdown field labeled "Display information about Mosio SMS services to all users on Project Setup page in a project?"
And I click on the button labeled "Save Changes"
Then I should see "Your system configuration values have now been changed!"
And I log out

Scenario: Verify Test User 1 cannot view and enable Mosio
Given I login with "Test_user1"
When I click on the link labeled "My Projects"
And I click on the link labeled "A.Mosio2"
Then I should NOT see "Mosio SMS services for surveys and alerts"

Scenario: D.8.97.0300.0200. Display Mosio information to non-administrative users
Given I login with "Test_Admin "
When I click on the link labeled “Control Center”
And I click on the link labeled "Modules/Services Configuration"
Then I should see "Mosio SMS services for surveys and alerts"
When I select "Only Administrators can view the setting and enable it " on the dropdown field labeled "Who can enable Mosio SMS services in a given project"
And I click on the button labeled "Save Changes"
Then I should see "Your system configuration values have now been changed!"
When I select "Yes, display information about Mosio SMS services" on the dropdown field labeled "Display information about Mosio SMS services to all users on Project Setup page in a project?"
And I click on the button labeled "Save Changes"
Then I should see "Your system configuration values have now been changed!"
And I log out

Scenario: Verify Test User 1 view information about Mosio and cannot enable
Given I login with "Test_user1"
When I click on the link labeled "My Projects"
And I click on the link labeled "A.Mosio2"
Then I should see "Mosio SMS services for surveys and alerts"
And I should NOT be able to click on the button labeled "Enable" on the dropdown field labeled "Enable Mosio web service for SMS services?"
And I log out

Scenario: D.8.97.0200.0100. Verify Test_Admin can view and enable Mosio
Given I login with "Test_Admin "
Then I should see "Mosio SMS services for surveys and alerts"
And I should be able to click on the button labeled "Enable" on the dropdown field labeled "Enable Mosio web service for SMS services?"
When I click on the button labeled "Enable" on the dropdown field labeled "Enable Mosio web service for SMS services?"
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I select "Enabled" for the dropdown labeled "Mosio SMS services"
And I click the button labeled "Save"
#Note at the point your get an Error if you don’t have a API key.
And I click on the button labeled "Disable" on the dropdown field labeled "Enable Mosio web service for SMS services?"

Scenario: D.8.97.0200.0200. Users with Project Design privileges require administrator approval to enable Mosio
When I click on the link labeled “Control Center”
And I click on the link labeled "Modules/Services Configuration"
Then I should see "Mosio SMS services for surveys and alerts"
When I select "Admin approval: All users (who have Project Design privileges cam request an admin to enable it " on the dropdown field labeled "Who can enable Mosio SMS services in a given project"
And I click on the button labeled "Save Changes"
Then I should see "Your system configuration values have now been changed!"
And I log out

Given I login with "Test_Admin "
When I click on the link labeled “Control Center”
And I click on the link labeled "Modules/Services Configuration"
Then I should see "Mosio SMS services for surveys and alerts"
When I select "Admin approval: All users (who have Project Design privileges cam request an admin to enable it " on the dropdown field labeled "Who can enable Mosio SMS services in a given project"
And I click on the button labeled "Save Changes"
Then I should see "Your system configuration values have now been changed!"
And I log out

Scenario: Verify Test User 1 enable Mosio with admin approval
Given I login with "Test_user1"
When I click on the link labeled "My Projects"
And I click on the link labeled "A.Mosio2"
#Verify Mosio enabled
Then I should see "Mosio SMS services for surveys and alerts"
When I click on the button labeled "Enable" on the dropdown field labeled "Enable Mosio web service for SMS services?"
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I select "Enabled" for the dropdown labeled "Mosio SMS services"
And I click the button labeled "Save"
#Note at the point your get an Error if you don’t have a API key.

Scenario: Admin rejects requests
Given I login with "Test_Admin "
When I click on the link labeled “Control Center”
And I click on the link labeled “To-Do List”
#Find the pending request and reject.

Scenario: D.8.97.0200.0300. All users with Project Design privileges can enable Mosio
When I click on the link labeled "Modules/Services Configuration"
Then I should see "Mosio SMS services for surveys and alerts"
When I select "Admin approval: All users (who have Project Design privileges cam request an admin to enable it " on the dropdown field labeled "Who can enable Mosio SMS services in a given project"
And I click on the button labeled "Save Changes"
Then I should see "Your system configuration values have now been changed!"
And I log out

Scenario: Verify Test User 2 CANNOT enable Mosio
Given I login with "Test_user2"
When I click on the link labeled "My Projects"
And I click on the link labeled "A.Mosio2"
Then I should NOT see “Project setup”
And I should NOT be able to click on the button labeled "Enable" on the dropdown field labeled "Enable Mosio web service for SMS services?"
And I log out

Scenario: Verify Test User 1 enable Mosio without admin approval
Given I login with "Test_user1"
When I click on the link labeled "My Projects"
And I click on the link labeled "A.Mosio2"
#Verify Mosio enabled
Then I should see "Mosio SMS services for surveys and alerts"
When I click on the button labeled "Enable" on the dropdown field labeled "Enable Mosio web service for SMS services?"
Then I should see "Mosio Two-Way Text Messaging (SMS Services"
And I select "Enabled" for the dropdown labeled "Mosio SMS services"
And I click the button labeled "Save"
#Note at the point your get an Error if you don’t have a API key.

#End