Feature: Control Center: The system shall support the option to display or hide the 'e-Consent Framework' for all surveys.

       As a REDCap end user
       I want to see that eConsent is functioning as expected

       Scenario: A.3.24.0900.100 Display/Hide e-Consent Framework for all surveys
              #SETUP
              Given I login to REDCap with the user "Test_Admin"
              #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
              And I create a new project named "A.3.24.0900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
              And I click on the link labeled "Designer"
              #Verify econsent framework enabled
              Then I should see "e-Consent"

              When I click on the button labeled "e-Consent"
              Then I should see "e-Consent Framework Settings"
              And I should see "PDF Snapshots of Records"

              When I click on the link labeled "PDF Snapshots of Records"
              Then I should see "Triggers for PDF Snapshots"

       #SETUP_CONTROL_CENTER
       Scenario: #Disable framework
              When I click on the link labeled "Control Center"
              And I click on the link labeled "Modules/Services Configuration"
              Then I should see "e-Consent Framework"

              When I select "Hide e-Consent Framework option" on the dropdown field labeled "Display 'e-Consent Framework' option for ALL surveys?" 
              And I click on the button labeled "Save Changes"
              Then I should see "Your system configuration values have now been changed!"

              When I click on the link labeled "My Projects"
              And I click on the link labeled "A.3.24.0900.100"
              And I click on the link labeled "Designer"
              #Verify econsent framework disabled
              And I should NOT see "e-Consent"

              Then I should see "PDF Snapshots"
              When I click on the button labeled "PDF Snapshots"
              Then I should see "PDF Snapshots of Records"

       #SETUP_CONTROL_CENTER
       Scenario: #Enable e-Consent Framework
              When I click on the link labeled "Control Center"
              And I click on the link labeled "Modules/Services Configuration"
              Then I should see "e-Consent Framework"


              When I select "Show e-Consent Framework option (recommended)" on the dropdown field labeled "Display 'e-Consent Framework' option for ALL surveys?" 
              And I click on the button labeled "Save Changes"
              Then I should see "Your system configuration values have now been changed!"

              When I click on the link labeled "My Projects"
              And I click on the link labeled "A.3.24.0900.100"
              And I click on the link labeled "Designer"
              #Verify econsent framework enabled
              Then I should see "e-Consent"

              When I click on the button labeled "e-Consent"
              Then I should see "e-Consent Framework Settings"
              And I should see "PDF Snapshots of Records"

              When I click on the link labeled "PDF Snapshots of Records"
              Then I should see "Triggers for PDF Snapshots"
#END