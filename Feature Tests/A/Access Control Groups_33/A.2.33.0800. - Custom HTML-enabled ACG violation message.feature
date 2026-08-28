Feature: A.2.33.0800.: The system shall allow defining a custom HTML-enabled ACG violation message

    As an Admin
    I want to see that I can allow allow defining a custom HTML-enabled ACG violation message.

    Scenario: A.2.33.0800.: The system shall allow defining a custom HTML-enabled ACG violation message.
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on "Enable Access Control Groups"
        Then I should see "Enable the Access Control Groups feature?"
        When I click on the button labeled "Enable"
        Then I should see "ACG enabled"
       
        When I click on the third link labeled "Access Control Groups"
        And I click on the button labeled "Set custom ACG error message"
        When I enter "The user privileges below do not comply with the user's Access Control Group privileges. The user cannot be given any of the privileges below and cannot be assigned to a user role that has any of these privileges. Please try again." into the textarea field labeled "Optional custom error message to display when an ACG compliance violation occurs:"
        And I click on the button labeled "Save"
        Then I should see "Custom ACG error message successfully saved!"
        And I click on the button labeled "Close"
#END