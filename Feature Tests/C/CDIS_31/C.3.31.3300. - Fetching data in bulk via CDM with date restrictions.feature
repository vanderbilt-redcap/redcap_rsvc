Feature: C.3.31.3300. User Interface: The system shall support restricting bulk EHR data pulls in CDM projects based on date or datetime filters.
    
    As a REDCap end user I want to see that I can limit the fetched data by dates.
        
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
        
    #Setup: Add CDM rights for test_user1 account
        When I click on the link labeled "Browse Users"
        And I enter "Test_Admin" into the input field labeled "User Search:"
        And I wait for 3 seconds    
        And I click on the button labeled "Search"
        And I click on the button labeled "Edit user info" 
        And I click on the checkbox labeled "Can create project and pull medical records using Clinical Data Mart?"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."
            
    Scenario: C.3.31.3300.100 User Interface: The system shall support restricting bulk EHR data pulls by dates on project creation.
    #Create New Project with CDM Date limits
        When I click on the link labeled "New Project"
        And I select "Practice / Just for fun" on the dropdown field labeled "---- Select One ----"
        And I enter "C.3.31.3300.100" into the input field labeled "Project title:"
        And I select the radio option "Clinical Data Mart: Create a project and pull multiple medical records from EHR" for the field labeled "Project creation option:"
        And I should see "If pulling time-based data, select the range of time"
        And I enter "2017-07-01" into the input field labeled "from"
        And I enter "2017-07-31" into the input field labeled "to"
        And I click on the button labeled "select all" in the row labeled "Demographics"
        And I click on the button labeled "select all" in the row labeled "Vital Signs"
        And I click on "apply date range" in the row labeled "Vital Signs"
        And I enter "cd9e9826-aea1-4682-adc0-c1d97633bf31" into the textarea field labeled "Enter medical record numbers of patients to import from the EHR (one per line, optional)"
        And I wait for 1 second
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."

    #Requesting access token from EHR system
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.3300.100"
        And I click on the link labeled "Standalone Launch"
        And I click on the button labeled "Login"
        And I click on the button labeled "Approve"
        And I click on the link labeled "Go back to REDCap"

        When I click on the link labeled "Clinical Data Mart"
        And I should see "date range is applied"
        And I click on the button labeled "Fetch data"
        And I click on "Fetch all"
        And I click on the button labeled "Run fetch"
        And I should see "Fetching Data"
        And I should see "Completed"
        Then I should see "Demographics"
        And I should see "Vital Signs"
        And I click on "Close"

    #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Fetch data for Clinical Data Mart (granular mode)|
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 6], vitals_fhir_id = '7ea634a6-1142-4c4f-a4a1-157c58f1abd8', vitals_time = '2017-07-14 01:17', vitals_value = '96.904762289757', vitals_unit = 'kg', vitals_loinc_code = '29463-7', vitals_label = 'Body Weight', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 5], vitals_fhir_id = '2629853b-cadb-4380-98a3-9ea84ee6192b', vitals_time = '2017-07-14 01:17', vitals_value = '29.247372703006', vitals_unit = 'kg/m2', vitals_loinc_code = '39156-5', vitals_label = 'Body Mass Index', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 4], vitals_fhir_id = 'a52a9fc7-9602-42aa-be78-262010cfdb3c', vitals_time = '2017-07-14 01:17', vitals_value = '149.63431436302', vitals_unit = 'mm[Hg]', vitals_loinc_code = '8480-6', vitals_label = 'Systolic Blood Pressure', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 3], vitals_fhir_id = 'a52a9fc7-9602-42aa-be78-262010cfdb3c', vitals_time = '2017-07-14 01:17', vitals_value = '110.60053004248', vitals_unit = 'mm[Hg]', vitals_loinc_code = '8462-4', vitals_label = 'Diastolic Blood Pressure', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 2], vitals_fhir_id = '6fab7f31-2ade-434e-acea-c7b99c5536fe', vitals_time = '2017-07-14 01:17', vitals_value = '182.02419982138', vitals_unit = 'cm', vitals_loinc_code = '8302-2', vitals_label = 'Body Height', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | vitals_time = '2017-07-02 01:17', vitals_value = '37.175668772971', vitals_unit = 'Cel', vitals_loinc_code = '8331-1', vitals_label = 'Oral temperature', vital_signs_complete = '2' |
      And I should NOT see "[instance = 7],[record_id] = '1'"
    
Scenario: C.3.31.3300.200 User Interface: The system shall support restricting bulk EHR data pulls for all records when a global CDM date or datetime filter is added to the fetch request.
    #Create New Project with CDM Date limits
        Given I click on "My Projects"
        And I click on the link labeled "New Project"
        And I select "Practice / Just for fun" on the dropdown field labeled "---- Select One ----"
        And I enter "C.3.31.3300.200" into the input field labeled "Project title:"
        And I select the radio option "Clinical Data Mart: Create a project and pull multiple medical records from EHR" for the field labeled "Project creation option:"
        And I click on the button labeled "select all" in the row labeled "Demographics"
        And I click on the button labeled "select all" in the row labeled "Vital Signs"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."

    #Requesting access token from EHR system
        When I click on the link labeled "Standalone Launch"
        And I click on the button labeled "Login"
        And I click on the button labeled "Approve"
        And I click on the link labeled "Go back to REDCap"

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

        When I click on the link labeled "Clinical Data Mart"
        And I should see a button labeled "Fetch data"
        And I click on the button labeled "Request a configuration change"
        And I enter "2017-07-01" into the input field labeled "from"
        And I enter "2017-07-31" into the input field labeled "to"
        And I click on "apply date range" in the row labeled "Vital Signs"
        And I click on "Submit"
        Then I should see "date range is applied"
        When I click on the button labeled "Fetch data"
        And I click on "Fetch all"
        And I click on the button labeled "Run fetch"
        And I should see "Fetching Data"
        And I should see "Completed"
        Then I should see "Demographics"
        And I should see "Vital Signs"

    #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Fetch data for Clinical Data Mart (granular mode)|
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 6], vitals_fhir_id = '7ea634a6-1142-4c4f-a4a1-157c58f1abd8', vitals_time = '2017-07-14 01:17', vitals_value = '96.904762289757', vitals_unit = 'kg', vitals_loinc_code = '29463-7', vitals_label = 'Body Weight', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 5], vitals_fhir_id = '2629853b-cadb-4380-98a3-9ea84ee6192b', vitals_time = '2017-07-14 01:17', vitals_value = '29.247372703006', vitals_unit = 'kg/m2', vitals_loinc_code = '39156-5', vitals_label = 'Body Mass Index', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 4], vitals_fhir_id = 'a52a9fc7-9602-42aa-be78-262010cfdb3c', vitals_time = '2017-07-14 01:17', vitals_value = '149.63431436302', vitals_unit = 'mm[Hg]', vitals_loinc_code = '8480-6', vitals_label = 'Systolic Blood Pressure', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 3], vitals_fhir_id = 'a52a9fc7-9602-42aa-be78-262010cfdb3c', vitals_time = '2017-07-14 01:17', vitals_value = '110.60053004248', vitals_unit = 'mm[Hg]', vitals_loinc_code = '8462-4', vitals_label = 'Diastolic Blood Pressure', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 2], vitals_fhir_id = '6fab7f31-2ade-434e-acea-c7b99c5536fe', vitals_time = '2017-07-14 01:17', vitals_value = '182.02419982138', vitals_unit = 'cm', vitals_loinc_code = '8302-2', vitals_label = 'Body Height', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | vitals_time = '2017-07-02 01:17', vitals_value = '37.175668772971', vitals_unit = 'Cel', vitals_loinc_code = '8331-1', vitals_label = 'Oral temperature', vital_signs_complete = '2' |
        And I should NOT see "[instance = 7]"
    
Scenario: C.3.31.3300.300 User Interface: The system shall support restricting bulk EHR data pulls by date for an individual record.
   #Create New Project with CDM Date limits
        Given I click on "My Projects"
        And I click on the link labeled "New Project"
        And I select "Practice / Just for fun" on the dropdown field labeled "---- Select One ----"
        And I enter "C.3.31.3300.300" into the input field labeled "Project title:"
        And I select the radio option "Clinical Data Mart: Create a project and pull multiple medical records from EHR" for the field labeled "Project creation option:"
        And I click on the button labeled "select all" in the row labeled "Demographics"
        And I click on the button labeled "select all" in the row labeled "Vital Signs"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."

    #Requesting access token from EHR system
        When I click on the link labeled "Standalone Launch"
        And I click on the button labeled "Login"
        And I click on the button labeled "Approve"
        And I click on the link labeled "Go back to REDCap"

    # Add two records
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        And I click the bubble for the row labeled "Demography" on the column labeled "Status"
        And I enter "cd9e9826-aea1-4682-adc0-c1d97633bf31" into the input field labeled "Medical record number"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 1 successfully added."
        When I click the bubble for the row labeled "Project Settings" on the column labeled "Status"
        And I enter "2017-07-01 00:01" into the input field labeled "Start date"
        And I enter "2017-07-31 23:59" into the input field labeled "End date"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 1 successfully edited."

        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        And I click the bubble for the row labeled "Demography" on the column labeled "Status"
        And I enter "869722aa-6d3a-4afd-9acd-b4283bc7d47f" into the input field labeled "Medical record number"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 2 successfully added."
        When I click the bubble for the row labeled "Project Settings" on the column labeled "Status"
        And I enter "2017-07-01 00:01" into the input field labeled "Start date"
        And I enter "2017-07-31 23:59" into the input field labeled "End date"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 2 successfully edited."

        When I click on the link labeled "Clinical Data Mart"
        And I should see a button labeled "Fetch data"
        And I click on the button labeled "Request a configuration change"
        And I enter "2000-01-01" into the input field labeled "from"
        And I enter "2030-12-31" into the input field labeled "to"
        And I click on "apply date range" in the row labeled "Vital Signs"
        And I click on "Submit"
        Then I should see "date range is applied"
        When I click on the button labeled "Fetch data"
        And I click on "Fetch all"
        And I click on the button labeled "Run fetch"
        And I should see "Fetching Data"
        And I should see "Completed"
        Then I should see "Demographics"
        And I should see "Vital Signs"

    #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Fetch data for Clinical Data Mart (granular mode)|
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 6], vitals_fhir_id = '7ea634a6-1142-4c4f-a4a1-157c58f1abd8', vitals_time = '2017-07-14 01:17', vitals_value = '96.904762289757', vitals_unit = 'kg', vitals_loinc_code = '29463-7', vitals_label = 'Body Weight', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 5], vitals_fhir_id = '2629853b-cadb-4380-98a3-9ea84ee6192b', vitals_time = '2017-07-14 01:17', vitals_value = '29.247372703006', vitals_unit = 'kg/m2', vitals_loinc_code = '39156-5', vitals_label = 'Body Mass Index', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 4], vitals_fhir_id = 'a52a9fc7-9602-42aa-be78-262010cfdb3c', vitals_time = '2017-07-14 01:17', vitals_value = '149.63431436302', vitals_unit = 'mm[Hg]', vitals_loinc_code = '8480-6', vitals_label = 'Systolic Blood Pressure', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 3], vitals_fhir_id = 'a52a9fc7-9602-42aa-be78-262010cfdb3c', vitals_time = '2017-07-14 01:17', vitals_value = '110.60053004248', vitals_unit = 'mm[Hg]', vitals_loinc_code = '8462-4', vitals_label = 'Diastolic Blood Pressure', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | [instance = 2], vitals_fhir_id = '6fab7f31-2ade-434e-acea-c7b99c5536fe', vitals_time = '2017-07-14 01:17', vitals_value = '182.02419982138', vitals_unit = 'cm', vitals_loinc_code = '8302-2', vitals_label = 'Body Height', vital_signs_complete = '2' |
        | mm/dd/yyyy hh:mm | test_admin | Update record 1 | vitals_time = '2017-07-02 01:17', vitals_value = '37.175668772971', vitals_unit = 'Cel', vitals_loinc_code = '8331-1', vitals_label = 'Oral temperature', vital_signs_complete = '2' |
        And I should NOT see "[instance = 7]"
#END