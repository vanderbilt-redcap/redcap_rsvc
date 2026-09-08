Feature: A.2.33.0700.: The system shall support uploading and downloading ACG definitions via CSV.---Access Control Groups → Upload/Download

     As a REDCap end user
     I want to see the system shall support uploading and downloading ACG definitions via CSV.---Access Control Groups → Upload/Download

    Scenario: Setup
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.2.33.0700." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

    Scenario: A.2.33.0700.: The system shall support uploading and downloading ACG definitions via CSV.---Access Control Groups → Upload/Download
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on "Enable Access Control Groups"
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
       
        When I click on the tab labeled "Access Control Groups"
        And I click on the button labeled "Upload or download ACGs"
        And I upload a "csv" format file located at "import_files/ACG_DownloadedGroups.csv", by clicking the button near "Upload ACGs (CSV)" to browse for the file
        And I click on the button labeled "Confirm Import"
        Then I should see "Access Control Groups imported successfully"
        And I click on the button labeled "Close"
        And I logout

        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        When I click on the tab labeled "Access Control Groups"
        And I click on the button labeled "Upload or download ACGs"
        And I click on the link labeled "Download ACGs (CSV raw)"
        Then I should see the following values in the last file downloaded
            | group_name |
            | New_ACG_2  |
            | New_ACG_1  |
            | No Rights  |
#END
