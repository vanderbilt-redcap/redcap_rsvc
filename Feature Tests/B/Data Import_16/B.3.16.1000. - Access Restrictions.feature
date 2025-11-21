Feature: User Interface: The system shall not allow a new record to be imported if user does not have Create Records access.

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.1000.100 Data import of new record limited by user rights

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.1000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #USER_RIGHTS
        When I click on the link labeled "User Rights"
        And I enter "Test_User3" into the field with the placeholder text of "Add new user"
        And I click on the button labeled "Add with custom rights"
        Then I should see a dialog containing the following text: "Adding new user"

        When I check the User Right named "Data Import Tool"
        And I uncheck the User Right named "Create Records"
        And I click on the button labeled "Add user" in the dialog box
        Then I should see a table header and rows containing the following values in a table:
            | Role name | Username   |
            | —         | test_user3 |
        And I logout

        #FUNCTIONAL_REQUIREMENT
        Given I login to REDCap with the user "Test_User3"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.16.1000.100"
        When I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.1000_New Record.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "ERROR:"
        And I should see "Your user privileges do NOT allow you to create new records."
        And I logout

        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.16.1000.100"
        And I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.1000_New Record.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see a table header and rows containing the following values in a table:
            | record_id    | email          |
            | (new record) | email@test.edu |

        When I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        ##VERIFY_RSD:
        When I click on the link labeled "Record Status Dashboard"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 5         |

        ##VERIFY_DE
        When I click on the link labeled "Data Exports, Reports, and Stats"
        Then I should see a table row containing the following values in the reports table:
            | A | All data (all records and fields) |

        When I click on the button labeled "View Report"
        Then I should see a table header and rows containing the following values in the report data table:
            | Record ID | Email          |
            | 5         | email@test.edu |
#End