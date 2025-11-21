Feature: User Interface: The system shall support the e-Consent Framework to search within e-Consent framework settings.

   As a REDCap end user
   I want to see that eConsent is functioning as expected

   Scenario: C.3.24.2100.100 e-Consent Framework search
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.2100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box
      Then I should see "Project status:  Production"

      #FUNCTIONAL_REQUIREMENT
      ##ACTION: e-consent search
      When I click on the link labeled "Designer"
      And I click on the button labeled "e-Consent"
      Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey                |
            | [x]               | Participant Consent   |
            | [x]               | Coordinator Signature |

      Given I should see '"Coordinator Signature" (coordinator_signature)'
      When I enter "Participant Consent" into the input field labeled "Search"
      Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey              |
            | [x]               | Participant Consent |
      And I should NOT see '"Coordinator Signature" (coordinator_signature)'

      ##ACTION: clear search
      When I clear the field labeled "Search"
      Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey              |
            | [x]               | Participant Consent |
            | [x]               | Coordinator Signature |
#END