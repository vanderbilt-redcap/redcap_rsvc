Feature: A.2.33.1600.: The system shall restore the default ACG violation message when the custom message is cleared.---Control Center

    As an Admin
    I want to see that I can restore the default ACG violation message when the custom message is cleared.

    Scenario: A.2.33.1600.: The system shall restore the default ACG violation message when the custom message is cleared.---Control Center
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on the button labeled "Enable Access Control Groups"
        Then I should see "Enable the Access Control Groups feature?"
        When I click on the button labeled "Enable"
        Then I should see "ACG enabled"
       
        When I click on the third link labeled "Access Control Groups"
        And I click on the button labeled "Set custom ACG error message"
        When I enter "Custom message goes here." into the textarea field labeled "Optional custom error message to display when an ACG compliance violation occurs:"
        And I click on the button labeled "Save"
        Then I should see "Custom ACG error message successfully saved!"
        And I click on the button labeled "Close"

        Given I click on the link labeled "New Project"
        And I create a new project named "A.2.33.1600." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled "Assign"
       
        #Verify custom validation error message
        Then I should see "Custom message goes here."
        And I click on the button labeled "Ok"

        Given I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on the third link labeled "Access Control Groups"
        And I click on the button labeled "Set custom ACG error message"
        And I click on "" in the textarea field labeled "Optional custom error message to display when an ACG compliance violation occurs:"
        And I wait for 2 seconds
        And I clear field and enter " " into the textarea field labeled "Optional custom error message to display when an ACG compliance violation occurs:"
        And I click on the button labeled "Save"
        Then I should see "Custom ACG error message successfully saved!"

        #Verify default validation error message
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.33.1600"
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled "Assign"

        Then I should see "The user privileges below do not comply with the user's Access Control Group privileges. The user cannot be given any of the privileges below and cannot be assigned to a user role that has any of these privileges. Please try again."
        And I click on the button labeled "Ok"


#END