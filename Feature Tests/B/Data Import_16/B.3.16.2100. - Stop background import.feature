Feature: User Interface: The system shall provide the ability for the user importing data to stop non-imported data during the background data import

    As a REDCap end user
    I want to see that Data import is functioning as expected

    Scenario: B.3.16.2100.100 Stop non-imported data during the background data import
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.16.2100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "BigDataTestProject.xml", and clicking the "Create Project" button
        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        Given I click on the link labeled "Data Import Tool"
        And I select "Import as background process (better for large data sets)" on the dropdown field labeled "Choose an import option"
        And I upload a "csv" format file located at "import_files/BigDataTestProjectDATA.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "File was uploaded and will be processed soon"
        And I click on the button labeled "Close"
        And I wait for background processes to finish
        #Manual: this may take several minutes while the system analyzes for errors

        And I wait for 1 second
        And I click on the button labeled "Halt import"
        Then I should see "Halt this background import?"
        And I click on the button labeled "Yes, halt it now"
        Then I should see "The background import process has been successfully cancelled"
        And I click on the button labeled "Close"

        Then I should see a table header and rows containing the following values in the a table:
            | Status     | Original Filename           |
            | Cancelled  | BigDataTestProjectDATA.csv |
#END