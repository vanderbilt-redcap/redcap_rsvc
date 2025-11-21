Feature: Control Center: The system shall support capturing the IP address of survey participants that certify the e-Consent process and store their IP in the File Repository table.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: A.3.24.1000.100 Enable IP address capture for e-Consent
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        And I create a new project named "A.3.24.1000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #Verify IP status
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see "IP Address"
        And I should see a table header and rows containing the following values in a table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed | File Storage Time | Identifier (Name, DOB) | IP Address | Version | Type | Size |

 Scenario: Do capture IP address
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Modules/Services Configuration"
        Then I should see "e-Consent Framework"

        When I select "Do NOT capture IP address" on the dropdown field labeled "Capture the IP address" 
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.3.24.1000.100"
               #Verify IP status
        And I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should NOT see "IP Address"
        And I should see a table header and rows containing the following values in a table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed | File Storage Time | Identifier (Name, DOB) | Version | Type | Size |
        
      Scenario: Do NOT capture IP address
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Modules/Services Configuration"
        Then I should see "e-Consent Framework"

        When I select "Capture IP address" on the dropdown field labeled "Capture the IP address"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.3.24.1000.100"
               #Verify IP status
        And I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see "IP Address"
        And I should see a table header and rows containing the following values in a table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed | File Storage Time | Identifier (Name, DOB) | IP Address | Version | Type | Size |
#END