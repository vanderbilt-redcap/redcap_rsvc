Feature: C.3.31.1400. Control Center: The system shall support allowing or restricting the import of patient email addresses into a CDM enabled project.
    As a REDCap end user
    I want to see that the email restriction in the control center changes manages the ability to pull email address from the EHR.
        
    Scenario: C.3.31.1400. Control Center: The system shall support allowing or restricting the import of patient email addresses into a CDM enabled project.
    #Activate CDIS Settings (No Email)
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
        And I select "Enable" on the dropdown field labeled "Clinical Data Mart"
        And I select "No, do not display 'email address' option in EHR source field list" on the dropdown field labeled "Allow the patient's email address to be imported from the EHR?"
        And I click on the button labeled "Save Changes"

    #SET UP SMARTHEALTH IT IN CONTROL CENTER 
    #M Only one FHIR system setup is needed to test the functionality. You can skip these steps if you have already done this on another CDIS test. These FHIR settings will allow for validation against smart health IT and ensure REDCap can pull data via FHIR. If you want to validate against your local EHR vendor modification to these steps will be required. 
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
        
    #Setuo add CDM rights for test_admin account
        When I click on the link labeled "Browse Users"
        And I enter "test_admin" into the input field labeled "User Search:"
        And I click on the button labeled "Search"
        And I click on the button labeled "Edit user info" 
        And I click on the checkbox labeled "Can create project and pull medical records using Clinical Data Mart?"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."    

     #SET UP NEW PROJECT
        #Given I login to REDCap with the user "Test_Admin"
        Given I click on the link labeled "New Project"
        And I select "Practice / Just for fun" on the dropdown field labeled "---- Select One ----"
        And I enter "C.3.31.1400" into the input field labeled "Project title:"
        And I select the radio option "Clinical Data Mart: Create a project and pull multiple medical records from EHR" for the field labeled "Project creation option:"
        And I click on the button labeled "select all" in the row labeled "Demographics"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."

    #Check email access #1
        When I click on the link labeled "Project Home"
        And I click on the link labeled "Clinical Data Mart"
        And I should see a button labeled "Fetch data"
        And I click on the button labeled "Request a configuration change"
        And I enter "Email" into the field with the placeholder text of "type to search..."
        And I click on "Demographics"
        Then I should see the strikethrough text "Email address"
    
    #Activate CDIS Settings (Yes Email)
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Yes, display 'email address' option in EHR source field list" on the dropdown field labeled "Allow the patient's email address to be imported from the EHR?"
        And I click on the button labeled "Save Changes"

    #Check email access #2
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.1400"
        And I click on the link labeled "Project Home"
        And I click on the link labeled "Clinical Data Mart"
        And I should see a button labeled "Fetch data"
        And I click on the button labeled "Request a configuration change"
        And I enter "Email" into the field with the placeholder text of "type to search..."
        And I click on "Demographics"
        Then I should NOT see the strikethrough text "Email address"
    
#END