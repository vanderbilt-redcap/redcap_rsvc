Feature: A.3.24.3000. The system shall support the ability for administrators to enable or disable the option allowing users to edit e-Consent responses within the Project Settings.
    As a REDCap end user
    I want to see that the e-Consent Framework is functioning as expected

  Scenario: A.3.24.3000.100 Enable/disable edit ability for e-Consent framework
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.3.24.3000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Project status:  Production"

    Scenario: #SETUP_eConsent to NOT allow for edit by users
        ##SETUP Allow e-Consent responses to be edited by users?
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey              |
            | [x]               | Participant Consent |

        When I click on the icon in the column labeled "Edit settings" and the row labeled "Participant Consent"
        When I should see a checkbox labeled "Allow e-Consent responses to be edited by users?" that is unchecked
        And I select 'part_sign "Participant signature field"' in the dropdown field labeled "Signature field #1"
        And I check the checkbox labeled "Save to specified field"
        And I select "participant_file" in the dropdown field labeled "Save to specified field:"
        And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
        And I click on the button labeled "Save settings"
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey              |
            | [x]               | Participant Consent |
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot | Custom tag/category | Notes |
            | [x]               | "Participant Consent" (participant_consent) | File Repository                                 |                     |       |

    Scenario: add record with consent framework
        ##ACTION: add record with consent framework
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 1."

        When I click on the button labeled "More save options"
        And I click on the link labeled "Save & Stay"
        And I click on the button labeled "Okay"
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        Then I should see "Please complete the survey"

        When I clear field and enter "FirstName" into the input field labeled "First Name"
        And I clear field and enter "LastName" into the input field labeled "Last Name"
        And I clear field and enter "email@test.edu" into the input field labeled "email"
        And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
        And I enter "MyName" into the input field labeled "Participant's Name Typed"
        
        Given I click on the link labeled "Add signature"
        And I should see "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature"
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see the button labeled "Submit" that is disabled

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        And I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        And I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "1"

    Scenario: User unable to edit consent
        ##ACTION: User unable to edit consent
        When I locate the bubble for the "Participant Consent" instrument on event "Event 1" for record ID "1" and click on the bubble
        Then I should see "Survey response is read-only because it was completed via the e-Consent Framework."
        And I should NOT see a button labeled "Edit response"

    Scenario: #SETUP_eConsent to allow for edit by users
        ##SETUP Allow e-Consent responses to be edited by users?
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        And I wait for 1 second
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey              |
            | [x]               | Participant Consent |

        When I click on the icon in the column labeled "Edit settings" and the row labeled "Participant Consent"
        When I check the checkbox labeled "Allow e-Consent responses to be edited by users?"
        And I select 'part_sign "Participant signature field"' in the dropdown field labeled "Signature field #1"
        And I check the checkbox labeled "Save to specified field"
        And I select "participant_file" in the dropdown field labeled "Save to specified field:"
        And I select "Event 1 (Arm 1: Arm 1)" in the dropdown field labeled "Save to specified field:"
        And I click on the button labeled "Save settings"
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey              |
            | [x]               | Participant Consent |

    Scenario: User able to edit consent
        ##ACTION: User able to edit consent
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Participant Consent" instrument on event "Event 1" for record ID "1" and click on the bubble
        Then I should see "Survey response is editable"
        And I should see a button labeled "Edit response"
#END