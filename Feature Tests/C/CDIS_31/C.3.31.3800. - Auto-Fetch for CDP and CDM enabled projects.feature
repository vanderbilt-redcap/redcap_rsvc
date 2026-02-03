Feature: C.3.31.3800. User Interface: The system shall support the ability to Auto-fetch all clinical data
    
    As a REDCap end user I want to see that the autofetch works for both a CDP and CDM project.
        
Scenario: Setup
     #Activate CDIS Settings
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
        And I select "Enable" on the dropdown field labeled "Clinical Data Mart"
        And I select "No, do not display 'email address' option in EHR source field list" on the dropdown field labeled "Allow the patient's email address to be imported from the EHR?"
        And I enter "1" into the input field labeled "Every"
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
        
#     #Setup: Add CDM rights for test_admin account
#         When I click on the link labeled "Browse Users"
#         And I enter "test_admin" into the input field labeled "User Search:"
#         And I click on "Search"
#         And I click on "Edit user info" 
#         And I click on the checkbox labeled "Can create project and pull medical records using Clinical Data Mart?"
#         And I click on the button labeled "Save"
#         Then I should see "User has been successfully saved."   

#     #Create New Project
#         Given I click on the link labeled "New Project"
#         And I select "Practice / Just for fun" on the dropdown field labeled "---- Select One ----"
#         And I enter "C.3.31.3700" into the input field labeled "Project title:"
#         And I select the radio option "Clinical Data Mart: Create a project and pull multiple medical records from EHR" for the field labeled "Project creation option:"
#         And I click on the "select all" in the row labeled "Vital Signs"
#         And I click on the "select all" in the row labeled "Demographics"
#         And I enter "cd9e9826-aea1-4682-adc0-c1d97633bf31" into the textarea field labeled "Enter medical record numbers of patients to import from the EHR (one per line, optional)"
#         And I click on the button labeled "Create Project"
#         Then I should see "Your new REDCap project has been created and is ready to be accessed."
        
#     #Requesting access token from EHR system
#         When I click on the button labeled "Enable" in the row labeled "Auto-fetch all clinical data once a day (based on Data Mart configuration)" 
#         And I click on the link labeled "Standalone Launch"
#         And I wait for 2 seconds
#         And I click on the button labeled "Login"
#         And I click on the button labeled "Approve"

#     # Add two records
#         When I click on the link labeled "Add / Edit Records"
#         And I click on the button labeled "Add new record"
#         And I click the bubble for the row labeled "Demography" on the column labeled "Status"
#         And I enter "869722aa-6d3a-4afd-9acd-b4283bc7d47f" into the input field labeled "Medical record number"
#         And I click on the button labeled "Save & Exit Form"
#         Then I should see "Study ID 2 successfully added."

# Scenario: C.3.31.3800.100 User Interface: The Auto-Fetch feature in CDM will automaticly pull data an place it in REDCap project.
#             And I wait for background processes to finish

#     #VERIFY_LOG the background process should have created multiple entries per record in the logging table
#         When I click on the link labeled "Logging"
#         Then I should see a table header and rows containing the following values in the logging table:
#         | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
#         | mm/dd/yyyy hh:mm | SYSTEM | Update record 1 | [instance = 31], vitals_time = '2017-07-14 01:17', vital_signs_complete = '2'|
#         | mm/dd/yyyy hh:mm | SYSTEM | Update record 2 | [instance = 21], vitals_time = '2019-08-09 06:49', vital_signs_complete = '2'|

Scenario: C.3.31.3800.200 User Interface: The system shall will auto fetch and add data to records in the project.
     #Turn on CDP at the project level
        When I click on "My Projects"
        And I create a new project named "C.3.31.3800.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "CDPTESTProject.xml", and clicking the "Create Project" button
        Then I should see "C.3.31.3800.200"
        Then I should see a "Clinical Data Pull from EHR"
        When I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR" 
        Then I should see "Set up Clinical Data Pull from EHR"
            #Requesting access token from EHR system
        When I click on the link labeled "Standalone Launch"
        And I wait for 2 seconds
        And I click on the button labeled "Login"
        And I click on the button labeled "Approve"
        
        When I click on the button labeled "Set up mapping for Clinical Data Pull (CDP)"
        Then I should see "Clinical Data Pull from EHR"
        And I should see "This option automatically applies (saves) all data pulled from the EHR to the REDCap records without user intervention"
        When I click on the radio labeled "Auto"
        And I click on the button labeled "Save"
        Then I should see "Data saved"

        # Add record and fetch data from EHR system
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        And I click the bubble for the row labeled "Demography" on the column labeled "Status"
        And I enter "cd9e9826-aea1-4682-adc0-c1d97633bf31" into the input field labeled "Medical record number"
        Then I should see "Are the values below correct for"
        And I should see "name-given:"
        And I should see "name-family:"
        And I should see "birthDate:"
        When I click on the button labeled "Save record and fetch data"
        Then I should see "Adjudicate data from External System"
        And I should see "Morris"
        And I should see "Lockman"
        And I click on the button labeled "Cancel"
        And I click on the button labeled "More save options"
        And I click on the link labeled "Save & Exit Form"
        Then I should see "Study ID 1 successfully edited."

        And I wait for background processes to finish

    #VERIFY_LOG the background process should have created multiple entries per record in the logging table
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | SYSTEM | Update record 1 | first_name = 'Morris'|
        | mm/dd/yyyy hh:mm | SYSTEM | Update record 1 | last_name = 'Lockman'|
        | mm/dd/yyyy hh:mm | SYSTEM | Update record 1 | dob = '1970-12-24'|

#END