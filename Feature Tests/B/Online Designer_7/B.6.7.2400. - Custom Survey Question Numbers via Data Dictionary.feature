Feature: B.6.7.2400. - User Interface: The system shall allow users to specify custom question numbers for survey questions through the Data Dictionary.

    As a REDCap end user
    I want to specify custom survey question numbers through the Data Dictionary
    So that survey respondents see the question numbers I have defined

    Scenario: B.6.7.2400.100 Import and display custom survey question numbers
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.2400.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"

        When I click on the button labeled "Enable" in the row labeled "Use surveys in this project?"
        Then I should see a button labeled "Disable" in the row labeled "Use surveys in this project?"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Import custom numbers from the Question Number (surveys only) column
        When I click on the link labeled "Dictionary"
        And I upload a "csv" format file located at "dictionaries/B.6.7.2400_CustomQuestionNumbers.csv", by clicking the button near "Upload your Data Dictionary file" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "Your document was uploaded successfully and awaits your confirmation below."

        When I click on the button labeled "Commit Changes"
        Then I should see "Changes Made Successfully!"

        ##ACTION: Configure the imported instrument to use custom question numbering
        When I click on the link labeled "Designer"
        And I click on the button labeled "Enable" in the column labeled "Enabled as" and the row labeled "Custom Number Survey"
        And I select "Custom numbered" on the dropdown field labeled "Question Numbering"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"

        ##VERIFY: Imported numbers are associated with the correct fields
        When I click on the link labeled "Custom Number Survey"
        Then I should see "10" within the field with variable name "age"
        And I should see "20a" within the field with variable name "contact_preference"
        And I should see "3.5" within the field with variable name "comments"

        ##VERIFY: Respondents see the imported numbers beside their survey questions
        When I click on the link labeled "Survey Distribution Tools"
        And I click on the button labeled "Open public survey"
        Then I should see "Please complete the survey below."
        And I should see table rows containing the following values in a table:
            | 10  | What is your age?                    |
            | 20a | How would you prefer to be contacted? |
            | 3.5 | Do you have any comments?             |

        #VERIFY_LOG
        Given I return to the REDCap page I opened the survey from
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Upload data dictionary                  |
#END
