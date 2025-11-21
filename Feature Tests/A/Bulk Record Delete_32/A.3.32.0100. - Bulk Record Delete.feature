Feature: A.3.32.0100. The system shall allow REDCap administrators to enable or disable the Bulk Record Delete feature at the system level in the Control Center.

    As a REDCap end user
    I want to see that Bulk Record Delete is functioning as expected

    Scenario: A.3.32.0100.100 Enable/Disable file repository public links via Control Center

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "A.3.32.0100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
        And I click on the link labeled "My Projects"
        And I click on the link labeled "A.3.32.0100.100"

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        When I click on the link labeled "Other Functionality"
        Then I should see a button labeled "Bulk Record Delete"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Disable Bulk Record Delete page
        When I click on the link labeled "Control Center"
        And I click on the link labeled "Modules/Services Configuration"
        Then I should see "Settings pertaining to the External Module Framework"

        When I select "Disabled" on the dropdown field labeled " Bulk Record Delete"
        And I click on the button labeled "Save Changes"
        ##VERIFY Bulk Record Delete Module Disabled
        Then I should see "Your system configuration values have now been changed!"

        ##VERIFY Bulk Record Delete is disabled
        When I click on the link labeled "My Projects"
        And I click on the link labeled "A.3.32.0100.100"

        When I click on the link labeled "Other Functionality"
        Then I should NOT see a button labeled "Bulk Record Delete"
        Given I logout
#END