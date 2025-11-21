Feature: Field Creation: The system shall support the creation of Checkboxes (multiple answers).

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.1200.100 Creation of Checkboxes (multiple answers) through the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.1200.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.1200.100"

        ##SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: checkbox field creation
        Given I click on the link labeled "Form 1"
        And I click on the Add Field input button below the field named "Record ID"

        When I select "Checkboxes (Multiple Answers)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Checkbox" into the Field Label of the open "Add New Field" dialog box
        And I enter "checkbox" into the Variable Name of the open "Add New Field" dialog box
        And I enter Choices of "1, Checkbox1" into the open "Add New Field" dialog box
        And I enter Choices of "2, Checkbox2" into the open "Add New Field" dialog box
        And I enter Choices of "3, Checkbox3" into the open "Add New Field" dialog box
        And I enter Choices of "Abc123, Checkbox Abc123" into the open "Add New Field" dialog box
        And I click on the button labeled "Save"
        Then I should see the field labeled "Checkbox"
        And I should see the multiselect field labeled "checkbox" with the options below
            | Checkbox1       |
            | Checkbox2       |
            | Checkbox3       |
            | Checkbox Abc123 |

        ##SETUP_PRODUCTION
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close" in the dialog box

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name | Field Label | Field Attributes |
            | [checkbox]            | Checkbox    | checkbox         |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported              |
            | test_admin | Manage/Design | Approve production project modifications (automatic) |
            | test_admin | Manage/Design | Create project field                                 |

    Scenario: B.6.7.1200.200 Creation of Checkboxes (multiple answers) through Data Dictionary upload
        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Upload data dictionary
        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        When I click on the link labeled "Dictionary"
        And I upload a "csv" format file located at "dictionaries/Project1xml_DataDictionary.csv", by clicking the button near "Choose File" to browse for the file, and clicking the button labeled "Upload File" to upload the file
        Then I should see "Your document was uploaded successfully and awaits your confirmation below."

        When I click on the button labeled "Commit Changes"
        Then I should see "Changes to the DRAFT have been made successfully!"

        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close" in the dialog box

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported              |
            | test_admin | Manage/Design | Approve production project modifications (automatic) |
            | test_admin | Manage/Design | Upload data dictionary                               |
            | test_admin | Manage/Design | Enter draft mode                                     |
            | test_admin | Manage/Design | Approve production project modifications (automatic) |
            | test_admin | Manage/Design | Create project field                                 |

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name | Field Label | Field Attributes |
            | [checkbox]            | Checkbox    | checkbox         |
#END