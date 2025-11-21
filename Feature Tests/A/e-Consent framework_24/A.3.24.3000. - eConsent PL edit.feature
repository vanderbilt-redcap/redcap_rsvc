Feature: A.3.24.3000. The system shall support the ability for administrators to enable or disable the option allowing users to edit e-Consent responses within the Project Settings.
    As a REDCap end user
    I want to see that the e-Consent Framework is functioning as expected

  Scenario: A.3.24.3000.100 Show/Hide the e-Consent Framework via Control Center
        #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.3.24.3000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentNoSetup.xml", and clicking the "Create Project" button
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.24.3000.100"

  Scenario: #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

  Scenario: #FUNCTIONAL_REQUIREMENT
        ##ACTION: Hide e-Consent Framework option
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Settings pertaining to the External Module Framework"
    When I select "Hide e-Consent Framework option" on the dropdown field labeled "Display 'e-Consent Framework' option for ALL surveys?"
    And I wait for 1 second
    And I click on the button labeled "Save Changes"
        ##VERIFY e-Consent Framework is hidden
    Then I should see "Your system configuration values have now been changed!"

  Scenario: ##VERIFY e-Consent Framework is hidden
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.24.3000.100"
    When I click on the link labeled "Designer"
    Then I should NOT see a button labeled "e-Consent"

  Scenario: #FUNCTIONAL_REQUIREMENT
        ##ACTION: Show e-Consent Framework option
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Settings pertaining to the External Module Framework"
    When I select "Show e-Consent Framework option (recommended)" on the dropdown field labeled "Display 'e-Consent Framework' option for ALL surveys?"
    And I wait for 1 second
    And I click on the button labeled "Save Changes"
        ##VERIFY e-Consent Framework is showing
    Then I should see "Your system configuration values have now been changed!"

  Scenario: ##VERIFY e-Consent Framework is showing
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.24.3000.100"
    When I click on the link labeled "Designer"
    Then I should see a button labeled "e-Consent"
    Given I logout
#END

  Scenario: A.3.24.3000.200 Capture/Do not Capture the IP address via the e-Consent Framework in the Control Center
        #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I create a new project named "A.3.24.3000.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.24.3000.200"

  Scenario: #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

  Scenario: #FUNCTIONAL_REQUIREMENT Capture IP Address
        ##ACTION: Capture the IP Address in the e-Consent Framework option
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Settings pertaining to the External Module Framework"
    When I select "Capture IP address" on the dropdown field labeled "Capture the IP address of survey participants that certify the e-Consent process, and store their IP in the File Repository table."
    And I wait for 1 second
    And I click on the button labeled "Save Changes"
        ##VERIFY IP Address is being Captured via the e-Consent Framework
    Then I should see "Your system configuration values have now been changed!"

  Scenario: Add record
    ##ACTION: add record with consent framework
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.24.3000.200"
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
    Then I should see "Adding new Record ID 1."

  Scenario:
    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Okay" in the dialog box
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    Then I should see "Please complete the survey"

  Scenario:
    When I clear field and enter "FirstName" into the input field labeled "First Name"
    And I clear field and enter "LastName" into the input field labeled "Last Name"
    And I clear field and enter "email@test.edu" into the input field labeled "email"
    And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
    And I enter "MyName" into the input field labeled "Participant's Name Typed"
    Given I click on the link labeled "Add signature"
    And I see a dialog containing the following text: "Add signature"
    And I draw a signature in the signature field area
    When I click on the button labeled "Save signature" in the dialog box
    Then I should see a link labeled "Remove signature"

  Scenario:
    When I click on the button labeled "Next Page"
    Then I should see "Displayed below is a read-only copy of your survey responses."
    And I should see the button labeled "Submit" is disabled

  Scenario:
    When I check the checkbox labeled "I certify that all of my information in the document above is correct."
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey."

  Scenario:
    When I click on the button labeled "Close survey"
    And I return to the REDCap page I opened the survey from
    And I click on the link labeled "Record Status Dashboard"
    Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

  Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    And I should see "IP Address"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)         | IP Address      | Version | Type                  |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 |                 |         | e-Consent Participant |

  Scenario: #FUNCTIONAL_REQUIREMENT Do NOT capture IP Address
        ##ACTION: Do not capture the IP Address in the e-Consent Framework option
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Settings pertaining to the External Module Framework"
    When I select "Do NOT capture IP address" on the dropdown field labeled "Capture the IP address of survey participants that certify the e-Consent process, and store their IP in the File Repository table."
    And I wait for 1 second
    And I click on the button labeled "Save Changes"
        ##VERIFY IP Address is not being Captured via the e-Consent Framework
    Then I should see "Your system configuration values have now been changed!"

  Scenario: ##VERIFY_FiRe
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.24.3000.200"
    When I click on the link labeled "File Repository"
    And I click on the link labeled "PDF Snapshot Archive"
    And I should NOT see "IP Address"
    Then I should see a table header and rows containing the following values in a table:
      | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB)         | Version | Type                  |
      | .pdf |                                  |      1 | Participant Consent (Event 1 (Arm 1: Arm 1)) | FirstName LastName, 2000-01-01 |         | e-Consent Participant |

  Scenario: A.3.24.3000.300 Add a custom message via e-Consent Framework in the Control Center
        #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I create a new project named "A.3.24.3000.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.24.3000.300"

  Scenario: #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

  Scenario: #FUNCTIONAL_REQUIREMENT Custom Message on e-Consent Framework
        ##ACTION: Add a Custom Message in the e-Consent Framework option
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Modules/Services Configuration"
    Then I should see "Settings pertaining to the External Module Framework"
    When I enter "If you are using the e-Consent Framework, the IRB must see you final version and you must use the stamped version of the IRB Approval" into the textarea field labeled "Custom message for e-Consent Framework settings (optional)"
    And I wait for 1 second
    And I click on the button labeled "Save Changes"

  Scenario: ##VERIFY I Custom message appears at the bottom of the Modify Setting window  in the e-Consent Framework
    Then I should see "Your system configuration values have now been changed!"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.3.24.3000.300"
    When I click on the link labeled "Designer"
    And I click on the button labeled "e-Consent"
    And I click on the icon in the column labeled "Edit settings" and the row labeled "Participant Consent"
    Then I should see "If you are using the e-Consent Framework, the IRB must see you final version and you must use the stamped version of the IRB Approval"
#END