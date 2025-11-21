Feature: A.2.3.0300. Assign administrators and account managers

    Scenario: A.2.3.0300.100 Modify and Revoke Admin's User Rights

        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Administrator Privileges"
        Then I should see "Set administrator privileges"

        When I enter "Test_User1" into the field with the placeholder text of "Search users to add as admin"
        And I enable the Administrator Privilege "Access to Control Center dashboards" for a new administrator
        And I enable the Administrator Privilege "Manage user accounts" for a new administrator
        And I enable the Administrator Privilege "Modify system configuration pages" for a new administrator
        And I enable the Administrator Privilege "Perform REDCap upgrades" for a new administrator
        And I enable the Administrator Privilege "Access to all projects and data with maximum user privileges" for a new administrator
        And I enable the Administrator Privilege "Install, upgrade, and configure External Modules" for a new administrator
        And I click on the button labeled "Add"
        Then I should see 'The user "Test_User1" has now been granted one or more administrator privileges'
        And I click on the button labeled "OK"
        And I should see "Test_User1"

        Given I logout

        Given I login to REDCap with the user "Test_User1"
        When I click on the link labeled "Control Center"
        Then I should see "Control Center Home"
        # Checking if 'Access to Control Center dashboards' is enabled
        And I should see a link labeled "System Statistics"
        # Checking if 'Manage user accounts' is enabled
        And I should see a link labeled "Browse Users"
        # Checking if 'Perform REDCap upgrades' is enabled
        When I click on the link labeled "Configuration Check"
        Then I should NOT see "you have restricted admin privileges"
        # Checking if 'Modify system configuration pages' is enabled
        When I click on the link labeled "General Configuration"
        And I should see a button labeled "Save Changes"
        # Checking if 'Install, upgrade, and configure External Modules' is enabled
        When I click on the link labeled "Manage"
        And I should see a button labeled "Enable a module"
        Given I logout

        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Administrator Privileges"
        Then I should see "Set administrator privileges"

        Given I disable the Administrator Privilege "Access to Control Center dashboards" for the administrator "Test_User1"
        And I disable the Administrator Privilege "Manage user accounts" for the administrator "Test_User1"
        And I disable the Administrator Privilege "Modify system configuration pages" for the administrator "Test_User1"
        And I disable the Administrator Privilege "Perform REDCap upgrades" for the administrator "Test_User1"
        And I disable the Administrator Privilege "Install, upgrade, and configure External Modules" for the administrator "Test_User1"
        And I logout
        And I login to REDCap with the user "Test_User1"
        When I click on the link labeled "Control Center"
        
        Then I should see "Control Center Home"
        # Checking if 'Access to Control Center dashboards' is disabled
        And I should NOT see a link labeled "System Statistics"
        # Checking if 'Manage user accounts' is disabled
        And I should NOT see a link labeled "Browse Users"
        # Checking if 'Perform REDCap upgrades' is disabled.
        When I click on the link labeled "Configuration Check"
        Then I should see "you have restricted admin privileges"
        # Checking if 'Modify system configuration pages' is disabled
        
        When I click on the link labeled "General Configuration"
        Then I should NOT see a button labeled "Save Changes"
        # Checking if 'Install, upgrade, and configure External Modules' is disabled
        
        When I click on the link labeled "Manage"
        Then I should NOT see a button labeled "Enable a module"
        
        Given I logout

        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Administrator Privileges"
        Then I should see "Set administrator privileges"

        Given I disable the Administrator Privilege "Access to all projects and data with maximum user privileges" for the administrator "Test_User1"
        Then I should see a dialog containing the following text: "NOTICE"
        And I should see a dialog containing the following text: "Please be aware that you have unchecked ALL the administrator privileges for this user"
        When I click on the button labeled "Close" in the dialog box
        And I logout
        And I login to REDCap with the user "Test_User1"
        And I should NOT see a link labeled "Control Center"
        Given I logout
#End