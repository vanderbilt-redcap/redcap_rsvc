Feature: B.3.16.1300. User Interface: The system shall provide the ability to assign data instruments to a data access group with the Data Import Tool.
   
    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.1300.100 Data import assigns DAG
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.1300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button

        When I click on the link labeled "DAGs"
        And I enter "Test_Group1" into the field with the placeholder text of "Enter new group name"
        And I click on the button labeled "Add Group"
        Then I should see 'Data Access Group "Test_Group1" has been created!'

        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see a dialog containing the following text: "Adding new user"

        And I check the User Right named "Data Import Tool"
        And I select "Test_Group1" in the dropdown field labeled "Assign To DAG" in the dialog box
        And I click on the button labeled "Add user" in the dialog box
        Then I should see a table header and rows containing the following values in a table:
            | Role | Username or users assigned to a role | Expiration | Data Access Group |
            |   —   | test_admin  (Admin User)                         |   never         | —                 |
            |   —   | test_user1  (Test User1)                         |   never         | Test_Group1       |

        #SETUP_PRODUCTION
        Given I click on the link labeled "Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        Given I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.1300_DataImport_Rows.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "The data you uploaded from the file is displayed in the Data Display Table below"

        When I click on the button labeled "Import Data"
        Then I should see "Import Successful!"
        And I logout

        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.16.1300.100"
        And I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.1300_DataImport_Dag.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        
        Then I should see "ERROR: Illegal use of 'redcap_data_access_group' field!"
        And I logout

        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.16.1300.100"
        And I click on the link labeled "Data Import Tool"
        And I upload a "csv" format file located at "import_files/B.3.16.1300_DataImport_Dag.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file

        Then I should see a table header and rows containing the following values in a table:
            | record_id | redcap_data_access_group | name   |
            | 100       | test_group1              | Rob    |
            | 200       | test_group1              | Brenda |
            | 300       | test_group1              | Paul   |
        And I click on the button labeled "Import Data"
        Then I should see "Import Successful!"

        #VERIFY_DE
        When I click on the link labeled "Data Exports, Reports, and Stats"
        And I click on the button labeled "View Report"
        Then I should see a table header and rows containing the following values in the report data table:
            | record_id | redcap_data_access_group | name   |
            | 100       | Test_Group1              | Rob    |
            | 200       | Test_Group1              | Brenda |
            | 300       | Test_Group1              | Paul   |
#END