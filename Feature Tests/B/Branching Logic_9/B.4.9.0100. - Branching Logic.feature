Feature: B.4.9.0100. User Interface: The system shall support branching logic for data entry forms.
    As a REDCap end user
    I want to see that Branching Logic is functioning as expected

    Scenario: B.4.9.0100.100 Branching Logic
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.4.9.0100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_4.9.xml", and clicking the "Create Project" button

        ##VERIFY: Branching logic
        When I click on the link labeled "Designer"
        And I click on the link labeled "Data Types"
        And I click on the button labeled "Dismiss"
        Then I should see "Branching logic: [record_id] = '999'" within the field with variable name "ptname"
        Then I should see "Branching logic: [record_id] = '999'" within the field with variable name "textbox"
        Then I should see "Branching logic: [record_id] = '999'" within the field with variable name "text2"
        Then I should see "Branching logic: [record_id] = '999'" within the field with variable name "notesbox"

        #FUNCTIONAL_REQUIREMENT: survey mode
        When I click on the link labeled "Survey Distribution Tools"
        And I click on the button labeled "Open public survey"
        Then I should NOT see the field labeled "Name"
        And I should NOT see the field labeled "Text2"
        And I should NOT see the field labeled "Text box"
        And I should NOT see the textarea labeled "Notes box"
        And I should see the field labeled "Calculated Field"
        And I should see the dropdown labeled "Multiple Choice dropdown Auto"
        And I should see the dropdown labeled "Multiple Choice Dropdown Manual"
        #Manual: Close the survey page

        #FUNCTIONAL_REQUIREMENT: data entry mode
        Given I return to the REDCap page I opened the survey from
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"

        Then I should see "The current field for which you just entered data requires that some fields be hidden from view"
        And I should see a checkbox labeled "Name" that is checked
        And I should see a checkbox labeled "Text box" that is checked
        And I should see a checkbox labeled "Text2" that is checked
        And I should see a checkbox labeled "Notes box" that is checked
        And I click on the button labeled "Erase"

        Then I should NOT see the field labeled "Name"
        And I should NOT see the field labeled "Text2"
        And I should NOT see the field labeled "Text box"
        And I should NOT see the textarea labeled "Notes box"
        And I should see the field labeled "Calculated Field"
        And I should see the dropdown labeled "Multiple Choice dropdown Auto"
        And I should see the dropdown labeled "Multiple Choice Dropdown Manual"

        ##ACTION: change branching logic for one
        When I click on the link labeled "Designer"
        And I click on the button labeled "Leave without saving changes"
        And I click on the link labeled "Data Types"
        And I click on the icon labeled "Branching Logic" in the row labeled "ptname"
        And I click on "[record_id] = '999'" in the textarea field labeled "Advanced Branching Logic Syntax"
        And I wait for 1 second
        And I clear field and enter "[record_id] <> '999'" in the textarea field labeled "Logic Editor"
        And I click on the button labeled "Update & Close Editor"
        And I click on the button labeled "Save"
        Then I should see "Also edit Branching Logic for OTHER fields?"
        And I click on the button labeled "No"
        Then I should see "Branching logic: [record_id] <> '999'" within the field with variable name "ptname"

        ##ACTION: change branching logic for all
        When I click on the icon labeled "Branching Logic" in the row labeled "text2"
        And I click on "[record_id] = '999'" in the textarea field labeled "Advanced Branching Logic Syntax"
        And I wait for 1 second
        And I clear field and enter "[record_id] <> '999'" in the textarea field labeled "Logic Editor"
        And I click on the button labeled "Update & Close Editor"
        And I click on the button labeled "Save"
        Then I should see "Also edit Branching Logic for OTHER fields?"
        And I click on the button labeled "Yes"
        Then I should NOT see "Add/Edit Branching Logic"
        Then I should see "Branching logic: [record_id] <> '999'" within the field with variable name "text2"
        And I should see "Branching logic: [record_id] <> '999'" within the field with variable name "notesbox"

        #FUNCTIONAL_REQUIREMENT: survey mode
        When I click on the link labeled "Survey Distribution Tools"
        When I click on the button labeled "Open public survey" and will leave the tab open when I return to the REDCap project
        Then I should see "Please complete the survey below."
        And I should see the field labeled "Name"
        And I should see the field labeled "Text2"
        And I should see the field labeled "Text box"
        And I should see the textarea labeled "Notes box"
        And I should see the field labeled "Calculated Field"
        And I should see the dropdown labeled "Multiple Choice dropdown Auto"
        And I should see the dropdown labeled "Multiple Choice Dropdown Manual"
        #Manual: Close tab

        #FUNCTIONAL_REQUIREMENT: data entry mode
        Given I return to the REDCap page I opened the survey from
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
        Then I should see the field labeled "Name"
        And I should see the field labeled "Text2"
        And I should see the field labeled "Text box"
        And I should see the textarea labeled "Notes box"
        And I should see the field labeled "Calculated Field"
        And I should see the dropdown labeled "Multiple Choice dropdown Auto"
        And I should see the dropdown labeled "Multiple Choice Dropdown Manual"

        ##ACTION
        When I click on the link labeled "Designer"
        And I click on the button labeled "Leave without saving changes"
        And I click on the link labeled "Data Types"
        And I click on the icon labeled "Branching Logic" in the row labeled "descriptive_text_file"
        And I click on the radio labeled "Drag-N-Drop Logic Builder"
        Then I should see "Displaying field choices for the following data collection instrument"

        Given I drag the field choice labeled "radio_button_manual = Choice101 (101)" to the box labeled "Show the field ONLY if..."
        And I click on the button labeled "Save"
        Then I should see "Branching logic: [radio_button_manual] = '101'" within the field with variable name "descriptive_text_file"

        Given I click on the icon labeled "Branching Logic" in the row labeled "required"
        And I click on the radio labeled "Drag-N-Drop Logic Builder"
        Then I should see "Displaying field choices for the following data collection instrument"

        When I drag the field choice labeled "checkbox = Checkbox3 (3)" to the box labeled "Show the field ONLY if..."
        And I click on the button labeled "Save"
        Then I should see "Branching logic: [checkbox(3)] = '1'" within the field with variable name "required"

        #FUNCTIONAL_REQUIREMENT: survey mode
        When I click on the link labeled "Survey Distribution Tools"
        And I click on the button labeled "Open public survey"
        And I select the radio option "Choice101" for the field labeled "Radio Button Manual"
        Then I should see "Descriptive Text with File"

        When I select the radio option "Choice99" for the field labeled "Radio Button Manual"
        Then I should NOT see "Descriptive Text with File"

        When I check the checkbox labeled "Checkbox3"
        Then I should see the field labeled "Required"

        When I uncheck the checkbox labeled "Checkbox3"
        Then I should NOT see the field labeled "Required"
        #Manual: Close the survey page

        ##VERIFY_LOG
        Given I return to the REDCap page I opened the survey from
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Add/edit branching logic                |

    Scenario: B.4.9.0100.200 Branching Logic via Data Dictionary Upload
        When I click on the link labeled "My Projects"
        And I create a new project named "B.4.9.0100.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_4.9.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"
        
        When I click on the link labeled "Designer"
        And I click on the link labeled "Data Types"
        Then I should NOT see "Branching logic: [record_id] = '100'"

        #MANUAL TESTING ONLY: Download dictionary
    #   When I click on the link labeled "Dictionary"
    #   And I click on the button labeled "Download Data Dictionary" and save the file to a location on my computer
    #   Then I should see a csv file downloaded
    #   #MANUAL TESTING ONLY: Add branching logic to field
    #   When I navigate to the downloaded data dictionary file
    #   And I add branching logic "[record_id] = '100'" to the field with variable name "ptname"
    #   And I save a new version of the file with the added branching logic

        #Action: Upload Modified Data Dictionary
        #Manual If doing this manually upload the modified data dictionary file with the added branching logic.
        When I click on the link labeled "Dictionary"
        And I upload a "csv" format file located at "dictionaries/Project_4.9.modified.csv", by clicking the button near "Upload your Data Dictionary file" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see "Your document was uploaded successfully and awaits your confirmation below."
        When I click on the button labeled "Commit Changes"
        Then I should see "Changes Made Successfully!"
        #VERIFY: Branching logic has been added to the field with variable name "ptname"
        When I click on the link labeled "Designer"
        And I click on the link labeled "Data Types"
        Then I should see "Branching logic: [record_id] = '100'" within the field with variable name "ptname"

        #FUNCTIONAL_REQUIREMENT: Verify branching logic in survey mode
        When I click on the link labeled "Survey Distribution Tools"
        And I click on the button labeled "Open public survey"
        Then I should NOT see the field labeled "Name"
        #Manual: Close the survey page

        #VERIFY_LOG
        Given I return to the REDCap page I opened the survey from
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Upload data dictionary                  |
#End