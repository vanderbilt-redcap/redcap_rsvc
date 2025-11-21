Feature: Field Creation: The system shall support the creation of Begin New Section (with optional text).

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.1600.100 Creation of Section through the Online Designer

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.1600.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.1600.100"

        ##SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: section break creation
        When I click on the link labeled "Form 1"
        And I click on the Add Field input button below the field named "Record ID"

        When I select "Begin New Section (with optional text)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I click on the button labeled "Save" in the dialog box
        Then I should see an alert box with the following text: "Sorry, but Section Headers cannot be the last field on a data entry form"
        # Manual ONLY: (alerts are automatically accepted in automated testing)
        # And I click the OK button in the alert box
        And I should NOT see the field labeled "Section Break"

        When I click on the Add Field input button below the field named "Record ID"
        When I select "Notes Box (Paragraph Text)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Notes Box" into the Field Label of the open "Add New Field" dialog box
        And I enter "notesbox" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save"

        #VERIFY
        Then I should see the field labeled "Notes Box"

        When I click on the Add Field input button below the field named "Record ID"
        When I select "Begin New Section (with optional text)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Section Break" into the Field Label of the open "Add New Field" dialog box
        And I click on the button labeled "Save"
        Then I should see "Section Break"

        ##SETUP_PRODUCTION
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close" in the dialog box

        ##VERIFY: section break
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        Then I should see "Form 1"
        Then I should see a section break labeled "Section Break"

    Scenario: B.6.7.1600.200 Creation of section through Data Dictionary upload

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.1600.200" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.1600.200"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Upload data dictionary
        When I click on the link labeled "Dictionary"
        And I upload a "csv" format file located at "dictionaries/Project1xml_DataDictionary.csv", by clicking the button near "Choose File" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "Your document was uploaded successfully and awaits your confirmation below."

        When I click on the button labeled "Commit Changes"
        Then I should see "Changes Made Successfully!"

        ##VERIFY: section break
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        And I click the bubble to add a record for the "Data Types" instrument on the column labeled "Status"
        Then I should see "Data Types"
        And I should see a section break labeled "Date"
#END