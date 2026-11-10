Feature: User Interface: The system shall support the ability to restrict users from printing data entry forms via their browser.

    As a REDCap end user
    I want to see that printing data entry forms is functioning as expected

    Scenario: A.5.21.0700. - Control Center - User Settings: The system shall support the system-level restriction of printing data entry forms via their browser if they lack Full Data Set export privileges for the form.
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.5.21.0700" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
       
        #USER_RIGHTS
        And I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "4_NoAccess_Noexport" on the dropdown field labeled "Select Role" on the role selector dropdown
        When I click on the button labeled "Assign"
        Then I should see a table header and rows containing the following values in a table:
            | Role name           | Username   |
            | 4_NoAccess_Noexport | test_user1 |

        #Update Roles rights to View & Edit + Edit survey responses
        When I click on the link labeled "4_NoAccess_Noexport"
        And I click on the radio in the column labeled "View & Edit" and the row labeled "Text Validation"
        And I click on the button labeled "Save Changes"
        Then I should see 'Role "4_NoAccess_Noexport" was successfully edited'
        And I logout

        #Test user with no export rights cannot print data entry forms
        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Project" 
        And I click on the link labeled "A.5.21.0700"
        Then I should see "A.5.21.0700"

        When I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click on the icon in the column labeled "Event 1" and the row labeled "Text Validation"
        Then I should see "Text Validation"

        #Validate printing is not allowed for users without Full Data Set export privileges
        #Manual Testing: Click on the browser's print button or use the keyboard shortcut to print the page. Verify that the content is replaced with 'ERROR: Because you do not have "Full Data Set" privileges as your Data Export Rights for this specific instrument, you are not allowed to print/export this data entry form.'
        #Automated Testing: The below line verifies that when the user attempts to print the current page, the content is replaced with the expected error message.
        When I verify that when I print the current page the content is replaced with 'ERROR: Because you do not have "Full Data Set" privileges as your Data Export Rights for this specific instrument, you are not allowed to print/export this data entry form.'

#END