Feature: User Interface:  The system shall support the ability to create, modify, copy, or delete reports.

  As a REDCap end user
  I want to see that Reporting is functioning as expected

  Scenario: C.5.22.0200.100 Reporting module functions create, modify, copy, or delete
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "C.5.22.0200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION:  create report
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Create New Report"
    And I enter "C.5.22.0200.100 REPORT" into the input field labeled "Name of Report:"
    And I click on the button labeled "Save Report"
    Then I should see "Your report has been saved!"

    ##VERIFY: saved name
    When I click on the button labeled "View report" in the dialog box
    Then I should see "C.5.22.0200.100 REPORT"

    When I click on the button labeled "Edit Report"
    Then I should see "Edit Existing Report:"
    And I should see "C.5.22.0200.100 REPORT"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION:  edit report name

    When I clear field and enter "C.5.22.0200.100 REPORT_EDIT" into the input field labeled "Name of Report:"
    And I click on the button labeled "Save Report"
    Then I should see "Your report has been saved!"

    ##VERIFY: edited name
    When I click on the button labeled "View report" in the dialog box
    Then I should see "C.5.22.0200.100 REPORT_EDIT"

    When I click on the button labeled "Edit Report"
    Then I should see "Edit Existing Report:"
    And I should see "C.5.22.0200.100 REPORT_EDIT"

    When I clear field and enter "C.5.22.0200.100 REPORT_EDIT2" into the input field labeled "Name of Report:"
    And I click on the button labeled "Save Report"
    Then I should see "Your report has been saved!"

    ##VERIFY: edited name
    When I click on the button labeled "View report" in the dialog box
    Then I should see "C.5.22.0200.100 REPORT_EDIT2"

    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | 2 | C.5.22.0200.100 REPORT_EDIT2 |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION:  copy report
    When  I click on the button labeled "Copy" for the report named "C.5.22.0200.100 REPORT_EDIT2"
    Then I should see "COPY REPORT?"

    When I click on the button labeled "Copy" in the dialog box
    ##VERIFY: copy
    Then I should see a table row containing the following values in the reports table:
      | 2 | C.5.22.0200.100 REPORT_EDIT2        |
      | 3 | C.5.22.0200.100 REPORT_EDIT2 (copy) |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION:  delete report
    When  I click on the button labeled "Delete" for the report named "C.5.22.0200.100 REPORT_EDIT2"
    Then I should see "DELETE REPORT?"

    When I click on the button labeled "Delete" in the dialog box
    ##VERIFY: delete
    Then I should see a table row containing the following values in the reports table:
      | 2 | C.5.22.0200.100 REPORT_EDIT2 (copy) |
#END