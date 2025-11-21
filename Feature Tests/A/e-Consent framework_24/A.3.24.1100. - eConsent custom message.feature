Feature: Control Center: The system shall allow optional adding of a custom message on the e-Consent Framework setup page of every project.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: A.3.24.1100.100 Custom message on the e-Consent Framework setup page of every project
        #Create custom message
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Modules/Services Configuration"
        Then I should see "e-Consent Framework"

        When I enter "My custom message" into the textarea field labeled "Custom message for e-Consent Framework settings"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        #SETUP
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        And I create a new project named "A.3.24.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button

    Scenario: Verify institutional custom message in framework
        #VERIFY institutional custom message in framework
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        And I click on the button labeled "Enable the e-Consent Framework for a survey"
        Then I should see a dialog containing the following text: "Enable e-Consent for a Survey"

        Given I select '"Participant Consent" (participant_consent)' in the dropdown field labeled "Enable e-Consent for a Survey" in the dialog box
        Then I should see "Enable e-Consent"
        And I should see "Primary settings"
        And I should see "My custom message"
#END