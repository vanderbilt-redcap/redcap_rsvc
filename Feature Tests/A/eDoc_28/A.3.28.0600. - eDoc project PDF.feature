Feature: Project Settings: The system shall allow project-level enabling or disabling of external storage for non-e-Consent governed PDF Snapshots containing completed e-Consent responses.
  As a REDCap administrator
  I want to control whether non-e-Consent governed snapshots are stored externally
  So that storage behavior aligns with regulatory and institutional policies

  Scenario: A.3.28.0600.100 Verify default behavior (ON) for new projects
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.3.28.0600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    #VERIFY default setting ON
    When I click on the link labeled "Edit Project Settings"
    Then I should see the dropdown field labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server" with the option "Enabled" selected

  Scenario: A.3.28.0600.200 Disable External Storage for non-e-Consent governed snapshots
    Then if running via automation, start sftp server
    #ACTION: Disable setting
    And I select "Disabled" on the dropdown field labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved"
    #ACTION: Add a new record with a completed e-Consent
    When I click on the link labeled "My Projects"
    And I should see "Listed below are the REDCap projects"
    And I click on the link labeled "A.3.28.0600.100"
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Given I click on the link labeled "Add signature"
    And I should see "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    #VERIFY: Snapshot is stored in File Repository only
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid13_formParticipantConsent_id1_"
    Then I should NOT see a file on the External Storage server whose name contains "pid13_formParticipantConsent_id1_"

  Scenario: A.3.28.0600.300 Enable External Storage for non-e-Consent governed snapshots
    #ACTION: Re-enable setting
    When I click on the link labeled "Setup"
    When I click on the link labeled "Edit Project Settings"
    And I select "Enabled" on the dropdown field labeled "Store non-e-Consent governed PDF Snapshots on the External Storage server"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved"
    #ACTION: Configure external storage location
    When I click on the link labeled "Modules/Services Configuration"
    And I select "SFTP" on the second dropdown field labeled "Enable the external storage device and choose storage method"
    #Manual: The following hostname & credentials will only work for automation.  To test this manually you'll need access to an STFP server at your site.
    #Manual: Other options besides SFTP must currently be tested manually, though they could likely be automated.
    And I enter "redcap_docker-sftp-1" into the third input field labeled "Server hostname"
    And I enter "sftp-user" into the third input field labeled "Server username"
    And I enter "sftp-password" into the third input field labeled "Server password"
    And I enter "upload" into the third input field labeled "Server directory to store files"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    #ACTION: Add another record with a completed e-Consent
    When I click on the link labeled "My Projects"
    And I should see "Listed below are the REDCap projects"
    And I click on the link labeled "A.3.28.0600.100"
    And I click on the link labeled "Survey Distribution Tools"
    And I click on the button labeled "Open public survey"
    Given I click on the link labeled "Add signature"
    And I should see "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature"
    Then I should see a link labeled "Remove signature"
    And I click on the button labeled "Next Page"
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    #VERIFY: Snapshot is stored in File Repository
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    Then I should see "pid13_formParticipantConsent_id2_"
    Then I should see a file on the External Storage server whose name contains "pid13_formParticipantConsent_id2_"
    And if running via automation, stop sftp server
#END
