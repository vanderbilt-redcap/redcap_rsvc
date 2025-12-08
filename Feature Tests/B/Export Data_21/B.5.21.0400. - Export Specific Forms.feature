Feature: User Interface: The system shall support the ability to select specific forms to export.

  As a REDCap end user
  I want to see that export data is functioning as expected

  Scenario: B.5.21.0400.100 Export select forms
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.5.21.0400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: export CSV and confirm column
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the "Make custom selections" button for the "Selected instruments" report in the My Reports & Exports table
    And I select "Text Validation" on the multiselect field labeled "Instruments"
    And I select "Event 1 (Arm 1: Arm 1)" on the multiselect field labeled "Events"
    And I click on the "Export Data" button for the "Selected instruments" report in the My Reports & Exports table
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)"
    And I click on the button labeled "Export Data"
    Then I should see a dialog containing the following text: "Data export was successful!"

    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format
    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | name | email | text_validation_complete | ptname | textbox | text2 | radio | notesbox | multiple_dropdown_manual | multiple_dropdown_auto | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | calc_test | calculated_field | signature | file_upload | required | identifier | identifier_2 | edit_field | date_ymd | date_mdy | date_dmy | time_hhmmss | time_hhmm | time_mmss | datetime_ymd_hmss | datetime_ymd_hm | datetime_mdy_hmss | datetime_dmy_hmss | integer | number | number_1_period | number_1_comma | letters | mrn_10_digits | mrn | ssn | phone_north_america | phone_australia | phone_uk | zipcode_us | postal_5 | postal_code_australia | postal_code_canada | data_types_complete | survey_timestamp | name_survey | email_survey | survey_complete | consent_timestamp | name_consent | email_consent | dob | signature_consent | consent_complete |

    And I click on the button labeled "Close"
#END