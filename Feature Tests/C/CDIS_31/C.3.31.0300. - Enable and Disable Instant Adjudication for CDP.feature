Feature: C.3.31.0300. Control Center: The system shall support enabling and disabling Instant Adjudication for CDP-enabled projects.
   
    As a REDCap end user
    I want to see that enabling and disabling Instant Adjudication for Clinical Data Pull (CDP) project functionality works as expected
    So that I can ensure the system is functioning correctly

    Scenario: C.3.31.0300. Control Center: The system shall support enabling and disabling Instant Adjudication for CDP-enabled projects.
    #Activate CDIS Settings
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
        And I select "Disable" on the dropdown field labeled "Clinical Data Mart"
        And I select "Disable" on the dropdown field labeled "Enable Instant Adjudication for all CDP projects?"
        And I select "Disable" on the dropdown field labeled "Break-the-Glass"
        And I select "SystemLogin" on the dropdown field labeled "EHR User type"
        And I select "No, hide all information about CDP" on the dropdown field labeled "Display information about CDP on Project Setup page in a project?"
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
        And I logout

     #SET UP NEW PROJECT
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "D.3.31.0300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "CDPTESTProject.xml", and clicking the "Create Project" button
        Then I should see "D.3.31.0300"
        Then I should see a "Clinical Data Pull from EHR"
        When I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR" 
        Then I should see "Set up Clinical Data Pull from EHR"
        When I click on the button labeled "Set up mapping for Clinical Data Pull (CDP)"
        Then I should see "Clinical Data Pull from EHR"
        And I should see "This option automatically applies (saves) all data pulled from the EHR to the REDCap records without user intervention"
        When I click on the radio labeled "Instant"
        And I click on the button labeled "Save"
        Then I should see "Data saved"

     #VERIFY_RECORD STATUS Dashboard Doesn't allow for instan
        When I click on the link labeled "Record Status Dashboard"
        Then I should NOT see "Instant adjudication is enabled"

    #Active global instant adjudication
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Enable" on the dropdown field labeled "Enable Instant Adjudication for all CDP projects?"
        And I click on the button labeled "Save Changes"
    #Verify instnt adjudication is activated in UI 
        And I click on the link labeled "My Projects"
        And I click on the link labeled "D.3.31.0300"
        And I click on the link labeled "Record Status Dashboard"
        Then I should see "Instant adjudication is enabled"

     #VERIFY LOG
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Enable Clinical Data Pull (CDP) module|
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | CDIS settings updated|

#END