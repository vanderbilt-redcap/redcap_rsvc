Feature: User Interface: The system shall require the repeating instrument and instance number in the csv file when importing data to a repeating event project.


  As a REDCap end user
  I want to see that Data import is functioning as expected

  Scenario: B.3.16.0800.100 Import requires the repeating instrument and instance number
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.3.16.0800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PROJECTSETUP
    When I click on the link labeled "Setup"
    When I click on the button labeled "Modify" in the row labeled "Repeating instruments and events"
    And I select "-- not repeating --" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And I select "-- not repeating --" on the dropdown field labeled "Event 2 (Arm 1: Arm 1)"
    And I click on the button labeled "Save"
    Then I should see a dialog containing the following text: "Your settings for repeating instruments and/or events have been successfully saved."
    And I click on the button labeled "Close" in the dialog box

    #SETUP_PRODUCTION
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Delete ALL data in the project" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    #Manual: Will have to accept confirmation window "And I click on the button labeled "Ok" in the pop-up box"
    Then I should see "Project status:  Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Error during import
    When I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files//B316800100_W_REPEATS.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    
    ##VERIFY
    Then I should see "ERROR:"
    And I click on the link labeled "RETURN TO PREVIOUS PAGE"

    #SETUP_PROJECTSETUP
    When I click on the link labeled "Setup"
    When I click on the button labeled "Enable" in the row labeled "Repeating instruments and events"
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And for the Event Name "Event 1 (Arm 1: Arm 1)", I check the checkbox labeled "Text Validation" in the dialog box
    And for the Event Name "Event 1 (Arm 1: Arm 1)", I check the checkbox labeled "Data Types" in the dialog box
    And I click on the button labeled "Save"
    Then I should see a dialog containing the following text: "Your settings for repeating instruments and/or events have been successfully saved."
    And I click on the button labeled "Close" in the dialog box

    #FUNCTIONAL REQUIREMENT
    ##ACTION: import without repeat instrument
    When I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "import_files//B316800100_WOUT_REPEATS.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    
    ##VERIFY
    Then I should see "Errors were detected in the import file"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: import with repeat instrument
    When I upload a "csv" format file located at "import_files//B316800100_W_REPEATS.csv", by clicking the button near "Select your CSV data file" to browse for the file, and clicking the button labeled "Upload File" to upload the file
   
    ##VERIFY
    Then I should see "Your document was uploaded successfully"

    When I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
#End