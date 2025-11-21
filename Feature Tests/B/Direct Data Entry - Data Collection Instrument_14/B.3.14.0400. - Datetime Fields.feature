Feature: Creating a Record and Entering Data: The system shall support the ability to use the following on date/time fields: (Date picker widget | Now button | Today button)

  As a REDCap end user
  I want to see that date/time widget is functioning as expected

  Scenario: B.3.14.0400.100 Data entry for Date/time validated fields
    #ATS prerequisite: Normal users cannot move projects to production by default - let's adjust that before we proceed.
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
    And I create a new project named "B.3.14.0400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the link labeled "Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see "Adding new Record ID 7"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Date/time widget icon
    Given I click on the date picker widget on the field labeled "datetime YMD HMSS"
    And I select "Aug" in the dropdown of the open date picker widget for "datetime YMD HMSS"
    And I select "2023" in the dropdown of the open date picker widget for "datetime YMD HMSS"
    And I click on the link labeled "1"
    And I move the Hour slider for the open date picker widget to 0
    And I move the Minute slider for the open date picker widget to 0
    And I click on the button labeled "Done" in the open date picker widget

    ##VERIFY
    Then I should see the date and time "2023-08-01 00:00:00" in the field labeled "datetime YMD HMSS"

    ##ACTION: Now button
    When I click on the "Now" button for the field labeled "time HH:MM:SS"
    ##VERIFY
    Then I should see the exact time in the field labeled "time HH:MM:SS"

    ##ACTION: Today button
    When I click on the "Today" button for the field labeled "date YMD"
    ##VERIFY
    Then I should see today's date in the field labeled "date YMD"
#END