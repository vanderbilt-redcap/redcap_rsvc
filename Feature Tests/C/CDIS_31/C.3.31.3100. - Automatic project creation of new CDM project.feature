Feature: C.3.31.3100. User Interface: The system shall support the automatic generation of a REDCap project structure when creating a CDM-enabled project. 

As a REDCap end user I want to see that when a user creates a CDM project the project desing is automatically generated to facilitate data being imported.
        
    Scenario: Setup
     #Activate CDIS Settings
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
        And I select "Enable" on the dropdown field labeled "Clinical Data Mart"
        And I select "No, do not display 'email address' option in EHR source field list" on the dropdown field labeled "Allow the patient's email address to be imported from the EHR?"
        And I click on the button labeled "Save Changes"

    #SET UP SMARTHEALTH IT IN CONTROL CENTER 
        When I click on the link labeled "FHIR Systems"
        Then I should see "This interface enables the connection of REDCap with multiple FHIR (Fast Healthcare Interoperability Resources) systems. FHIR is a standard for electronic healthcare information exchange, while SMART on FHIR provides specifications for integrating apps with Electronic Health Records using FHIR standards and OAuth2 security."
        When I click on the button labeled "Add"
        And I should see a button labeled "Cancel"
        And I enter "Test" into the input field labeled "Client ID:"
        And I enter "any_secret" into the input field labeled "Client Secret:"
        And I enter "EHR" into the input field labeled "Custom name for the EHR system"
        And I enter "https://launch.smarthealthit.org/v/r4/sim/WzIsIiIsIiIsIkFVVE8iLDAsMCwwLCIiLCIiLCIiLCIiLCIiLCIiLCIiLDAsMF0/fhir" into the input field labeled "FHIR Base URL"
        And I enter "https://launch.smarthealthit.org/v/r4/sim/WzIsIiIsIiIsIkFVVE8iLDAsMCwwLCIiLCIiLCIiLCIiLCIiLCIiLCIiLDAsMF0/auth/token" into the input field labeled "FHIR Token URL"
        And I enter "https://launch.smarthealthit.org/v/r4/sim/WzIsIiIsIiIsIkFVVE8iLDAsMCwwLCIiLCIiLCIiLCIiLCIiLCIiLCIiLDAsMF0/auth/authorize" into the input field labeled "FHIR Authorize URL"
        And I enter "https://launch.smarthealthit.org/v/r4/sim/WzIsIiIsIiIsIkFVVE8iLDAsMCwwLCIiLCIiLCIiLCIiLCIiLCIiLCIiLDAsMF0/fhir" into the input field labeled "Identity provider (optional)"
        And I enter "http://hospital.smarthealthit.org" into the input field labeled "EHR's patient identifier string for medical record numbers (optional)"
        And I click on the button labeled "Save"
        Then I should see "New FHIR system created"
        
    #Setup: Add CDM rights for test_admin account
        When I click on the link labeled "Browse Users"
        And I enter "test_admin" into the input field labeled "User Search:"
        And I click on the button labeled "Search"
        And I click on the button labeled "Edit user info" 
        And I click on the checkbox labeled "Can create project and pull medical records using Clinical Data Mart?"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."   

    Scenario: C.3.31.3100. User Interface: The system shall support the automatic generation of a REDCap project structure when creating a CDM-enabled project.
    #Create New Project
        Given I click on the link labeled "New Project"
        And I select "Practice / Just for fun" on the dropdown field labeled "---- Select One ----"
        And I enter "C.3.31.3100" into the input field labeled "Project title:"
        And I select the radio option "Clinical Data Mart: Create a project and pull multiple medical records from EHR" for the field labeled "Project creation option:"
        And I click on the button labeled "select all"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."

    #Verify CDM Project Structure on Designer
        When I click on the link labeled "Designer"
        Then I should see "Project Settings"
        And I should see "Demography"
        And I should see "Vital Signs"
        And I should see "Labs"
        And I should see "Social History"
        And I should see "Core Characteristics"
        And I should see "Medications"
        And I should see "Problem List"
        And I should see "Condition Dental Finding"
        And I should see "Condition Genomics"
        And I should see "Condition Infection"
        And I should see "Condition Medical History"
        And I should see "Condition Reason For Visit"
        And I should see "Allergies"
        And I should see "Encounters"
        And I should see "Immunizations"
        And I should see "Adverse Events"
        And I should see "Procedures"
        And I should see "Diagnosis"
        And I should see "Appointments"
        And I should see "Scheduled Surgeries"
        And I should see "Devices"
        And I should see "Coverage"
        And I should see "Clinical Notes"
    #VERIFY_LOG
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Create project (Clinical Data Mart)|
      
#END