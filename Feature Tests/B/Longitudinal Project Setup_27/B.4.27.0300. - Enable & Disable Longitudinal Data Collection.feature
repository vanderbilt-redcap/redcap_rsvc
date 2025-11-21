Feature: User Interface: Longitudinal Project Settings: The system shall support enabling and disabling longitudinal data collection.

    As a REDCap end user
    I want to see that Project Setup is functioning as expected

    Scenario: B.4.27.0300.100 Change project longitudinal status
        #ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        Then I should see "System-level User Settings"
        Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        When I click on the button labeled "Save Changes"
        And I see "Your system configuration values have now been changed!"
        Then I logout

        ##SETUP_DEV
        Given I login to REDCap with the user "Test_User1"
        And I create a new project named "B.4.27.0300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        ##ACTION Verify event exist ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 1"
        Then I should see a table header containing the following values in the record status dashboard table:
            | Record ID | Event 1 | Event 2 | Event Three |

        #FUNCTIONAL REQUIREMENT
        ##ACTION Disable longitudinal
        When I click on the link labeled "Setup"
        And I click on the button labeled "Disable" in the row labeled "Use longitudinal data collection with defined events?"
        And I click on the button labeled "Disable" in the dialog box
        Then I should see the button labeled "Enable" in the row labeled "Use longitudinal data collection with defined events?"

        ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        Then I should NOT see "Event 1"
        And I should see a table header containing the following values in the record status dashboard table:
            | Record ID | Text Validation | Data Types | Survey | Consent |


        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Modify project settings                 |

        #FUNCTIONAL REQUIREMENT
        ##ACTION Enable longitudinal
        When I click on the link labeled "Setup"
        And I click on the button labeled "Enable" in the row labeled "Use longitudinal data collection with defined events?"
        Then I should see the button labeled "Disable" in the row labeled "Use longitudinal data collection with defined events?"

        ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 1"
        Then I should see a table header containing the following values in the record status dashboard table:
            | Record ID | Event 1 | Event 2 | Event Three |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Modify project settings                 |

        ##SETUP_PRODUCTION
        When I click on the link labeled "Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Verify longitudinal button is disabled in production mode for user
        When I click on the link labeled "Setup"
        ###VERIFY
        Then I should see the button labeled "Disable" in the row labeled "Use longitudinal data collection with defined events?" that is disabled
        And I logout

        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Browse Projects"
        Then I should see "Viewing projects accessible by user:"

        When I enter "B.4.27.0300.100" into the input field labeled "Search project title by keyword(s):"
        And I click on the button labeled "Search project title"
        Then I should see a row labeled "B.4.27.0300.100" in the projects table
        And I click on the link labeled "B.4.27.0300.100"
        Then I should see "Project Home"

        ##ACTION Admin disable longitudinal while in production
        Given I click on the link labeled "Setup"
        And I click on the button labeled "Disable" in the row labeled "Use longitudinal data collection with defined events?"
        And I click on the button labeled "Disable" in the dialog box
        Then I should see the button labeled "Enable" in the row labeled "Use longitudinal data collection with defined events?"

        ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        Then I should NOT see "Event 1"
        And I should see a table header containing the following values in the record status dashboard table:
            | Record ID | Text Validation | Data Types | Survey | Consent |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Modify project settings                 |
#END