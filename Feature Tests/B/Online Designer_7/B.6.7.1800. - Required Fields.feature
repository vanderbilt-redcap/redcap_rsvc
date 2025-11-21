Feature: Field Creation: The system shall support marking a data entry field as required.

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.1800.100 Designating field as required through the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.6.7.1800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        ##SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION Designating field as required
        When I click on the link labeled "Data Types"
        #MANUAL NOTE: the last button is the one at the bottom of the instrument
        And I click on the last button labeled "Add Field"

        When I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Required 2" into the Field Label of the open "Add New Field" dialog box
        And I enter "required_2" into the Variable Name of the open "Add New Field" dialog box
        And I mark the field required
        And I click on the button labeled "Save"
        And I should see "must provide value" within the field with variable name "required_2"

        ##SETUP_PRODUCTION
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close" in the dialog box

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table row containing the following values in the codebook table:
            | [required_2] | Required 2 | text, Required |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Create project field                    |

    Scenario: B.6.7.1800.200 Designating field as required through Data Dictionary upload

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.1800.200" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.1800.200"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Upload data dictionary
        When I click on the link labeled "Dictionary"
        And I upload a "csv" format file located at "dictionaries/Project1xml_DataDictionary.csv", by clicking the button near "Choose File" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "Your document was uploaded successfully and awaits your confirmation below."

        When I click on the button labeled "Commit Changes"
        Then I should see "Changes Made Successfully!"

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table row containing the following values in the codebook table:
            | [required] | Required | text, Required |
#END