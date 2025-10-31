Feature: C.3.31.0200. User Interface: Control Center: The system shall support enabling and disabling Clinical Data Mart (CDM) functionality.
As a REDCap end user
I want to see that enabling and disabling Clinical Data Mart (CDM) is functioning as expected

#M This test assumes that REDCap has been configured to work with your EHR under the FHIR systems section of the Control Center
#M for RSVC this test assume that Smart Health IT was set up

Scenario: C.3.31.0200: Enabling and Disabling Clinical Data Mart (CDM) functionality.

#FUNCTIONAL_REQUIREMENT
##ACTION: Enable Clinical Data Mart Module
Given I login to REDCap with the user "Test_Admin"
When I click on the link labeled "Control Center"
And I click on the link labeled "Clinical Data Interoperability Services"
Then I should see "Clinical Data Interoperability Services"
When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
When I select "Enabled" on the dropdown field labeled "Clinical Data Mart"
And I click on the button labeled "Save Changes"

#SET UP SMARTHEALTH IT IN CONTROL CENTER 
When I click on the link labeled "FHIR Systems"
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

#SETUP
And I click on the link labeled "New Project"
And I enter "C.3.31.0200" into the field labeled "Project title" 
And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose:"
And I click on the radio labeled "Clinical Data Mart: Create a project and pull multiple medical records from EHR"
And I click the element containing the following text: "Demographics"
And I check the checkbox labeled "name-family" 
And I check the checkbox labeled "name-given"
And I click on the button labeled "Create Project"
Then I should see "C.3.31.0200"
And I should see "Clinical Data Mart"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Time / Date | Username | Action | List of Data Changes OR Fields Exported |
| mm/dd/yyyy hh:mm | test_admin | Manage/Design | Create project (Clinical Data Mart)|

#FUNCTIONAL_REQUIREMENT
##ACTION: Disable Clinical Data Mart Module
Given I login to REDCap with the user "Test_Admin"
When I click on the link labeled "Control Center"
And I click on the link labeled "Clinical Data Interoperability Services"
Then I should see "Clinical Data Interoperability Services"
When I select "Disabled" on the dropdown field labeled "Clinical Data Mart"
And I click on the button labeled "Save Changes"

# #SETUP
And I click on the link labeled "New Project"
And I enter "C.3.31.0200" into the field labeled "Project title" 
And I should NOT see "Clinical Data Mart: Create a project and pull multiple medical records from eStar"

#END