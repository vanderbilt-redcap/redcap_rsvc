Feature: C.3.31.1200. Control Center: The system shall support allowing or restricting the import of patient email addresses into a CDP enabled project.
    As a REDCap end user
    I want to see that the email restriction in the control center manages the ability to pull email address from the EHR.
        
    Scenario: C.3.31.1200. Control Center: The system shall support allowing or restricting the import of patient email addresses into a CDP enabled project.
    #Activate CDIS Settings
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
        And I select "No, do not display 'email address' option in EHR source field list" on the dropdown field labeled "Allow the patient's email address to be imported from the EHR?"
        And I click on the button labeled "Save Changes"

    #SET UP SMARTHEALTH IT IN CONTROL CENTER 
        When I click on the link labeled "FHIR Systems"
        Then I should see "This interface enables the connection of REDCap with multiple FHIR (Fast Healthcare Interoperability Resources) systems. FHIR is a standard for electronic healthcare information exchange, while SMART on FHIR provides specifications for integrating apps with Electronic Health Records using FHIR standards and OAuth2 security."
        When I click on the button labeled "Add"
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
        And I logout

     #SET UP NEW PROJECT
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.31.1200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "CDPTESTProject.xml", and clicking the "Create Project" button
        Then I should see "C.3.31.1200"
        Then I should see a "Clinical Data Pull from EHR"
        When I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR" 
        Then I should see "Set up Clinical Data Pull from EHR"

        When I click on the button labeled "Set up mapping for Clinical Data Pull (CDP)"
        And I click on the button labeled "Find more source fields to map"
        Then I should see "nothing selected"
        When I click on the dropdown field labeled "nothing selected"
        And I enter "email" into the text area labeled "Filter..."
        And I click on the option labeled "Demographics"
        Then I should see "fetching has been disabled at system level."
        Then I should not see 'email address' in the dropdown field labeled "Select EHR Source Field to Map:"

        
    #VERIFY LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported   |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Enable Clinical Data Pull (CDP) module    |

#Activate CDIS Settings (Yes, display 'email address' option in EHR source field list)
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
        And I select "Yes, display 'email address' option in EHR source field list" on the dropdown field labeled "Allow the patient's email address to be imported from the EHR?"
        And I click on the button labeled "Save Changes"

    #Verify email address drop down is enabled in the project settings (Control Center).      
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.1200"
        And I click on the button labeled "Set up mapping for Clinical Data Pull (CDP)"
        And I click on the button labeled "Find more source fields to map"
        Then I should see "nothing selected"
        When I click on the dropdown field labeled "nothing selected"
        And I enter "email" into the text area labeled "Filter..."
        And I click on the option labeled "Demographics"
        Then I should see 'email'
        And I should see 'email-2' 
        And I should see 'email-3'        

#END