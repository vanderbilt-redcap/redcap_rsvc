Feature: D.3.31.0700. Control Center: The system shall support converting source system timestamps from GMT to local server time.

    As a REDCap end user
    I want to see that a project shall support converting source system timestamps from GMT to local server time.

    Scenario: D.3.31.0700. The system shall support converting source system timestamps from GMT to local server time.
    #Activate CDIS Settings
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Clinical Data Interoperability Services"
    Then I should see "Clinical Data Interoperability Services"
    When I select "Enable" on the dropdown field labeled "Clinical Data Pull"
    And I select "Yes, convert timestamps to local time from GMT" on the dropdown field labeled "Convert source system timestamps from GMT to local server time?"

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
    And I create a new project named "D.3.31.0700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "CDPTESTProject.xml", and clicking the "Create Project" button
    Then I should see "D.3.31.0700"
    Then I should see a "Clinical Data Pull from EHR"
    When I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR" 
    Then I should see "Set up Clinical Data Pull from EHR"
    When I click on the button labeled "Set up mapping for Clinical Data Pull (CDP)"
    And I enter "365" into the input field labeled "Default day offset (for temporal fields):"
    And I click on the button labeled "Save"
    Then I should see "Data saved"

    When I click on the link labeled "Standalone Launch"
    And I wait for 2 seconds
    And I click on the button labeled "Login"
    And I click on the button labeled "Approve"
    And I click on the link labeled "Add / Edit Records"
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
    When I click on the button labeled "Save"
    Then I should see "Saving adjudicated data..."
    And I verify "Morris" is within the input field labeled "First Name"
    And I verify "Lockman" is within the input field labeled "Last Name"
    When I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Study ID 1 successfully edited."

    When I click the bubble for the row labeled "Labs Vital Signs" on the column labeled "Status"
    And I enter "2017-07-14" into the input field labeled "Visit date"
    #Verify Temporal data does appear when a date is entered
    Then I should see "Body weight"
    And I should see "96.904762289757"
    And I should see "Sodium (Na)"
    And I should see "143.57605784691"
    And I click on the button labeled "Save"
    And I wait for 1 second
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Study ID 1 successfully edited."

    When I click on the link labeled "Control Center"
    And I click on the link labeled "Clinical Data Interoperability Services"
    And I select "No, leave timestamps as they are" on the dropdown field labeled "Convert source system timestamps from GMT to local server time?"
    And I click on the button labeled "Save Changes"

    When I click on the link labeled "My Projects"
    And I click on the link labeled "D.3.31.0700"

    And I click on the link labeled "Add / Edit Records"
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
    When I click on the button labeled "Save"
    Then I should see "Saving adjudicated data..."
    And I verify "Morris" is within the input field labeled "First Name"
    And I verify "Lockman" is within the input field labeled "Last Name"
    When I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Study ID 2 successfully edited."

    When I click the bubble for the row labeled "Labs Vital Signs" on the column labeled "Status"
    And I enter "2017-07-14" into the input field labeled "Visit date"
    #Verify Temporal data does appear when a date is entered
    Then I should see "Body weight"
    And I should see "96.904762289757"
    And I should see "Sodium (Na)"
    And I should see "143.57605784691"
    And I click on the button labeled "Save"
    And I wait for 1 second
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    Then I should see "Study ID 2 successfully edited."

    And I logout 