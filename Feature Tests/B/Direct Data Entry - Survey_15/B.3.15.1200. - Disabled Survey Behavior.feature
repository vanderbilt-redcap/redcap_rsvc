Feature: User Interface: Survey Project Settings: The system shall delete all survey-related information and functions including survey link, return codes and date/time stamp when disabling survey functionality. Saved data will remain unaffected.


  As a REDCap end user
  I want to see that Survey Feature is functioning as expected

  Scenario: B.3.15.1200.100 Deletion of meta data includes deletion of survey information and function
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
    And I create a new project named "B.3.15.1200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see Project status: "Production"

    #SETUP: DESIGNER
    Given I click on the link labeled "Designer"
    And I click on the "Enable" button for the instrument row labeled "Text Validation"
    And I click on the button labeled "Save Changes"
    Then I should see the enabled survey icon link for the instrument row labeled "Text Validation"

    Given I click on the "Survey settings" button for the instrument row labeled "Text Validation"
    When I select "Yes" on the dropdown field labeled "Allow 'Save & Return Later' option for respondents?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved"

    ##VERIFY_SDT: verifying survey link and return codes are available
    Given I click on the link labeled "Survey Distribution Tools"
    And I click on the tab labeled "Participant List"
    Then I should see a button labeled "Add participants"
    And I should see the dropdown field labeled "Participant List" with the options below
      | [Initial survey] "Text Validation" - Event 1 (Arm 1: Arm 1) |
      | "Consent" - Event 1 (Arm 1: Arm 1)                          |
      | "Text Validation" - Event 2 (Arm 1: Arm 1)                  |
      | "Survey" - Event Three (Arm 1: Arm 1)                       |
      | "Consent" - Event Three (Arm 1: Arm 1)                      |

    And I should see a table header and rows containing the following values in a table:
      | Email             | Record | Participant Identifier | Responded | Invitation Scheduled? | Invitation Sent? | Link   | Survey Access Code |
      | [No email listed] |        | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | [No email listed] |        | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | email@test.edu    | 1      | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |
      | email@test.edu    | 2      | Disabled               | [icon]    | -                     | [icon]            | [icon] | [icon]             |

    ##ACTION
    When I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label

    #Survey
    Then I should see "Please complete the survey below."
    And I clear field and enter "B.3.15.1200.100" into the data entry form field labeled "Name"
    And I click on the button labeled "Submit"
    Then I should see "Thank you for taking the survey"

    Given I click on the button labeled "Close survey"
    Then I should see "You may now close this tab/window"
   
    ##VERIFY_DE
    Given I return to the REDCap page I opened the survey from
    #Manual: Surveys open in the same window (by default) in automated tests (automated tests this in B.3.15.500 - Survey Alerts and Prompts)
    #And I click on the button labeled "Leave without saving changes" in the dialog box
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Data Access Group | Survey Identifier | Survey Timestamp | Name            |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |                   |                   | mm-dd-yyyy hh:mm | B.3.15.1200.100 |

    #FUNCTIONAL REQUIREMENT
    ##ACTION
    When I click on the link labeled "Designer"
    And I click on the "Survey settings" button for the instrument row labeled "Text Validation"
    And I click on the button labeled "Delete Survey Settings"
    And I click on the button labeled "Delete Survey Settings" in the dialog box
    Then I should see "Survey successfully deleted!"
    When I click on the button labeled "Close" in the dialog box
    Then I should see the "Enable" button for the instrument row labeled "Text Validation"

    ##VERIFY_DE: confirm
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a table row containing the following values in the reports table:
      | A | All data (all records and fields) |

    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Event Name             | Repeat Instrument | Repeat Instance | Data Access Group | Survey Identifier | Name            |
      | 1         | Event 1 (Arm 1: Arm 1) |                   |                 |                   |                   | B.3.15.1200.100 |

    #Manual: Note that "text_validation_timestamp" is the column VARIABLE name used if Text Validation instrument was enabled as survey.
    # Cannot look for "Survey Timestamp" because that same LABEL is used for all survey timestamp columns.
    And I should NOT see "text_validation_timestamp"

    ##VERIFY_SDT: verifying survey link and return codes are NOT available
    Given I click on the link labeled "Survey Distribution Tools"
    And I click on the tab labeled "Participant List"

    #Manual: We are verifying that you do NOT see "Text Validation" in the dropdown labeled "Participant List".
    # For comparison, see line 43 where "Text Validation" is included in this list ...
    Then I should see the dropdown field labeled "Participant List" with the options below
      | "Consent" - Event 1 (Arm 1: Arm 1)     |
      | "Survey" - Event Three (Arm 1: Arm 1)  |
      | "Consent" - Event Three (Arm 1: Arm 1) |
#END