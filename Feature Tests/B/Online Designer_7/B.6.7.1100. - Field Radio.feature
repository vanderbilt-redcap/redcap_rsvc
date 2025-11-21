Feature: Design forms Using Data Dictionary and Online Designer
    Field Creation: The system shall support the creation and manual coding for multiple choice radio buttons (single answer)

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.1100.100 Creation of multiple choice dropdown list (single answer) through the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "New Project"
        And I enter "B.6.7.1100.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"

        ##SETUP_DEV
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: radio field creation
        Given I see a table header and rows containing the following values in a table:
            | Instrument name | Fields |
            | Form 1          | 1      |
        And I click on the link labeled "Form 1"
        Then I should see a field named "Record ID"

        Given I click on the Add Field input button below the field named "Record ID"
        And I select "Multiple Choice - Radio Buttons (Single Answer)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Radio Button Manual" into the Field Label of the open "Add New Field" dialog box
        And I enter "radio_button_manual" into the Variable Name of the open "Add New Field" dialog box
        And I enter Choices of "9..9, Choice99" into the open "Add New Field" dialog box
        And I enter Choices of "100, Choice100" into the open "Add New Field" dialog box
        And I enter Choices of "101, Choice101" into the open "Add New Field" dialog box
        And I enter Choices of "Abc123, Choice Abc123" into the open "Add New Field" dialog box
        And I should see "Save"
        And I click on the button labeled "Save"

        #VERIFY
        Then I should see a field named "Radio Button Manual"
        And I should see the radio field labeled "Radio Button Manual" with the options below
            | Choice99      |
            | Choice100     |
            | Choice101     |
            | Choice Abc123 |

        ##SETUP_PRODUCTION
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close" in the dialog box

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name | Field Label         | Field Attributes |
            | [radio_button_manual] | Radio Button Manual | radio            |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Create project field                    |
        Given I logout

    Scenario: B.6.7.1100.200 Creation of multiple choice radio buttons (single answer) through Data Dictionary upload (#CROSSFUNCTIONAL - B.6.7.100.100)

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        When I click on the link labeled "New Project"
        And I enter "B.6.7.1100.200" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Upload data dictionary
        When I click on the link labeled "Dictionary"
        And I upload a "csv" format file located at "dictionaries/Project1xml_DataDictionary.csv", by clicking the button near "Choose File" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "Your document was uploaded successfully and awaits your confirmation below."

        When I click on the button labeled "Commit Changes"
        Then I should see "Changes Made Successfully!"

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name | Field Label         | Field Attributes |
            | [radio_button_manual] | Radio Button Manual | radio            |
#END