Feature: A.1.1.0100. Run Configuration Check test page

    As a REDCap end user
    I want to see that Configuration Checklist is functioning as expected

    Scenario: A.1.1.0100.100 Configuration Checklist Tests

        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        Then I should be able to locate and visit the Control Center link labeled "Browse Projects"
        And I should be able to locate and visit the Control Center link labeled "Edit Project Settings"
        And I should be able to locate and visit the Control Center link labeled "Configuration Check"
        And I should be able to locate and visit the Control Center link labeled "General Configuration"
        And I should be able to locate and visit the Control Center link labeled "Security & Authentication"
        And I should be able to locate and visit the Control Center link labeled "User Settings"
        And I should be able to locate and visit the Control Center link labeled "File Upload Settings"
        And I should be able to locate and visit the Control Center link labeled "Field Validation Types"

        When I click on the link labeled "Configuration Check"
        Then I should see "Configuration Check"
        And I should see "TEST 1"
        And I should see "SUCCESSFUL! - All necessary files and folders were found."
        And I should see "TEST 2"
        And I should see 'SUCCESSFUL! - The table "redcap_config" in the MySQL database named'
        And I should see "TEST 3"
        And I should see "SUCCESSFUL! - Your REDCap database structure is correct!"
        And I should see "TEST 4"
        And I should see "SUCCESSFUL! - The cURL extension is installed."
        And I should see "TEST 5"
        And I should see "SUCCESSFUL! - Communicated successfully with the REDCap Consortium server."
        And I should see "TEST 6"
#And I should see "SUCCESSFUL! - REDCap Cron job is running properly."
#And I should see "Using SSL"
#And I should see "Using PHP 7.3.0 or higher"
#And I should see "Using MariaDB 5.5.5 or higher"
#And I should see "GD library (version 2 or higher) is installed"
#And I should see "PHP Imagick extension is installed"
#And I should see "PHP Fileinfo extension is installed"
#And I should see "REDCap is able to send emails"
#End