Feature: A.2.33.2400.: The system shall support batch IDs for ACG alerts.---Alerts Table

     As a REDCap Administrator
     I want to see The system shall support batch IDs for ACG alerts.---Alerts Table
        So that I can identify which alerts were sent together in the same batch.

    Scenario: Setup
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.2.33.2400." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        And I click on the button labeled "Add user"
        Then I should see 'User "Test_User1" was successfully added'
       
        When I click on the link labeled "User Rights"
        And I enter "Test_User2" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        And I click on the button labeled "Add user"
        Then I should see 'User "Test_User2" was successfully added'

        When I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on the button labeled "Enable Access Control Groups"
        Then I should see "Enable the Access Control Groups feature?"
        When I click on the button labeled "Enable"
        Then I should see a table header and rows containing the following values in a table:
            |Username       |Full Name       |Email                         |Access Control Group  |
            |site_admin     |Joe User        |joe.user@projectredcap.org    | No Rights            |
            |Test_Admin     |Admin User      |test_admin@test.edu           | No Rights            |
            |Test_User1     |Test User1      |Test_User1@test.edu           | No Rights            |
            |Test_User2     |Test User2      |Test_User2@test.edu           | No Rights            |
            |Test_User3     |Test User3      |Test_User3@test.edu           | No Rights            |
            |Test_User4     |Test User4      |Test_User4@test.edu           | No Rights            |

    Scenario: A.2.33.2400.: The system shall support batch IDs for ACG alerts.---Alerts Table
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "A.2.33.2400."
        And I click on the link labeled "ACGs"
        Then I should see "Only REDCap administrators can access this page."
        And I should see "Project Compliance"

        When I click on the checkbox labeled "test_user1"
        And I click on the checkbox labeled "test_user2"
        And I click on the button labeled "Email User(s)"
        And I enter "Batch ID Test" into the input field labeled "Subject:"
        And I enter "Alert message sent in one batch" into the textarea field labeled "Email Body:"
        And I click on the button labeled "Send Alerts"
        And I click on the button labeled "Ok"

        When I click on the link labeled "Compliance Alert Logs"
        Then I should see a table header and rows containing the following values in a table:
            |Batch ID|Alert ID|Alert At|Alert Type|Alert Category|Affected Users          |Recipient                                  |Alert Text                       |Alert Status|
            |       |1       |        |Initial   |Users         |test_user1 (Test User1) |Test_User1 (Test User1) Test_User1@test.edu|Alert message sent in one batch  |Success     |
            |       |2       |        |Initial   |Users         |test_user2 (Test User2) |Test_User2 (Test User2) Test_User2@test.edu|Alert message sent in one batch  |Success     |

        #Sending a second batch of alerts to verify that new ID is generated for the new batch
        When I click on the link labeled "Project Compliance"
        And I click on the checkbox labeled "test_user1"
        And I click on the checkbox labeled "test_user2"
        And I click on the button labeled "Email User(s)"
        And I enter "Batch ID Test 2" into the input field labeled "Subject:"
        And I enter "Alert message sent in second batch" into the textarea field labeled "Email Body:"
        And I click on the button labeled "Send Alerts"
        Then I should see "Previous alert detected"
        And I should see "All the users in your selection were alerted less than 14 days ago"
        And I should see "Would you like to resend the alert to all users?"
        And I click on the button labeled "Send to all"
        And I click on the button labeled "Ok"

        When I click on the link labeled "Compliance Alert Logs"
        Then I should see a table header and rows containing the following values in a table:
            |Batch ID|Alert ID|Alert At|Alert Type|Alert Category|Affected Users          |Recipient                                  |Alert Text                         |Alert Status|
            |        |3       |        |Initial   |Users         |test_user1 (Test User1) |Test_User1 (Test User1) Test_User1@test.edu|Alert message sent in second batch |Success     |
            |        |4       |        |Initial   |Users         |test_user2 (Test User2) |Test_User2 (Test User2) Test_User2@test.edu|Alert message sent in second batch |Success     |







#END