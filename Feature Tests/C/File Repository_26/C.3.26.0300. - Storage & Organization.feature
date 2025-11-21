Feature: User Interface: The system shall support the storage, organization, and sharing of project files for permanent folders: (Data Export | e-Consent PDFs | Recycle Bin | Custom Create folder / Sub-folder)

    As a REDCap end user
    I want to see that file repository is functioning as expected

    Scenario: C.3.26.300.100 Automatic uploading of data export logs into the data export folder

    #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.3.26.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.300.100"

    #SETUP Export data automatically placed in file repo
        Given I click on the link labeled "Data Exports, Reports, and Stats"
        And I click on the button labeled "Export Data" for the report named "All data (all records and fields)"
        And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
        And I click on the button labeled "Export Data" in the dialog box
        Then I should see a dialog containing the following text: "Data export was successful!"

        Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
        Then I should have a "csv" file that contains the headings below
            | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | name | email | text_validation_complete | ptname | textbox | text2 | radio | notesbox | multiple_dropdown_manual | multiple_dropdown_auto | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | calc_test | calculated_field | signature | file_upload | required | identifier | identifier_2 | edit_field | date_ymd | date_mdy | date_dmy | time_hhmmss | time_hhmm | time_mmss | datetime_ymd_hmss | datetime_ymd_hm | datetime_mdy_hmss | datetime_dmy_hmss | integer | number | number_1_period | number_1_comma | letters | mrn_10_digits | mrn | ssn | phone_north_america | phone_australia | phone_uk | zipcode_us | postal_5 | postal_code_australia | postal_code_canada | data_types_complete | survey_timestamp | name_survey | email_survey | survey_complete | consent_timestamp | name_consent | email_consent | dob | signature_consent | consent_complete |
        And I click on the button labeled "Close" in the dialog box

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Export data automatically placed in file repo
        When I click on the link labeled "File Repository"
        Then I should see "Data Export Files"
        And I click on the link labeled "Data Export Files"
        And I should see "Data export file created by test_admin on"

    Scenario: C.3.26.300.200 Automatic uploading of e-Consent Framework PDFs
    # REDUNDANT

    Scenario: C.3.26.300.300 Recycle bin function - permanently force delete

    #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I create a new project named "C.3.26.300.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.300.300"


    ##ACTION Upload to top tier file repo
        When I click on the link labeled "File Repository"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                 | Time Uploaded | Comments |
            | Data Export Files    |               |          |
            | PDF Snapshot Archive |               |          |
            | Recycle Bin          |               |          |

        Given I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
            | import_files/testusers_bulkupload.csv |

    ##VERIFY file uploaded in folder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                     | Time Uploaded    | Comments                |
            | Data Export Files        |                  |                         |
            | PDF Snapshot Archive     |                  |                         |
            | Recycle Bin              |                  |                         |
            | testusers_bulkupload.csv | mm/dd/yyyy hh:mm | Uploaded by test_admin. |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Delete file
        # The following wait is to avoid intermittent failures on the following step
        And I wait for 1 second
        When I check the checkbox labeled "testusers_bulkupload.csv"
        And I click on the button labeled "Delete"
        Then I should see a dialog containing the following text: "Are you sure you wish to delete all the files currently selected on the page? Total files to be deleted: 1."
        And I click on the button labeled "Delete" in the dialog box

    ##VERIFY file deleted in folder
        Then I should see a dialog containing the following text: "SUCCESS!"
        And I click on the button labeled "Close" in the dialog box
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                 | Time Uploaded | Size    |
            | Data Export Files    |               | 0 Files |
            | PDF Snapshot Archive |               | 0 Files |
            | Recycle Bin          |               | 1 Files |
        And I should NOT see "testusers_bulkupload.csv"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Cancel Restore deleted file
        When I click on the link labeled "Recycle Bin"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                     | Time Uploaded    | Comments                |
            | testusers_bulkupload.csv | mm/dd/yyyy hh:mm | Uploaded by test_admin. |

        When I click on the icon labeled "Restore deleted file" in the row labeled "testusers_bulkupload.csv"
        Then I should see a dialog containing the following text: "File: testusers_bulkupload.csv"
        When I click on the button labeled "Cancel" in the dialog box
    ##VERIFY file still in recycle folder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                     | Time Uploaded    | Comments                |
            | testusers_bulkupload.csv | mm/dd/yyyy hh:mm | Uploaded by test_admin. |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Restore deleted file
        When I click on the icon labeled "Restore deleted file" in the row labeled "testusers_bulkupload.csv"
        Then I should see a dialog containing the following text: "File: testusers_bulkupload.csv"
        When I click on the button labeled "Restore" in the dialog box
        Then I should see a dialog containing the following text: "SUCCESS!"
        And I click on the button labeled "Close" in the dialog box
    ##VERIFY file in File Repository
        When I click on the link labeled "File Repository"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                     | Time Uploaded    | Comments                |
            | Data Export Files        |                  |                         |
            | PDF Snapshot Archive     |                  |                         |
            | Recycle Bin              |                  |                         |
            | testusers_bulkupload.csv | mm/dd/yyyy hh:mm | Uploaded by test_admin. |

    ##VERIFY file not in recycle folder
        When I click on the link labeled "Recycle Bin"
        Then I should NOT see "testusers_bulkupload.csv"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Delete file
        When I click on the link labeled "File Repository"

        # The following wait is to avoid intermittent failures on the following step
        And I wait for 1 second
        When I check the checkbox labeled "testusers_bulkupload.csv"
        And I click on the button labeled "Delete"
        Then I should see a dialog containing the following text: "Are you sure you wish to delete all the files currently selected on the page? Total files to be deleted: 1."
        And I click on the button labeled "Delete" in the dialog box
    ##VERIFY file deleted in folder
        Then I should see a dialog containing the following text: "SUCCESS!"
        And I click on the button labeled "Close" in the dialog box
        When I click on the link labeled "File Repository"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                 | Time Uploaded | Size    |
            | Data Export Files    |               | 0 Files |
            | PDF Snapshot Archive |               | 0 Files |
            | Recycle Bin          |               | 1 Files |
        And I should NOT see "testusers_bulkupload.csv"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Cancel Permanently deleted file
        When I click on the link labeled "Recycle Bin"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                     | Time Uploaded    | Comments                |
            | testusers_bulkupload.csv | mm/dd/yyyy hh:mm | Uploaded by test_admin. |
        When I click on the icon labeled "Permanently delete file" in the row labeled "testusers_bulkupload.csv"
        Then I should see a dialog containing the following text: "File: testusers_bulkupload.csv"
        When I click on the button labeled "Cancel" in the dialog box
    ##VERIFY file still in recycle folder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                     | Time Uploaded    | Comments                |
            | testusers_bulkupload.csv | mm/dd/yyyy hh:mm | Uploaded by test_admin. |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Permanently deleted file
        When I click on the icon labeled "Permanently delete file" in the row labeled "testusers_bulkupload.csv"
        Then I should see a dialog containing the following text: "File: testusers_bulkupload.csv"
        When I click on the button labeled "Delete" in the dialog box
    ##VERIFY file deleted in recycle folder
        Then I should see a dialog containing the following text: "File was successfully deleted!"
        And I click on the button labeled "OK"
        When I click on the link labeled "File Repository"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                 | Time Uploaded | Size    |
            | Data Export Files    |               | 0 Files |
            | PDF Snapshot Archive |               | 0 Files |
            | Recycle Bin          |               | 0 Files |
        And I should NOT see "testusers_bulkupload.csv"

    ##VERIFY file deleted in recycle folder
        When I click on the link labeled "Recycle Bin"
        Then I should see "No files or subfolders exist in this folder."

    #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported      |
            | test_admin | Manage/Design | Permanently delete file from File Repository |
            | test_admin | Manage/Design | Delete file from File Repository             |
            | test_admin | Manage/Design | Restore file in File Repository              |
            | test_admin | Manage/Design | Delete file from File Repository             |

    Scenario: C.3.26.300.400 Custom folder / sub-folder
    # REDUNDANT with C.3.26.200