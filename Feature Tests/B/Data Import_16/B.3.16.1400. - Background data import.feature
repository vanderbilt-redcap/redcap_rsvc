Feature: User Interface: The system shall allow data to be uploaded as background process with the csv template to create and/or modify records.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.1400.100 Background Data Import
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.1400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "BigDataTestProject.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        Given I click on the link labeled "Data Import Tool"
        When I select "Import as background process (better for large data sets)" on the dropdown field labeled "Choose an import option"
        And I upload a "csv" format file located at "import_files/BigDataTestProjectbadDATA.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        And I should see "File was uploaded and will be processed soon"
        And I click on the button labeled "Close"
        Then I should see a table header and rows containing the following values in a table:
            | Status     | Original Filename              | Records Provided                  |
            | Queued     | BigDataTestProjectbadDATA.csv  | 75 |
        # Wait for import batch 1
        And I wait for background processes to finish
        # Wait for import batch 2
        And I wait for background processes to finish
        # We've intermittently seen that it takes three cron runs to get through two batches. Perhaps the import is sometimes bumped by other crons.
        And I wait for background processes to finish
        #Manual: this may take several minutes

        When I click on the button labeled "View details"
        And I click on the button labeled "Download list of all errors"
        Then I should see the latest downloaded "csv" file containing the headings and rows below
            | Record | "Variable Name" | Value          | "Error Message"                                                                                                   |
            | 2      | field_1         | "not a number" | "The value you provided could not be validated because it does not follow the expected format. Please try again." |
            | 4      | field_2         | 3              | "The value is not a valid category for field_2"                                                                   |
            | 7      | field_1         | 99-3           | "The value you provided could not be validated because it does not follow the expected format. Please try again." |

        When I click on the button labeled "Download records/data that did not import"
        Then I should see the latest downloaded "csv" file containing the headings and rows below
            | record_id | field_1        | field_2 | field_3   | field_4   | field_10   | field_11   | field_12   | field_13   | form_1_complete |
            | 2         | "not a number" | 1       | value-2-3 | value-2-4 | value-2-10 | value-2-11 | value-2-12 | value-2-13 | 1               |
            | 4         | 44             | 3       | value-4-3 | value-4-4 | value-4-10 | value-4-11 | value-4-12 | value-4-13 | 1               |
            | 7         | 99-3           | 1       | value-7-3 | value-7-4 | value-7-10 | value-7-11 | value-7-12 | value-7-13 | 1               |
        
        Then I click on the button labeled "Close" in the dialog box


        Given I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID | Form 1 |
            | 1         |        |
            | 3         |        |
            | 5         |        |
            | 6         |        |
        And I should see the "Unverified" icon for the "Form 1" instrument for record "1"
        And I should see the "Unverified" icon for the "Form 1" instrument for record "50"
        #Manual: note Records were skipped, user receives email with link to the "View background Imports" where they can click the View details button where they can either Download list of all errors or Download records/data that did not import

        #VERIFY
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username            | Action             | List of Data Changes OR Fields Exported |
            | SYSTEM (Test_Admin) | Create record 50   | record_id = '50'                        |
#END