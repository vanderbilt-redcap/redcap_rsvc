Feature: Field Creation: The system shall support the creation of Signature (draw signature with mouse or finger).

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.1300.100 Creation of Signature field through the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.1300.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.1300.100"

        ##SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Signature field creation
        Given I click on the link labeled "Form 1"
        And I click on the Add Field input button below the field named "Record ID"

        When I select "Signature (draw signature with mouse or finger)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Signature" into the Field Label of the open "Add New Field" dialog box
        And I enter "signature" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save"
        Then I should see the field labeled "Signature"
        And I should see the link labeled "Add signature"

        ##SETUP_PRODUCTION
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close" in the dialog box

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name | Field Label | Field Attributes |
            | [signature]           | Signature   | file (signature) |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Create project field                    |

    Scenario: B.6.7.1300.200 Creation of Signature field through Data Dictionary upload

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.1300.200" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.1300.200"

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
            | Variable / Field Name | Field Label | Field Attributes |
            | [signature]           | Signature   | file (signature) |
#END