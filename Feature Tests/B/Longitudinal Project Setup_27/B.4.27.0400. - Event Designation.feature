Feature: User Interface: Longitudinal Project Settings: The system shall support the ability to designate data collection instruments for defined events in each arm.

    As a REDCap end user
    I want to see that Project Setup is functioning as expected

    Scenario: B.4.27.0400.100 Ability to designate data collection instruments for defined events in each arm
        ##SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.4.27.0400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        ##SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        ##SETUP
        When I click on the link labeled "Setup"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Arm 1"
        Then I should see the button labeled "Add new event"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Add new events
        Given I add an event named "Event 4" with offset of 4 days into the currently selected arm
        Then I should see "Event 4" in the define events table

        When I click on the link labeled "Arm 2"
        Given I add an event named "Event 2" with offset of 2 days into the currently selected arm
        Then I should see "Event 2" in the define events table

        ##ACTION Designate Instruments
        When I click on the link labeled "Designate Instruments for My Events"
        And I click on the link labeled "Arm 1"
        And I click on the button labeled "Begin Editing"
        And I enable the Data Collection Instrument named "Data Types" for the Event named "Event 4"
        And I click on the button labeled "Save"
        Then I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 4"

        When I click on the link labeled "Arm 2"
        And I click on the button labeled "Begin Editing"
        And I enable the Data Collection Instrument named "Survey" for the Event named "Event 2"
        And I click on the button labeled "Save"
        Then I verify the Data Collection Instrument named "Survey" is enabled for the Event named "Event 2"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported                                          |
            | test_admin | Manage/Design | Create event (Event: Event 2, Arm: Arm Two, Days Offset: 2, Offset Range: -0/+0) |
            | test_admin | Manage/Design | Create event (Event: Event 4, Arm: Arm 1, Days Offset: 4, Offset Range: -0/+0)   |

        ##VERIFY_RSD
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "Arm 1"
        Then I should see the "Incomplete (no data saved)" icon for the "Data Types" longitudinal instrument on event "Event 4" for record "1"

        When I click on the link labeled "Arm 2"
        Then I should see a table header and rows containing the following values in the record status dashboard table:
            | Event 1    | Event 2 |
            | Data Types | Survey  |
#END