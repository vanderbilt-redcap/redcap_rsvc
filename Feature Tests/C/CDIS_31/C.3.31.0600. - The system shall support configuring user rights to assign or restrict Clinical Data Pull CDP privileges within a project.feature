Feature: C.3.31.0600. Control Center: The system shall support configuring user rights to assign or restrict Clinical Data Pull (CDP) privileges within a project.
    
#SETUP #Manual Test_Admin must give CDP User rights to Test_user1 first

Scenario: C.3.31.0600. Control Center: The system shall support configuring user rights to assign or restrict Clinical Data Pull (CDP) privileges within a project.
Given I login to REDCap with the user "Test_Admin"
#Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")

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

    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.3.31.0600" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_7.31.xml", and clicking the "Create Project" button
    And I click on the link labeled "My Projects"
    And I click on the link labeled "C.3.31.0600"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

#ACTION Enable CDP in Project
    When I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR"
    Then I should see "Set up Clinical Data Pull from EHR"

#FUNCTIONAL REQUIREMENT
##ACTION: Add User with Basic custom rights for CDP
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: "Adding new user"
    When I click on the checkbox labeled "Project Design and Setup"
    And I click on the checkbox labeled "Setup / Mapping"
    And I ckick on the checkbox labeled "Adjudicate Data"
    And I check the User Right named "Logging"
    And I click on the button labeled "Add user"

    ##VERIFY_LOG: Verify Update user rights
    And I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
    | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
    | mm/dd/yyyy hh:mm | test_admin | Add user      | user = 'Test_User1' |
    | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Enable Clinical Data Pull (CDP) module|


##ACTION: Add User2 with no Basic custom rights for CDP

    When I click on the link labeled "User Rights"
    And I enter "Test_User2" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: "Adding new user"

    When I check the checkbox labeled "Project Design and Setup"
    And I uncheck the checkbox labeled "Setup / Mapping"
    And I uncheck the checkbox labeled "Adjudicate Data"
    And I check the checkbox labeled "Logging"
    And I click on the button labeled "Add user" 
    And I click on the link labeled "Project Home" 
    And I logout

    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "Project Setup"
    Then I should see "Set up Clinical Data Pull from EHR"
    And I logout

    Given I login to REDCap with the user "Test_User2"

#ACTION Enable CDP in Project (Button is Grayed out for Test User 2)
    Then I should see a button labeled "Set up mapping for Clinical Data Pull (CDP)" that is disabled

#END