Feature: B.3.14.1400. - User Interface: The system shall display the currently selected record name in the left navigation menu when a user is viewing a record

    As a REDCap end user
    I want to see the currently selected record name in the left navigation menu when I am viewing a record
    So that I always know which record I am working with

    Scenario: B.3.14.1400.100 Selected record name is displayed in the left navigation menu when viewing a record
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.3.14.1400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Open the Record Home Page for record 1
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "1"
        Then I should see "Record Home Page"

        #VERIFY: The selected record name is displayed in the left navigation menu
        And I should see the link labeled "Record ID 1"

        #ACTION: Open a data collection instrument for record 1
        When I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
        Then I should see "Record ID 1"

        ##VERIFY: The selected record name is still displayed in the left navigation menu on the data entry form
        And I should see the link labeled "Record ID 1"

    Scenario: B.3.14.1400.200 Selected record name in the left navigation menu updates when a different record is selected
        #FUNCTIONAL REQUIREMENT
        ##ACTION: Select a different record
        When I click on the link labeled "Record Status Dashboard"
        And I click on the link labeled "2"
        Then I should see "Record Home Page"
        
        ##VERIFY: The left navigation menu displays the newly selected record name
        And I should see "Record ID 2"

    Scenario: B.3.14.1400.300 Selected record name in the left navigation menu reflects a renamed record
        #FUNCTIONAL REQUIREMENT
        ##ACTION: Rename the currently selected record
        When I click on the button labeled "Choose action for record"
        And I click on the link labeled "Rename record"
        Then I should see 'Rename record "2"'

        Given I clear field and enter "2.A" into the input field labeled 'Rename record "2"'
        And I click on the button labeled "Rename record"
        Then I should see "Record ID 2.A was successfully renamed!"

        ##VERIFY: The left navigation menu displays the new record name
        And I should see "Record ID 2.A"

    Scenario: B.3.14.1400.400 Selected record name is not displayed in the left navigation menu when no record is being viewed
        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to a page that is not associated with a specific record
        When I click on the link labeled "Add / Edit Records"
        Then I should see "Add / Edit Records"

        ##VERIFY: No selected record is shown in the left navigation menu
        And I should NOT see a link labeled "Record ID"

    #END
