Feature: User Interface: The system shall support the ability to identify data as containing a protected health information identifier.
  As a REDCap end user
  I want to see that export data is functioning as expected

  Scenario: B.5.21.0100.100 Limit identified data export
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.5.21.0100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_5.21.xml", and clicking the "Create Project" button

    #SETUP_USER_RIGHTS
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    Then I should see "Assign To DAG"

    When I select "4_NoAccess_Noexport" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see a table header and rows containing the following values in a table:
      | Role name           | Username   |
      | 4_NoAccess_Noexport | test_user1 |

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
      | Variable / Field Name | Field Label  | Field Attributes (Field Type, Validation, Choices, Calculations, etc.) |
      | [identifier]          | Identifier   | text, Identifier                                                       |
      | [identifier_2]        | Identifier 2 | text, Identifier                                                       |
      | [ptname]              | Name         | text                                                                   |
      | [radio]               | radio        | radio, Identifier                                                      |


    ##ACTION: change identifier status
    When I click on the link labeled "Setup"
    Then I should see "Design your data collection instruments & enable your surveys"

    When I click on the link labeled "Check For Identifiers"
    Then I should see a table header and rows containing the following values in a table:
      | Variable Name | Field Label   | Identifier? |
      | identifier    | Identifier    | [x]         |
      | identifier_2  | Identifier  2 | [x]         |
      | ptname        | Name          | [ ]         |
      | radio         | radio         | [x]         |

    When I uncheck the checkbox labeled "identifier_2"
    And I check the checkbox labeled "ptname"
    And I click on the button labeled "Update Identifiers"
    Then I should see a table header and rows containing the following values in a table:
      | Variable Name | Field Label  | Identifier? |
      | identifier    | Identifier   | [x]         |
      | identifier_2  | Identifier 2 | [ ]         |
      | ptname        | Name         | [x]         |
      | radio         | radio        | [x]         |

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
      | Variable / Field Name | Field Label  | Field Attributes (Field Type, Validation, Choices, Calculations, etc.) |
      | [identifier]          | Identifier   | text, Identifier                                                       |
      | [identifier_2]        | Identifier 2 | text                                                                   |
      | [ptname]              | Name         | text, Identifier                                                       |
      | [radio]               | radio        | radio, Identifier                                                      |

    ##VERIFY_DE
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    ##ACTION: export all
    Given I click on the "Export Data" button for the "All data (all records and fields)" report in the My Reports & Exports table
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"

    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box

    ##VERIFY: User can see all variables, including identifier, identifier_2 and name, survey_timestamp, radio button
    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | ptname | textbox | radio | notesbox | identifier | identifier_2 | date_ymd | datetime_ymd_hmss | data_types_complete |

    And I click on the button labeled "Close" in the dialog box

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: remove identifiers from export
    Given I click on the "Export Data" button for the "All data (all records and fields)" report in the My Reports & Exports table
    Then I should see "Known Identifiers"

    When I check the checkbox labeled "Remove All Identifier Fields" in the dialog box
    And I check the checkbox labeled "Hash the Record ID field" in the dialog box
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"

    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box

    ##VERIFY: User can see all variables except for [identifier], [ptname], [radio], [redcap_survey_identifer] and check record id #ed
    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | data_types_timestamp | textbox | notesbox | identifier_2 | date_ymd | datetime_ymd_hmss | data_types_complete |

    And I click on the button labeled "Close" in the dialog box

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: add identifiers back and remove unvalidated texts fields and notesbox fields
    Given I click on the "Export Data" button for the "All data (all records and fields)" report in the My Reports & Exports table
    When I uncheck the checkbox labeled "Remove All Identifier Fields" in the dialog box
    And I uncheck the checkbox labeled "Hash the Record ID field" in the dialog box
    And I check the checkbox labeled "Remove unvalidated Text fields" in the dialog box
    And I check the checkbox labeled "Remove Notes/Essay box fields" in the dialog box
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"

    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
    ##VERIFY: User can see all variables except for unvalidated fields and notes fields
    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | radio | date_ymd | datetime_ymd_hmss | data_types_complete |

    And I click on the button labeled "Close" in the dialog box

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: remove date, datetime fields
    Given I click on the "Export Data" button for the "All data (all records and fields)" report in the My Reports & Exports table
    When I uncheck the checkbox labeled "Remove unvalidated Text fields" in the dialog box
    And I uncheck the checkbox labeled "Remove Notes/Essay box fields" in the dialog box
    And I check the checkbox labeled "Remove all date and datetime fields" in the dialog box
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"

    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
    ##VERIFY: User can see all variables except for date and datetime fields
    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier  | ptname | textbox | radio | notesbox | identifier | identifier_2 | data_types_complete |

    And I click on the button labeled "Close" in the dialog box

    ##ACTION: create record and enter dates in survey mode
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I should see "Adding new Record ID 5"

    When I select the submit option labeled "Save & Stay" on the Data Collection Instrument

    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label and will leave the tab open when I return to the REDCap project
    Then I should see "Please complete the survey below"

    And I verify "yyyy-mm-dd" is within the data entry form field labeled "date YMD"
    And I verify "yyyy-mm-dd hh:mm:ss" is within the data entry form field labeled "datetime YMD HMSS"
    When I click on the button labeled "Submit"
    #And I click on the button labeled "Close survey"

    #Manual: Surveys open in the same window (by default) in automated tests (automated tests this in B.3.15.500 - Survey Alerts and Prompts)

    Given I return to the REDCap page I opened the survey from
    And I click on the button labeled "Leave without saving changes" in the dialog box
    And I click on the link labeled "Record Status Dashboard"
    And I should see the "Completed Survey Response" icon for the "Data Types" instrument for record "5"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: shift all dates
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Export Data" in the row labeled "All data (all records and fields)"

    And I check the checkbox labeled "Shift all dates by value between 0 and 364 days" in the dialog box
    And I check the checkbox labeled "Also shift all survey completion timestamps by value between 0 and 364 days" in the dialog box
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"
    And I should see a dialog containing the following text: "All dates within your data have been DATE SHIFTED to an unknown value between 0 and  364 days."

    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
    ##VERIFY:
    #Manual: User can see all variables with dates shifted ([data_types_timestamp]=! today) AND ([date_ymd]=! today) AND ([date_ymd_hmss]=! today)

    Then I should see the latest downloaded "csv" file containing the headings below
      | record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | ptname | textbox | radio | notesbox | identifier | identifier_2 | date_ymd | datetime_ymd_hmss | data_types_complete |
    And I verify the timestamp in column labeled "data_types_timestamp" for record "5" has shifted today's date in the latest downloaded "csv"
    And I verify the date in column labeled "date_ymd" for record "5" has shifted today's date in the latest downloaded "csv"
    And I verify the datetime in column labeled "datetime_ymd_hmss" for record "5" has shifted today's date in the latest downloaded "csv"

    #Manual: Close the report & refresh page

    And I click on the button labeled "Close" in the dialog box
    And I logout

    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    When I click on the link labeled "B.5.21.0100.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: limited access
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    And I should NOT see a button labeled "Export Data"
#END