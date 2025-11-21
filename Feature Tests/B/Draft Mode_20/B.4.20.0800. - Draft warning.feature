Feature: User Interface: The system shall flag any changes that may negatively impact data with the following critical warnings: Possible label mismatch | Possible data loss | Data WILL be lost

    As a REDCap end user
    I want to see that Draft mode is functioning as expected

    Scenario: B.4.20.0800.100 Flag critical warnings
        ##ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
        Given I login to REDCap with the user "Test_Admin"
        When I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        Then I should see "System-level User Settings"
        Given I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        When I click on the button labeled "Save Changes"
        And I see "Your system configuration values have now been changed!"
        Then I logout

        #SETUP
        Given I login to REDCap with the user "Test_User1"
        And I create a new project named "B.4.20.0800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        ##ACTION: Draft Mode
        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_user1 | Manage/Design | Enter draft mode                        |

        ##ACTION
        When I click on the link labeled "Designer"
        And I click on the link labeled "Data Types"
        And I click on the Edit image for the field named "Radio Button Manual"

        #DATA WILL BE LOST
        # Edit existing second row from value of 100 to 101
        # Delete third row
        And I clear field and enter Choices of "9..9, Choice99" into the open "Edit Field" dialog box
        And I enter Choices of "101, Choice100" into the open "Edit Field" dialog box

        #DATA MISMATCH
        And I click on the button labeled "Save"
        Then I should see the radio field labeled "Radio Button Manual" with the options below
            | Choice99  |
            | Choice100 |

        ##FUNCTIONAL_REQUIREMENT
        When I click on the link labeled "View detailed summary of all drafted changes"
        Then I should see "Will these changes be automatically approved?"
        And I should see "No, an admin will have to review these changes."
        And I should see a table header and rows containing the following values in a table:
            | Variable Name       | Choices or Calculations                                           |
            | radio_button_manual | *Possible label mismatch because of label changes. Check if okay. |
            | radio_button_manual | *Data MIGHT be lost due to deleted choice(s)                      |

        When I click on the button labeled "Compare"
        And I should see a table header and rows containing the following values in a table:
            | Existing Value | Status  | Number of records having this value |
            | 100            | Removed | 8                                   |
            | 101            | Altered | 0                                   |

        And I click on the button labeled "Close" in the dialog box
#END