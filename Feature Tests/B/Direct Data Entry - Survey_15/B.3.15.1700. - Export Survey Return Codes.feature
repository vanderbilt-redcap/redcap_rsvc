Feature: B.3.15.1700. - User Interface: The system shall allow users to export survey Return Codes associated with the Save & Return Later functionality.

    As a REDCap end user
    I want to export survey return codes
    So that I can retrieve the code for an incomplete survey response

    Scenario: B.3.15.1700.100 Export the return code for a saved survey response
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.15.1700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        When I click on the link labeled "Designer"
        And I click on the button labeled "Enable" in the column labeled "Enabled as" and the row labeled "Text Validation"
        And I select "Yes" on the dropdown field labeled "Allow 'Save & Return Later' option for respondents?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"

        ##SETUP: Save an incomplete response
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        Then I should see "Please complete the survey below"
        When I clear field and enter "Return code export test" into the data entry form field labeled "Name"
        And I click on the button labeled "Save & Return Later"
        Then I should see "'Return Code' needed to return"
        #MANUAL: Record the return code shown to the respondent for comparison with the export.
        When I click on the button labeled "Close"
        Then I should see "Your survey responses were saved!"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Export return codes from Other Export Options
        Given I return to the REDCap page I opened the survey from
        When I click on the link labeled "Data Exports, Reports, and Stats"
        And I click on the link labeled "Other Export Options"
        Then I should see "Return Codes for Surveys (for Save & Return Later feature)"
        When I click on the link labeled "Download all records with Return Codes"

        ##VERIFY: The export includes a return code column for the survey
        Then I should see the latest downloaded "csv" file containing the headings below
            | record_id | redcap_event_name | redcap_data_access_group | redcap_survey_identifier | text_validation_return_code | text_validation_timestamp | text_validation_complete |
        #MANUAL: Open the downloaded CSV and verify that the text_validation_return_code for record 1 and event_1_arm_1 matches the code shown to the respondent.

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported    |
            | mm/dd/yyyy hh:mm | test_admin | Data export   | record_id, text_validation_complete        |
#END
