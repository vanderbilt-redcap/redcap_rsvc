Feature: C.3.31.2100. User Interface: The system shall support importing EHR data into REDCap only after a user adjudicates and selects values in the CDP adjudication interface. 
    
    As a REDCap end user   
    I want to see that a user can adjudicate and selects values in the CDP adjudication interface.

    Scenario: Setup
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Clinical Data Interoperability Services"
        Then I should see "Clinical Data Interoperability Services"
        When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
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
        And I click on the link labeled "Home"

     #Turn on and modify CDP at the project level
        And I create a new project named "C.3.31.2100." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "CDPTESTProject.xml", and clicking the "Create Project" button
        Then I should see "C.3.31.2100."
        Then I should see a "Clinical Data Pull from EHR"
        When I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR" 
        Then I should see "Set up Clinical Data Pull from EHR"
        When I click on the button labeled "Set up mapping for Clinical Data Pull (CDP)"
        And I enter "365" into the input field labeled "Default day offset (for temporal fields):"
        And I click on the button labeled "Save"
        Then I should see "Data saved"

    #Requesting access token from EHR system
        When I click on the link labeled "Standalone Launch"
        And I wait for 2 seconds
        And I click on the button labeled "Login"
        And I click on the button labeled "Approve"

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
        And I click on the button labeled "Save"
        Then I should see "Data saved successfully!"
        Given I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 1 successfully edited."


    Scenario: C.3.31.2100. User Interface: The system shall support importing EHR data into REDCap only after a user adjudicates and selects values in the CDP adjudication interface. 
        When I click the bubble for the row labeled "Labs Vital Signs" on the column labeled "Status"
        And I enter "2017-07-14" into the input field labeled "Visit date"
        And I should see "Last fetch time: just now"
        And I click on the button labeled "Save"
        Then I should see "96.904762289757" in the data entry form field "Body weight" 
        When I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 1 successfully edited."

    #VERIFY LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action                        | List of Data Changes OR Fields Exported                              |
        | mm/dd/yyyy hh:mm | test_admin | Update record  1              | visit_date = '2017-07-14', labs_vital_signs_complete = '0'           |
        | mm/dd/yyyy hh:mm | test_admin | Update record (CDP) 1         | body_weight = '96.904762289757'                                      |

#END
