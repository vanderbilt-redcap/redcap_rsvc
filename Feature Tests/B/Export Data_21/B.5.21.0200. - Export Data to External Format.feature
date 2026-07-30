Feature: User Interface: The system shall allow data to be exported in the following formats: CSV, SPSS, SAS, R, STATA, and CDISC ODM (XML).

    As a REDCap end user
    I want to see that export data is functioning as expected

    Scenario: B.5.21.0200.100 Export data format
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.5.21.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: export CSV raw
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        Given I click on the button labeled "Export Data" for the report named "All data (all records and fields)"
        And I click on the radio labeled "CSV / Microsoft Excel (raw data)"
        And I click on the button labeled "Export Data"
        Then I should see "Data export was successful!"

        Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format
        Then I should see a downloaded file named "B5210200100_DATA_yyyy-mm-dd_hhmm.csv"
        #Manual: Close file

        And I click on the button labeled "Close"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: export CSV (labels)
        When I click on the button labeled "Export Data" for the report named "All data (all records and fields)"
        And I click on the radio labeled "CSV / Microsoft Excel (labels)"
        And I click on the button labeled "Export Data"
        Then I should see "Data export was successful!"

        Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (labels)" format
        Then I should see the latest downloaded "csv" file containing the headings below
            | "Record ID" | "Event Name" | "Repeat Instrument" | "Repeat Instance" | "Data Access Group" | "Survey Identifier" | Name | Email | "Phone Number" | Complete? | Name | "Text box" | Text2 | radio | "Notes box" | "Multiple Choice Dropdown Manual" | "Multiple Choice dropdown Auto" | "Radio Button Auto" | "Radio Button Manual" | "Checkbox (choice=Checkbox1)" | "Checkbox (choice=Checkbox2)" | "Checkbox (choice=Checkbox3)" | "Calc Test" | "Calculated Field" | Signature | "File Upload" | Required | Identifier | Identifier | "Edit Field" | "date YMD" | "date MDY" | "date DMY" | "time HH:MM:SS" | "time HH:M" | "time MM:SS" | "datetime YMD HMSS" | "datetime YMD HM" | "datetime MDY HMSS" | "datetime DMY HMSS" | "Integer " | Numbers | "Numbers 1 decimal place - period as decimal " | "Numbers 1 decimal place - comma as decimal " | "Letters only" | "MRN (10 Digits)" | "MRN (generic)" | "Social Security Number (US)" | "Phone (North America)" | "Phone (Australia)" | "Phone (UK)" | "Zipcode (US)" | "Postal code 5 (France)" | "Postal Code (Australia)" | "Postal Code (Canada)" | Complete? | "Survey Timestamp" | Name | Email | Complete? | "Survey Timestamp" | Name | Email | DOB | "Signature " | Complete? |
        #Manual: Close file

        And I click on the button labeled "Close"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: export SPSS
        Given I click on the button labeled "Export Data" for the report named "Test Report"
        And I click on the radio labeled "SPSS Statistical Software"
        And I click on the button labeled "Export Data"
        Then I should see "Data export was successful!"

        Given I click on the download icons to receive the files for the "SPSS Statistical Software" format
        Then I should see a downloaded file named "B5210200100-TestReport_SPSS_yyyy-mm-dd_hhmm.sps"
        #Manual: Close file

        And I click on the button labeled "Close"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: export SAS
        Given I click on the button labeled "Export Data" for the report named "Test Report"
        And I click on the radio labeled "SAS Statistical Software"
        And I click on the button labeled "Export Data"
        Then I should see "Data export was successful!"
        Given I click on the download icons to receive the files for the "SAS Statistical Software" format
        Then I should see a downloaded file named "B5210200100-TestReport_SAS_yyyy-mm-dd_hhmm.sas"
        #Manual: Close file

        And I click on the button labeled "Close"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: export R
        Given I click on the button labeled "Export Data" for the report named "All data (all records and fields)"
        And I click on the radio labeled "R Statistical Software"
        And I click on the button labeled "Export Data"
        Then I should see "Data export was successful!"

        Given I click on the download icons to receive the files for the "R Statistical Software" format

        Then I should see a downloaded file named "B5210200100_R_yyyy-mm-dd_hhmm.r"
        #Manual: Close file

        And I click on the button labeled "Close"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: export STATA
        Given I click on the button labeled "Export Data" for the report named "Test Report"
        And I click on the radio labeled "Stata Statistical Software"
        And I click on the button labeled "Export Data"
        Then I should see "Data export was successful!"

        Given I click on the download icons to receive the files for the "Stata Statistical Software" format
        Then I should see a downloaded file named "B5210200100-TestReport_STATA_yyyy-mm-dd_hhmm.do"
        #Manual: Close file

        And I click on the button labeled "Close"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: export XML
        Given I click on the button labeled "Export Data" for the report named "All data (all records and fields)"
        And I click on the radio labeled "CDISC ODM (XML)"
        And I click on the button labeled "Export Data"
        Then I should see "Data export was successful!"

        Given I click on the download icons to receive the files for the "CDISC ODM (XML)" format
        Then I should see a downloaded file named "B5210200100_CDISC_ODM_yyyy-mm-dd_hhmm.xml"
        #Manual: Close file

        And I click on the button labeled "Close"
#END