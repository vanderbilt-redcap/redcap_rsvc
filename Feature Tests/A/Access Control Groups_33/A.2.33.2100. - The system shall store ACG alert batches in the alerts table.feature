Feature: A.2.33.2100.: The system shall store ACG alert batches in the alerts table.---Database

     As a REDCap end user
     I want to see the system shall store ACG alert batches in the alerts table.---Database

    Scenario: Setup
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.2.33.2100." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
        And I click on the button labeled "Assign to role"
        And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
        And I click on the button labeled "Assign"
        Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    Scenario: A.2.33.2100.: The system shall store ACG alert batches in the alerts table.---Database
        Given I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on the button labeled "Enable Access Control Groups"
        Then I should see "Enable the Access Control Groups feature?"
        When I click on the button labeled "Enable"
        Then I should see a table header and rows containing the following values in a table:
            | Username       | Full Name       | Email                         | Access Control Group  |   
            | site_admin     | Joe User        | joe.user@projectredcap.org    | No Rights          | 
            | Test_Admin     | Admin User      | test_admin@test.edu           | No Rights          |            
            | Test_User1     | Test User1      | Test_User1@test.edu           | No Rights          | 
            | Test_User2     | Test User2      | Test_User2@test.edu           | No Rights          | 
            | Test_User3     | Test User3      | Test_User3@test.edu           | No Rights          | 
            | Test_User4     | Test_User4      | Test_User4@test.edu           | No Rights          |

        Given I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.33.2100."
        And I click on the link labeled "ACGs"
        Then I should see "NOTICE: Only REDCap administrators can access this page."
        And I should see "Project Compliance"

        And I click on the checkbox labeled "test_user1"
        And I click on the button labeled "Email User(s)"
        And I enter "Test" into the input field labeled "Subject:"
        When I enter "My email body content" into the textarea field labeled "Email Body:"
        And I click on the button labeled "Send Alerts"
        And I click on the button labeled "Ok"
        When I click on the link labeled "Compliance Alert Logs"
        Then I should see a table header and rows containing the following values in a table:
            | Batch ID | Alert ID | Alert At | Alert Type | Alert Category | Affected Users          | Recipient                                  | Alert Text           | Alert Status |
            |          | 1        |          | Initial    | Users          | test_user1 (Test User1) | Test_User1 (Test User1) Test_User1@test.edu | My email body content| Success       |

#END
