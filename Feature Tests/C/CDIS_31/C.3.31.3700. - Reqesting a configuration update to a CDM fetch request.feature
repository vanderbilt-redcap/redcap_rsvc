Feature: C.3.31.3700. User Interface: The system shall support the ability to request a configuration change in a CDM-enabled project.

    As a REDCap user I want to see that I can request a configuration change to a fetch request in a CDM-enabled project.

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
        And I enter "test_user1" into the input field labeled "User Search:"
        And I wait for 2 seconds
        And I click on "Search"
        And I click on the button labeled "Edit user info" 
        And I click on the checkbox labeled "Can create project and pull medical records using Clinical Data Mart?"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."   
        And I logout

    #Create New Project with CDM Date limits
        Given I login to REDCap with the user "Test_User1"
        And I click on "My Projects"
        And I click on the link labeled "New Project"
        And I select "Practice / Just for fun" on the dropdown field labeled "---- Select One ----"
        And I enter "C.3.31.3700" into the input field labeled "Project title:"
        And I select the radio option "Clinical Data Mart: Create a project and pull multiple medical records from EHR" for the field labeled "Project creation option:"
        And I click on the "select all" in the row labeled "Vital Signs"
        And I click on the "select all" in the row labeled "Demographics"
        And I enter "cd9e9826-aea1-4682-adc0-c1d97633bf31" into the textarea field labeled "Enter medical record numbers of patients to import from the EHR (one per line, optional)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."

    #User rights: Adding admin.
        When I click on the link labeled "User Rights"
        And I enter "Test_Admin" into the field with the placeholder text of "Add new user"
        And I click on the button labeled "Add with custom rights"
        And I check the User Right named "Create Records"
        And I check the User Right named "Logging"
        And I click on the button labeled "Add user"
        Then I should see "test_admin"
        And I logout

    #Enabling users can request changes to their Data Mart configuration
        Given I login to REDCap with the user "Test_Admin"
        And I click on "My Projects"
        And I click on the link labeled "C.3.31.3700"
        And I click on the button labeled "Enable" in the row labeled "Users can request changes to their Data Mart configuration" 
        Then I should see "Disable" in the row labeled "Users can request changes to their Data Mart configuration"

    #Process CDM Request on To-Do List
        And I click on the link labeled "Control Center"
        And I click on the link labeled "To-Do List"
        And I click on the icon labeled "Approve request"
        And I click on the button labeled "Approve" 
        Then I should see "the revision was approved"        
        And I logout

    #Requesting access token from EHR system
        Given I login to REDCap with the user "Test_User1"
        And I click on "My Projects"
        And I click on the link labeled "C.3.31.3700"
        When I click on the link labeled "Standalone Launch"
        And I wait for 2 seconds
        And I click on the button labeled "Login"
        And I click on the button labeled "Approve"
        And I wait for 5 seconds
        Then I should see "C.3.31.3700"

Scenario: C.3.31.3700. User Interface: The system shall support the ability to request a configuration change in a CDM-enabled project.
        When I click on the link labeled "Clinical Data Mart"
        And I should see a button labeled "Fetch data"
        And I click on the button labeled "Request a configuration change"
        And I enter "2017-07-01" into the input field labeled "from"
        And I enter "2017-07-31" into the input field labeled "to"
        And I click on "apply date range" in the row labeled "Vital Signs"
        And I click on the button labeled "Submit"
        Then I should see "Revision submitted"
     #VERIFY_LOG 
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date | Username | Action | List of Data Changes OR Fields Exported |
        | mm/dd/yyyy hh:mm | test_user1| Manage/Design | Send request to approve a Clinical Data Mart Revision|
        | mm/dd/yyyy hh:mm | test_user1| Manage/Design | Update Clinical Data Mart revision|

    #Verify CDM Revision is on the To-Do List
		Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "To-Do List"
        Then I should see "Pending Requests"
        And I should see "Clinical Data Mart revision"
        And I should see "test_user1"
#END