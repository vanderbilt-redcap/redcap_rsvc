Feature: User Interface: The system shall support the enabling of the e-Consent Framework with an active/inactive status.

    As a REDCap end user
    I want to see that eConsent is functioning as expected

    Scenario: C.3.24.0105.100 The system shall support the enabling of the e-Consent Framework with an active/inactive status.

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.24.0105.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "24EConsentWithSetup.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

    #FUNCTIONAL_REQUIREMENT
    Scenario: ##ACTION: e-consent survey settings - disabled
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        Then I should see a checkbox labeled "Hide inactive" that is checked

        Given I enable the toggle button labeled "Participant Consent"
        And I should see a toggle button labeled "Participant Consent" that is in the enabled state

        When I uncheck the checkbox labeled "Hide inactive"
        And I wait for 5 seconds
        And I disable the toggle button labeled "Participant Consent"
        Then I should see a dialog containing the following text: "Set as inactive"

        Given I click on the button labeled "Set as inactive" in the dialog box
        Then I should see 'e-Consent has been successfully disabled for survey "participant_consent"'
        And I should see a toggle button labeled "Participant Consent" that is in the disabled state

        When I check the checkbox labeled "Hide inactive"
        Then I should NOT see a toggle button labeled "Participant Consent"


        ##ACTION: add record to get participant signature
      Scenario: Add record to get participant signature
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 1"

        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
        And I click on the button labeled "Survey options" and will leave the tab open when I return to the REDCap project
        And I click on the survey option label containing "Open survey" label
        Then I should see "Please complete the survey"

        And I clear field and enter "FirstName" into the data entry form field labeled "First Name"
        And I clear field and enter "LastName" into the data entry form field labeled "Last Name"
        And I clear field and enter "email@test.edu" into the data entry form field labeled "email"
        And I clear field and enter "2000-01-01" into the data entry form field labeled "Date of Birth"
        And I clear field and enter "MyName" into the data entry form field labeled "Participant's Name Typed"

        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Submit"
        Then I should see a button labeled "Close survey"


          ##VERIFY_RSD
        Given I click on the button labeled "Close survey"
        And I return to the REDCap page I opened the survey from
        When I click on the link labeled "Record Status Dashboard"

        ##VERIFY - Completed survey response in "Participant Consent" but no data saved within Pdfs And Combined Signatures Pdf
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" instrument on event "Event 1" for record "1"
        And I should see the "Incomplete (no data saved)" icon for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record "1"

    ##ACTION: e-consent survey settings - enable
    Scenario: Enable e-Consent
        Then I should see a link labeled "Designer"
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        When I uncheck the checkbox labeled "Hide inactive"
        And I enable the toggle button labeled "Participant Consent"
        And I should see a toggle button labeled "Participant Consent" that is in the enabled state

    ##ACTION: add record to get participant signature
    Scenario: Add record to get participant signature
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to select a record for the "Participant Consent" instrument on event "Event 1"
        Then I should see "Adding new Record ID 2"
        And I should see a field labeled "Consent file"

        And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
        And I click on the button labeled "Okay" in the dialog box
        And I click on the button labeled "Survey options" and will leave the tab open when I return to the REDCap project
        And I click on the survey option label containing "Open survey" label
        Then I should see "Please complete the survey"

        And I clear field and enter "FirstName" into the data entry form field labeled "First Name"
        And I clear field and enter "LastName" into the data entry form field labeled "Last Name"
        And I clear field and enter "email@test.edu" into the data entry form field labeled "email"
        And I clear field and enter "2000-01-01" into the data entry form field labeled "Date of Birth"
        And I clear field and enter "MyName" into the data entry form field labeled "Participant's Name Typed"

        Given I click on the link labeled "Add signature"
        And I see a dialog containing the following text: "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature" in the dialog box
        Then I should see a link labeled "Remove signature"

        When I click on the button labeled "Next Page"
        Then I should see "Displayed below is a read-only copy of your survey responses."
        And I should see the consent pdf has loaded in the iframe

        When I check the checkbox labeled "I certify that all of my information in the document above is correct"
        And I click on the button labeled "Submit"
        Then I should see "Thank you for taking the survey."
        And I click on the button labeled "Close survey"

        ##VERIFY_RSD
        Given I return to the REDCap page I opened the survey from
        And I click on the link labeled "Record Status Dashboard"
        Then I should see the "Completed Survey Response" icon for the "Participant Consent" instrument on event "Event 1" for record "2"

        ##VERIFY_PDF Snapshot Specific File Location
        And I locate the bubble for the "Pdfs And Combined Signatures Pdf" instrument on event "Event 1" for record ID "2" and click on the bubble
        Then I should see a link labeled ".pdf"

        ##VERIFY_FiRe
        ##e-Consent Framework not used, and PDF Snapshot is used
        When I click on the link labeled "File Repository"

        ##VERIFY file uploaded in folder
        Then I should see a table header and rows containing the following values in the file repository table:
          | Name                           | Size    |
          | Data Export Files              | 0 Files |
          | PDF Snapshot Archive           | 1 File  |
          | Miscellaneous File Attachments | 0 Files |
          | Recycle Bin                    | 0 Files |

        Then I should see a link labeled "PDF Snapshot Archive"
        Given I click on the link labeled "PDF Snapshot Archive"
        Then I should see "PDF Snapshot Archive"

        #Manual: Note that the PID prefix will not likely be 13 in any environments except automated
        Then I should see a table header and rows containing the following values in a table:
          | Name                             | Record | Survey Completed                             |
          | pid13_formParticipantConsent_id2 | 2      | Participant Consent (Event 1 (Arm 1: Arm 1)) |

        Given I click on the link labeled "_formParticipantConsent_id2_"
        Then I should see the following values in the last file downloaded
          | PID 13 - LastName   |
          | Participant Consent |

        #Manual: Close PDF document

      ##VERIFY_Logging
      Scenario: e-Consent Framework used, and PDF Snapshot is used
      ##e-Consent Framework used, and PDF Snapshot is used
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
          | Username            | Action                                     | List of Data Changes OR Fields Exported    |
          | [survey respondent] | Save PDF Snapshot 2                        | Save PDF Snapshot to File Upload Field     |
          | [survey respondent] | Save PDF Snapshot 2                        | record = "2"                               |
          | [survey respondent] | Save PDF Snapshot 2                        | field = "participant_file (event_1_arm_1)" |
          | [survey respondent] | Update Response 2 (Event 1 (Arm 1: Arm 1)) | participant_file = '8'                     |

#END