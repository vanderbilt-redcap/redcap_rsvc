Feature: User Interface: Survey Project Settings: The system shall support enabling and disabling survey functionality at the project level.

    As a REDCap end user
    I want to see that Manage project user access is functioning as expected

    Scenario: B.6.4.1300.100 Enable/Disable survey in Project Set-up
        #SETUP
        Given I login to REDCap with the user "Test_User1"
        And I create a new project named "B.6.4.1300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        ##VERIFY columns in Designer when Survey is Enabled
        Given I click on the link labeled "Designer"
        Then I should see a table header containing the following values in a table:
            | Instrument name | Fields | PDF | Enabled as\nsurvey | Instrument actions | Survey related options |

        Given I click on the link labeled "Setup"
        When I click on the button labeled "Disable" in the "Use surveys in this project?" row in the "Main project settings" section
        And I click on the button labeled "Disable" on the dialog box

        ##VERIFY
        And I should see a button labeled "Enable" in the "Use surveys in this project?" row in the "Main project settings" section

        ##VERIFY columns in Designer when Survey is Disabled
        Given I click on the link labeled "Designer"
        Then I should see a table header containing the following values in a table:
            | Instrument name | Fields | PDF | Instrument actions |

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Modify project settings                 |

        When I click on the link labeled "Setup"
        #FUNCTIONAL REQUIREMENT
        ##ACTION Enable survey in project setup
        And I click on the button labeled "Enable" in the "Use surveys in this project?" row in the "Main project settings" section
        ##VERIFY
        And I should see a button labeled "Disable" in the "Use surveys in this project?" row in the "Main project settings" section

        ##ACTION Enable survey in Online Designer #B.3.15.100.100
        Given I click on the link labeled "Designer"
        And I click on the "Enable" button for the instrument row labeled "Text Validation"
        And I click on the button labeled "Save Changes"
        ##VERIFY
        Then I should see "Your survey settings were successfully saved!"

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Set up survey                           |

        ##ACTION Disable survey in Online Designer #B.3.15.100.100
        Given I click on the link labeled "Designer"
        And I click on the "Survey settings" button for the instrument row labeled "Text Validation"
        And I click on the button labeled "Delete Survey Settings"
        And I click on the button labeled "Delete Survey Settings" in the dialog box
        And I click on the button labeled "Close" in the dialog box

        ###VERIFY
        Then I should see the "Enable" button for the instrument row labeled "Text Validation"

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Delete survey                           |
#END