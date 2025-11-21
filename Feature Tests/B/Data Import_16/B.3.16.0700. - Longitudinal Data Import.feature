Feature: User Interface: The system shall require the event name in the csv file when importing data to a longitudinal study.

  As a REDCap end user
  I want to see that Data import is functioning as expected

  Scenario: B.3.16.0700.100 Import requires the event name
    #TEST FOR B.3.16.0300 The system shall highlight data modifications for user confirmation.

    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.3.16.0700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION
    When I click on the link labeled "Data Import Tool"
    When I upload a "csv" format file located at "import_files/B316700100_DATA_INACCURATE.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "ERROR:"
    And I click on the link labeled "RETURN TO PREVIOUS PAGE"

    When I upload a "csv" format file located at "import_files/B316700100_DATA_ACCURATE.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "The data you uploaded from the file is displayed in the Data Display Table below"

    When I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
#End