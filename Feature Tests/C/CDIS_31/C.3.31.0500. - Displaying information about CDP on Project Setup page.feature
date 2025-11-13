Feature: C.3.31.0500. Control Center: The system shall support displaying information about CDP on the Project Setup page.
As a REDCap end user
I want to see that displaying information about CDP on the Project Setup page is functioning as expected

Scenario: C.3.31.0500: Displaying information about CDP on the Project Setup page.

Given I login to REDCap with the user "Test_Admin"
When I click on the link labeled "Control Center"
And I click on the link labeled "Clinical Data Interoperability Services"
Then I should see "Clinical Data Interoperability Services"
When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
And I click on the button labeled "Save Changes"

#SET UP SMARTHEALTH IT IN CONTROL CENTER 
When I click on the tab labeled "FHIR Systems"
Then I should see "This interface enables the connection of REDCap with multiple FHIR (Fast Healthcare Interoperability Resources) systems. FHIR is a standard for electronic healthcare information exchange, while SMART on FHIR provides specifications for integrating apps with Electronic Health Records using FHIR standards and OAuth2 security."
When I click on the button labeled exactly "Add"
And I enter "Test" into the input field labeled "Client ID:"
And I enter "any_secret" into the input field labeled "Client Secret:"
And I enter "Test" into the input field labeled "Client ID:"
And I enter "EHR" into the input field labeled "Custom name for the EHR system"
And I enter "https://launch.smarthealthit.org/v/r4/sim/WzIsIiIsIiIsIkFVVE8iLDAsMCwwLCIiLCIiLCIiLCIiLCIiLCIiLCIiLDAsMF0/fhir" into the input field labeled "FHIR Base URL"
And I enter "https://launch.smarthealthit.org/v/r4/sim/WzIsIiIsIiIsIkFVVE8iLDAsMCwwLCIiLCIiLCIiLCIiLCIiLCIiLCIiLDAsMF0/auth/token" into the input field labeled "FHIR Token URL"
And I enter "https://launch.smarthealthit.org/v/r4/sim/WzIsIiIsIiIsIkFVVE8iLDAsMCwwLCIiLCIiLCIiLCIiLCIiLCIiLCIiLDAsMF0/auth/authorize" into the input field labeled "FHIR Authorize URL"
And I enter "https://launch.smarthealthit.org/v/r4/sim/WzIsIiIsIiIsIkFVVE8iLDAsMCwwLCIiLCIiLCIiLCIiLCIiLCIiLCIiLDAsMF0/fhir" into the input field labeled "Identity provider (optional)"
And I enter "http://hospital.smarthealthit.org" into the input field labeled "EHR's patient identifier string for medical record numbers (optional)"
And I click on the button labeled "Save"
Then I should see "New FHIR system created"
And I click on the link labeled "Home"

##SETUP
#Given I login to REDCap with the user "Test_Admin"
And I create a new project named "C.3.31.0500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_7.31.xml", and clicking the "Create Project" button
And I click on the link labeled "My Projects"
And I click on the link labeled "C.3.31.0500"

##ACTION Enable CDP in Project
And I click on the button labeled "Enable" in the "SendGrid Template email services for Alerts & Notifications" row in the "Enable optional modules and customizations" section
And I select "Enable" on the dropdown field labeled "SendGrid Template Email Services"
And I click on the button labeled "Save"
And I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR"

##VERIFY
Then I should see "Set up mapping for Clinical Data Pull (CDP)"