Feature: User Interface: The logging module shall provide the ability to export audit trail.

    As a REDCap end user
    I want to see that Logging Module is functioning as expected

    Scenario: B.2.23.0200.100 Logging module export
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.2.23.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Logging Module
        When I click on the link labeled "Logging"
        And I click on the button labeled "All logging"

        ##VERIFY
        Then I should see the latest downloaded "csv" file containing the headings below
            | "Time / Date" | Username | Action | "List of Data Changes OR Fields Exported" | Record |
#END