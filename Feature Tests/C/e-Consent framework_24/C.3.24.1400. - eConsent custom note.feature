Feature: User Interface: The system shall support the e-Consent Framework to create optional custom notes for reference and documentation purposes.

 As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.1400.100 - eConsent Framework custom note
      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "C.3.24.1400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

      #SETUP_PRODUCTION
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far"
      And I click on the button labeled "YES, Move to Production Status"
      Then I should see "Project status:  Production"

      #SETUP_eConsent for participant consent process
      When I click on the link labeled "Designer"
      And I click on the button labeled "e-Consent"
      And I click on the button labeled "Enable the e-Consent Framework for a survey"
      And I select '"Participant Consent" (participant_consent)' in the dropdown field labeled "Enable e-Consent for a Survey"
      Then I should see "Enable e-Consent"
      And I should see "Primary settings"

      When I enter "My custom note" into the input field labeled "Notes:"
      And I click on the button labeled "Save settings"
      Then I should see a table header and rows containing the following values in a table:
         | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot    | Custom tag/category | Notes          |
         | [x]               | "Participant Consent" (participant_consent) | File Repository                                    | Participant         | My custom note |
#END