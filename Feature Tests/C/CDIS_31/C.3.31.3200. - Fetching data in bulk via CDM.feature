Feature: C.3.31.3200. User Interface: The system shall support fetching clinical data in bulk from the EHR using Clinical Data Mart (CDM) functionality.

    As a REDCap end user I want to see that a user can fetch data in bulk on a CDM enabled project.
        
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
        
    #Setup: Add CDM rights for test_admin account
        When I click on the link labeled "Browse Users"
        And I enter "test_admin" into the input field labeled "User Search:"
        And I click on the button labeled "Search"
        And I click on the button labeled "Edit user info" 
        And I click on the checkbox labeled "Can create project and pull medical records using Clinical Data Mart?"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."   

    #Create New Project
        Given I click on the link labeled "New Project"
        And I select "Practice / Just for fun" on the dropdown field labeled "---- Select One ----"
        And I enter "C.3.31.3200" into the input field labeled "Project title:"
        And I select the radio option "Clinical Data Mart: Create a project and pull multiple medical records from EHR" for the field labeled "Project creation option:"
        And I click on the button labeled "select all"
        And I click on the second button labeled "select all"
        And I click on the tenth button labeled "select all"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."

    #Requesting access token from EHR system
        When I click on the link labeled "Standalone Launch"
        And I wait for 2 seconds
        And I click on the button labeled "Login"
        And I click on the button labeled "Approve"

    # Add two records
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        And I click the bubble for the row labeled "Demography" on the column labeled "Status"
        And I enter "cd9e9826-aea1-4682-adc0-c1d97633bf31" into the input field labeled "Medical record number"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 1 successfully added."

        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        And I click the bubble for the row labeled "Demography" on the column labeled "Status"
        And I enter "869722aa-6d3a-4afd-9acd-b4283bc7d47f" into the input field labeled "Medical record number"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 2 successfully added."

    

    Scenario: C.3.31.3200. User Interface: The system shall support fetching clinical data in bulk from the EHR using Clinical Data Mart (CDM) functionality.
        When I click on the link labeled "Clinical Data Mart"
        And I click on the button labeled "Fetch data"
        And I click on the button labeled "Confirm"
        And I wait for 10 seconds
        Then I should see "Demographics"
        And I should see "32"

    #VERIFY_LOG
      When I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Fetch data for Clinical Data Mart (granular mode)|
      | mm/dd/yyyy hh:mm | test_admin | Update record 1 | patient_fhir_id = 'b218cee9-019d-47a4-b161-e97c0fd6f736', first_name = 'Morris', last_name = 'Lockman', dob = '1970-12-24', sex = 'M', race = '2106-3', race_all_codes = '2106-3', ethnicity = '2186-5', address_line = '1089 Schowalter Manor Unit 75', address_city = 'Somerset', address_state = 'Massachusetts', address_postalcode = '02725', address_country = 'US', phone_home = '555-172-1610', is_deceased = '0', marital_status = 'M', demography_complete = '2'|
      | mm/dd/yyyy hh:mm | test_admin | Update record 2 | patient_fhir_id = '67cbf090-4ddb-4799-99ff-a28abe2740b1', first_name = 'Casandra', last_name = 'Emmerich', dob = '1986-05-23', sex = 'F', race = '2106-3', race_all_codes = '2106-3', ethnicity = '2186-5', address_line = '571 Kemmer Gardens Unit 24', address_city = 'Boston', address_state = 'Massachusetts', address_postalcode = '02108', address_country = 'US', phone_home = '555-715-9979', is_deceased = '0', marital_status = 'M', demography_complete = '2'|

#END