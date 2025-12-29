Feature: C.3.31.2600. User Interface: The system shall support displaying a count of new unadjudicated values from the EHR for each record in a CDP-enabled project.

    As a REDCap end user
    I want to see that a project can support displaying a count of new unadjudicated values from the EHR.

    Scenario: SETUP project with CDP enabled
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
        And I enter "1" into the input field labeled "Time interval that REDCap will check the source system for new data for individual records"
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
        And I click on the link labeled "Home"
        And I logout

     #Turn on CDP at the project level
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.31.2600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "CDPTESTProject.xml", and clicking the "Create Project" button
        Then I should see "C.3.31.2600"
        Then I should see a "Clinical Data Pull from EHR"
        When I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR" 
        Then I should see "Set up Clinical Data Pull from EHR"

    #VERIFY LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported   |
        | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Enable Clinical Data Pull (CDP) module    |

    Scenario: C.3.31.2600. User Interface: The system shall support displaying a count of new unadjudicated values from the EHR for each record in a CDP-enabled project.
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.2600"
        And I click on the link labeled "Standalone Launch"
        And I wait for 2 seconds
        And I click on the button labeled "Login"
        And I click on the button labeled "Approve"
        And I wait for 15 seconds 
        Then I should see "C.3.31.2600"
    
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        And I click the bubble for the row labeled "Demography" on the column labeled "Status"
        And I enter "cd9e9826-aea1-4682-adc0-c1d97633bf31" into the input field labeled "Medical record number"
        And I click on the button labeled "Save"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Study ID 1 successfully added."
        When I click the bubble for the row labeled "Labs Vital Signs" on the column labeled "Status"
        And I enter "2017-07-14" into the input field labeled "Visit date" 
        Then I should see "Adjudicate data from External System"
        And I click on the button labeled "Cancel"
    #Validation of count of new unadjudicated values
        Then I should see "5 new items from source system"

        
#END
