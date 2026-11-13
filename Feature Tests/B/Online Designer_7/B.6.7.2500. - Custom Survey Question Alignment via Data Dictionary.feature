Feature: B.6.7.2500. - User Interface: The system shall allow users to specify custom question alignment for survey questions through the Data Dictionary.

    As a REDCap end user
    I want to specify question alignment through the Data Dictionary
    So that survey questions use the alignment I have selected

    Scenario: B.6.7.2500.100 Import custom survey question alignments
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "New Project"
        And I enter "B.6.7.2500.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"

        When I click on the button labeled "Enable" in the row labeled "Use surveys in this project?"
        Then I should see a button labeled "Disable" in the row labeled "Use surveys in this project?"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Import the Custom Alignment column from a Data Dictionary
        When I click on the link labeled "Dictionary"
        And I upload a "csv" format file located at "dictionaries/B.6.7.2500_CustomAlignment.csv", by clicking the button near "Upload your Data Dictionary file" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "Your document was uploaded successfully and awaits your confirmation below."
        When I click on the button labeled "Commit Changes"
        Then I should see "Changes Made Successfully!"

        ##SETUP: Enable the imported first instrument as a public survey
        And I click on the link labeled "Designer"
        And I click on the button labeled "Enable" in the row labeled "Alignment Survey"
        And I click on the button labeled "Save Changes"

        ##VERIFY: Each imported alignment is associated with its own question
        When I click on the link labeled "Alignment Survey"
        And I click on the Edit image for the field named "Default alignment question"
        Then I should see the dropdown field labeled "Custom Alignment" with the option "Right / Vertical (RV)" selected
        When I click on the button labeled "Cancel"
        And I click on the Edit image for the field named "Right horizontal question"
        Then I should see the dropdown field labeled "Custom Alignment" with the option "Right / Horizontal (RH)" selected
        When I click on the button labeled "Cancel"
        And I click on the Edit image for the field named "Left vertical question"
        Then I should see the dropdown field labeled "Custom Alignment" with the option "Left / Vertical (LV)" selected
        When I click on the button labeled "Cancel"
        And I click on the Edit image for the field named "Left horizontal question"
        Then I should see the dropdown field labeled "Custom Alignment" with the option "Left / Horizontal (LH)" selected
        When I click on the button labeled "Cancel"

        ##VERIFY: The imported questions and choices are available to respondents
        When I click on the link labeled "Survey Distribution Tools"
        And I click on the button labeled "Open public survey"
        Then I should see "Default alignment question"
        And I should see "Right horizontal question"
        And I should see "Left vertical question"
        And I should see "Left horizontal question"
        And I should see "First choice"
        And I should see "Second choice"

        #VERIFY_LOG
        Given I return to the REDCap page I opened the survey from
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Set up survey                           |
            | test_admin | Manage/Design | Upload data dictionary                  |
#END
