
Feature: A.2.6.0700. - Control Center - User Settings: The system shall support a system-level policy controlling whether users without existing REDCap accounts may be added to projects.
  As I administer I want to ensure that users without existing REDCap accounts are added to projects according to the system policy.

  Scenario: A.2.6.0700.100 Allow a user without an existing REDCap account to be added to a project when the system policy permits it.
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.2.6.0700.100." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"
        
        # Ensuring the setting allows adding users without existing REDCap accounts
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Security & Authentication"
        And I select "LDAP & Table-based" on the dropdown field labeled "Authentication Method"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        When I click on the link labeled "User Settings"
        And I select "Yes" on the dropdown field labeled "Allow adding non-existent users to projects?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        # Add user that doesn't exist to project
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.6.0700.100."
        And I click on the link labeled "User Rights"
        And I enter "test_user5" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        And I click on the button labeled "Add user"
        Then I should see 'User "test_user5" was successfully added'

        #Validate the user does not already have an account in REDCap
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Browse Users"
        Then I should see "Browse Users"
        When I enter "test_user5" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
        And I click on the button labeled "Search"
        Then I should see "User does not exist!"



  Scenario: A.2.6.0700.200 Prevent a user without an existing REDCap account from being added through User Rights when the system policy prohibits it.
        # Deactivate the setting that allows adding non-existent users to projects
        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        And I select "No, only allow users to be added to projects if they have an account" on the dropdown field labeled "Allow adding non-existent users to projects?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        # Add user that doesn't exist to project
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.6.0700.100."
        And I click on the link labeled "User Rights"
        And I enter "test_user6" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see 'ERROR: The user "test_user6" cannot be added because it does not match any existing user account in this REDCap system. Their user account must be created before you can grant them project access. Please double‑check the spelling of the username.'

  Scenario: A.2.6.0700.300 Under strict table-based authentication, prohibit adding a user without an existing REDCap account regardless of the optional policy available to other authentication methods.
        Given I click on the link labeled "Control Center"
        And I click on the link labeled "Security & Authentication"
        And I select "Table-based" on the dropdown field labeled "Authentication Method"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

        When I click on the link labeled "User Settings"
        Then I should see a dropdown labeled "Allow adding non-existent users to projects?" that is disabled
        
        # Add user that doesn't exist to project
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.6.0700.100."
        And I click on the link labeled "User Rights"
        And I enter "test_user6" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see 'ERROR: The user "test_user6" cannot be added because it does not match any existing user account in this REDCap system. Their user account must be created before you can grant them project access. Please double‑check the spelling of the username.'

  Scenario: A.2.6.0700.400 Display the standard error message when adding a user without an existing account is prohibited and no custom message is configured.
        #REDUNDENT AND CAN BE SEEN IN .200 and .400 above.
  Scenario: A.2.6.0700.500 Display the administrator-configured error message when adding a user without an existing account is prohibited and custom message text is configured.
        Given I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        And I enter "Contact your REDCap administrator to request an account." into the textarea field labeled "(Optional) Custom error message displayed when adding non-existent user on User Rights page:"   
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"
        
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.6.0700.100."
        And I click on the link labeled "User Rights"
        And I enter "test_user6" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Contact your REDCap administrator to request an account."

#END
