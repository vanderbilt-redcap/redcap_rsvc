Feature: User Interface: The e-Consent framework shall support editing of responses by users.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0605.100 Enable/disable edit ability for e-Consent framework

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0605.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"


    Scenario: #SETUP_eConsent to NOT allow for edit by users
        ##SETUP Allow e-Consent responses to be edited by users?
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey              |
            | [x]               | Participant Consent |

        When I click on the icon in the column labeled "Edit settings" and the row labeled "Participant Consent"
        When I uncheck the checkbox labeled "Allow e-Consent responses to be edited by users?"
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

        When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        Then I should see "Please complete the survey"

        When I clear field and enter "FirstName" into the input field labeled "Name"
        And I clear field and enter "LastName" into the input field labeled "Name"
        And I clear field and enter "email@test.edu" into the input field labeled "email"
        And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
        And I enter "MyName" into the input field labeled "Participant's Name Typed"
        
        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see the button labeled "Submit" is disabled

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
        Then I should see a table header and rows containing the following values in a table:
            | e-Consent active? | Survey                                      | Location(s) to save the signed consent snapshot | Custom tag/category | Notes |
            | [x]               | "Participant Consent" (participant_consent) | File Repository                                 |                     |       |

    Scenario: add record with consent framework
        ##ACTION: add record with consent framework
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 2."

        When I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        Then I should see "Please complete the survey"

        When I clear field and enter "FirstName" into the input field labeled "Name"
        And I clear field and enter "LastName" into the input field labeled "Name"
        And I clear field and enter "email@test.edu" into the input field labeled "email"
        And I clear field and enter "2000-01-01" into the input field labeled "Date of Birth"
        And I enter "MyName" into the input field labeled "Participant's Name Typed"
        
        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see the button labeled "Submit" is disabled

        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        And I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."

        When I click on the button labeled "Close survey"
        And I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1" for record "2"

    Scenario: Test ability to for user to edit a completed consent
        ##ACTION: Test ability to for user to edit a completed consent
        When I locate the bubble for the "Participant Consent" instrument on event "Event 1" for record ID "1" and click on the bubble
        Then I should see "Survey response is editable"

        When I click on the button labeled "Edit response"
        Then I should see "(now editing)"

        When I clear field and enter "NewFirstName" into the input field labeled "First Name"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 1"
        And I wait for 1 second
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" longitudinal instrument on event "Event 1"

        When I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Survey response is editable"
        And I verify "NewFirstName" is within the input field labeled "First Name" in the dialog box


    Scenario: Verification e-Consent saved and logged correctly
        ##VERIFY_FiRe
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows containing the following values in a table:
            | Name | PDF utilized e-Consent Framework | Record | Survey Completed                             | Identifier (Name, DOB) | Version | Type      |
            | .pdf |                                  | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) | 2000-01-01             |         | e-Consent |
            | .pdf |                                  | 1      | Participant Consent (Event 1 (Arm 1: Arm 1)) | 2000-01-01             |         | e-Consent |


        When I click on the link labeled "pid13_formParticipantConsent_id1"
        Then I should see the following values in the last file downloaded
          | \n2)First NameFirstName \n3) |

        When I click on the link labeled "pid13_formParticipantConsent_id2"
        Then I should see the following values in the last file downloaded
          | \n2)First NameFirstName \n3) |
        #NOTE: Edited version with "NewFirstName" is NOT in the file repository.
        #Manual: Close document

        ##VERIFY_Logging
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username            | Action                                     | List of Data Changes OR Fields Exported                                                                                                                    |
            | test_admin          | Update record 1 (Event 1 (Arm 1: Arm 1))   | first_name = 'NewFirstName'                                                                                                                                |
            | [survey respondent] | Save PDF Snapshot 2                        | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "2" event = "event_1_arm_1" instrument = "participant_consent"  |
            | [survey respondent] | e-Consent Certification 2                  | e-Consent Certification record = "1" identifier = "email@test.edu" consent_form_version = "1.0" event = "event_1_arm_1" instrument = "participant_consent" |
            | [survey respondent] | Update Response 2 (Event 1 (Arm 1: Arm 1)) | last_name = 'LastName', type_sign1 = 'MyName' |
            | [survey respondent] | Save PDF Snapshot 2                        | Save PDF Snapshot to File Upload Field field = "participant_file (event_1_arm_1)" record = "1" event = "event_1_arm_1" instrument = "participant_consent"  |
            | [survey respondent] | e-Consent Certification 1                  | e-Consent Certification record = "1"  event = "event_1_arm_1" instrument = "participant_consent"                                                           |
            | [survey respondent] | Update Response 1 (Event 1 (Arm 1: Arm 1)) | last_name = 'LastName', type_sign1 = 'MyName'                                                                                                            |
#END