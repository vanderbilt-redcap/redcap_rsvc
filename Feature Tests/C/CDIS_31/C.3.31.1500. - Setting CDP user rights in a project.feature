Feature: C.3.31.1500. Project Setup: The system shall support assigning user privileges for CDP mapping setup and data adjudication roles within a project.

    As a REDCap end user
    I want to see that a project can have Clinical Data Pull (CDP) user rights enabled and disabled.

    Scenario: C.3.31.1500. Project Setup: The system shall support assigning user privileges for CDP mapping setup and data adjudication roles within a project.
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
        And I create a new project named "C.3.31.1500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "CDPTESTProject.xml", and clicking the "Create Project" button
        Then I should see "C.3.31.1500"
        Then I should see a "Clinical Data Pull from EHR"
        When I click on the button labeled "Enable" in the row labeled "Clinical Data Pull from EHR" 
        Then I should see "Set up Clinical Data Pull from EHR"
        
    #SETUP_USER_RIGHTS (Without CDIS Rights)
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see a dialog containing the following text: "Adding new user"
        When I click on the checkbox labeled "Project Design and Setup"
        And I click on the button labeled "Add user"
        Then I should see 'User "Test_User1" was successfully added'
        
    #VERIFY LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported   |
        | mm/dd/yyyy hh:mm | test_admin | Add user      | user = 'Test_User1'                       |
        And I logout

    #Verify User can't access CDP features
        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.1500"
        Then I should see a button "Set up Clinical Data Pull from EHR" that is disabled
        Then I should see a button labeled "Set up mapping for Clinical Data Pull (CDP)" that is disabled
        And I logout
        
    #Adding CDP mapping right
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.1500"
        And I click on the link labeled "User Rights"
        And I click on the link labeled "Test User1"
        And I click on the button labeled "Edit user privileges"
        And I check the checkbox labeled "Setup / Mapping"
        And I click on the button labeled "Save Changes"
        Then I should see 'User "test_user1" was successfully edited'
    #VERIFY LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action                        | List of Data Changes OR Fields Exported   |
        | mm/dd/yyyy hh:mm | test_admin | Update user test_user1        | user = 'test_user1'                       |
        And I logout

    #Verify User can access CDP setup and mapping page
        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.1500"
        And I click on the button labeled "Set up mapping for Clinical Data Pull (CDP)"
        Then I should see "Clinical Data Pull from EHR"
        Given I click on the link labeled "Setup"
        And I logout
    
    #Adding CDP adjudication right
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.1500"
        And I click on the link labeled "User Rights"
        And I click on the link labeled "Test User1"
        And I click on the button labeled "Edit user privileges"
        And I check the checkbox labeled "Adjudicate Data"
        And I check the User Right named "Logging"
        And I click on the button labeled "Save Changes"
        Then I should see 'User "test_user1" was successfully edited'

    #VERIFY LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action                        | List of Data Changes OR Fields Exported   |
        | mm/dd/yyyy hh:mm | test_admin | Update user test_user1        | user = 'test_user1'                       |
        | mm/dd/yyyy hh:mm | test_admin | Update user test_user1        | user = 'test_user1'                       |
        And I logout

    #Verify User can add test patient and adjudicate the data.
        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.1500"
        And I click on the link labeled "Standalone Launch"
        And I wait for 1 second
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
        When I click on the button labeled "Save"
        Then I should see "Saving adjudicated data..."
        When I click on the icon labeled "More save options"
        And I click on the link labeled "Save & Exit Form"
        Then I should see "Study ID 1 successfully edited."
        And I logout

    #VERIFY LOG
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.31.1500"    
        And I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action                        | List of Data Changes OR Fields Exported   |
        | mm/dd/yyyy hh:mm | test_user1 | Update record (CDP) 1         | first_name = 'Morris', last_name = 'Lockman', dob = '1970-12-24'                  |

#END
