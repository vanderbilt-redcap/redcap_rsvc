Feature: A.2.33.1900.: The system shall allow exporting ACG reports as CSV.---Control Center → Reports

     As a REDCap end user
     I want to see the system shall allow exporting ACG reports as CSV.---Control Center → Reports

    Scenario: Setup
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.2.33.1900." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

        #USER_RIGHTS: add two users with diff access levels
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled "Assign"
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

        When I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "4_NoAccess_Noexport" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled "Assign"
        Then I should see "Test User2" within the "4_NoAccess_Noexport" row of the column labeled "Username" of the User Rights table

        
    Scenario: A.2.33.1900.: The system shall allow exporting ACG reports as CSV.---Control Center → Reports
        Given I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on the button labeled "Enable Access Control Groups"
        Then I should see "Enable the Access Control Groups feature?"
        When I click on the button labeled "Enable"
        Then I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group  |   
            |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights          | 
            |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights          |            
            |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights          | 
            |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights          | 
            |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights          | 
            |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights          |
       
        When I click on the link labeled "Reports"
        And I click on the button labeled "Select report"
        Then I should see the dropdown field labeled "Select report" with the options below
            |Users with Non-compliant Rights (non-expired)|
            |Users with Non-compliant Rights (all)|
            |Projects with Non-compliant Rights (non-expired)|
            |Projects with Non-compliant Rights (all)|
            |Users and Projects with Non-compliant Rights (non-expired)|
            |Users and Projects with Non-compliant Rights (all)|

        #Users with Non-compliant Rights (non-expired) Report
        When I click on the link labeled "Users with Non-compliant Rights (non-expired)"
        Then I should see "Users with Non-compliant Rights (excluding expired users)"
        And I should see a table header and rows containing the following values in a table:
            |User           |Access Control Group   |Project Count |Projects granting Non-compliant Rights to this User|Non-compliant Rights |
            |test_admin     |No Rights              |1             |PID 13                                             |data_export_instruments data_import_tool data_comparison_tool data_logging file_repository user_rights data_access_groups graphical reports design alerts calendar data_entry mobile_app mobile_app_download_data record_create participants data_quality_design data_quality_execute|
            |test_user1     |No Rights              |1             |PID 13                                             |lock_record_customize data_export_instruments data_import_tool data_comparison_tool data_logging email_logging file_repository user_rights data_access_groups graphical reports design alerts calendar data_entry record_create record_rename record_delete participants data_quality_design data_quality_execute data_quality_resolution random_setup random_dashboard random_perform mycap_participants |
            |test_user2     |No Rights              |1             |PID 13                                             |lock_record_customize data_import_tool data_comparison_tool data_logging email_logging file_repository user_rights data_access_groups graphical reports design alerts calendar record_create record_rename record_delete participants data_quality_design data_quality_execute data_quality_resolution random_setup random_dashboard random_perform mycap_participants|
       
       #FUNCTIONAL_REQUIREMENT
        When I click on the button labeled "Export (CSV)"
        Then I should see a downloaded file named "UsersWithNoncompliantRights_nonexpired_yyyy-mm-dd_hhmmss.csv"
       
    
#END