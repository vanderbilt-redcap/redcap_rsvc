Feature: Field Creation: The system shall support the ability to add, edit, copy, move and delete data collection fields.

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.1900.100 Add, edit, copy, move and delete fields
        #SETUP
        Given I login to REDCap with the user "Test_Admin"

        # BEGIN: STEPS FOR ATS
        # - EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, project request behavior does not work properly
        # - CUSTOM MESSAGE SET - Makes the dialog box pop up when requesting a project
        Given I click on the link labeled "Control Center"
        And I click on the link labeled "General Configuration"
        Then I should see "General Configuration"

        When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed"
        # END: STEPS FOR ATS ###

        And I create a new project named "B.6.7.1900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_USER_RIGHTS
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled exactly "Assign" on the role selector dropdown
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

        ##SETUP_PRODUCTION
        When I click on the link labeled "Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"
        And I logout

        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.6.7.1900.100"
        And I click on the link labeled "Setup"
        And I click on the button labeled "Online Designer"
        Then I should see "Data Collection Instruments"

        When I click on the button labeled "Enter Draft Mode"
        Given I click on the button labeled "Dismiss"
        Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: add field
        When I click on the link labeled "Data Types"
        #MANUAL NOTE: the last button is the one at the bottom of the instrument
        And I click on the last button labeled "Add Field"
        When I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Add Field" into the Field Label of the open "Add New Field" dialog box
        And I enter "add" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save"

        ##VERIFY
        Then I should see the field labeled "Add Field"

        #FUNCTIONAL_REQUIREMENT
        #ACTION: move field within instrument
        And I drag the field variable named "add" below the field variable named "identifier"

        # Note: REDCap requires user reload the Online Designer before MOVING a newly added field
        Given I click on the link labeled "Setup"
        When I click on the button labeled "Online Designer"
        And I click on the link labeled "Data Types"
        ##VERIFY
        Then I should see the field named "Add Field" before field named "Identifier"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: move field to another instrument
        And I click on the Move image for the field named "Required"

        #Then I should see "Move field to another location"
        And I select 'name "Name"' in the dropdown field labeled "Move the field(s) so that it will be located immediately after the following field:" in the dialog box
        And I click on the button labeled "Move field" in the dialog box
        ##VERIFY
        Then I should see "SUCCESSFULLY MOVED"
        And I should see 'Successfully moved the field(s) to a new location on another data collection instrument'
        And I click on the button labeled "Close" in the dialog box

        #The following button is covering the "Return to list of instruments" button
        Given I click on the button labeled "Dismiss"
        When I click on the button labeled "Return to list of instruments"
        And I click on the link labeled "Text Validation"
        Then I should see the field labeled "Required"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: edit field
        Given I click on the button labeled "Return to list of instruments"
        And I click on the link labeled "Data Types"
        And I click on the Edit image for the field named "Radio Button Manual"
        And I clear field and enter Choices of "9..9, Choice99" into the open "Edit Field" dialog box
        And I enter Choices of "100, Choice100" into the open "Edit Field" dialog box
        And I enter Choices of "101, Choice101" into the open "Edit Field" dialog box
        And I enter Choices of "Abc123, Choice Abc123" into the open "Edit Field" dialog box
        And I click on the button labeled "Save"

        ##VERIFY
        Then I should see the field labeled "Radio Button Manual"
        And I should see the radio field labeled "Radio Button Manual" with the options below
            | Choice99      |
            | Choice100     |
            | Choice101     |
            | Choice Abc123 |

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: copy field
        Given I see the field labeled "Notes box"
        And I click on the Copy image for the field named "Notes box"

        ##VERIFY
        Then I should see a field named "notesbox_2"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: delete field
        Given I see the field labeled "Multiple Choice Dropdown Manual"
        And I click on the Delete Field image for the field named "Multiple Choice Dropdown Manual"
        And I click on the button labeled "Delete" in the dialog box

        ##VERIFY
        Then I should NOT see a field labeled "Multiple Choice Dropdown Manual"

        ##VERIFY_DRAFT_CHANGES
        When I click on the link labeled "View detailed summary of all drafted changes"

        Then I should see "Fields to be ADDED:"
        And I should see 'notesbox_2 "Notes box"'
        And I should see 'add "Add Field"'
        And I should see "Fields to be DELETED:"
        And I should see 'multiple_dropdown_manual "Multiple ...  Manual" (8 records/events affected)'
        Then I should see a table row containing the following values in a table:
            | Variable Name       | Choices or Calculations |
            | radio_button_manual | 9..9, Choice99          |
            | radio_button_manual | 100, Choice100          |
            | radio_button_manual | 101, Choice101          |
            | radio_button_manual | Abc123, Choice Abc123   |

        ##SETUP_PRODUCTION
        When I click on the button labeled "RETURN TO PREVIOUS PAGE"
        And I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit" in the dialog box
        Then I should see "Awaiting review of project changes"
        And I logout

        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.6.7.1900.100"
        And I click on the link labeled "Setup"
        And I click on the button labeled "Online Designer"
        Then I should see "Project Modification Module"

        When I click on the button labeled "Project Modification Module"
        And I click on the button labeled "COMMIT CHANGES"
        Then I should see a dialog containing the following text: "COMMIT CHANGES TO PROJECT?"
        And I click on the button labeled "COMMIT CHANGES" in the dialog box
        Then I should see "Project Changes Committed / User Notified"

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name | Field Label         | Field Attributes |
            | [add]                 | Add Field           | text             |
            | [radio_button_manual] | Radio Button Manual | Choice Abc123    |
            | [notesbox_2]          | Notes box           | notes            |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username  | Action        | List of Data Changes OR Fields Exported |
            | test_user | Manage/Design | Delete project field                    |
            | test_user | Manage/Design | Copy project field                      |
            | test_user | Manage/Design | Edit project field                      |
            | test_user | Manage/Design | Move project field                      |
            | test_user | Manage/Design | Create project field                    |
#END