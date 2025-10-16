Feature: User Interface: The tool shall support the filtering the record list:

    As a REDCap end user
    I want to see that Record locking and E-signatures is functioning as expected

    Scenario: C.2.19.300.100 Record locking and E-signatures filtering
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        And I create a new project named "C.2.19.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see Project status: "Production"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Lock icon for instrument
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "3" and click on the bubble

        Then I should see "Text Validation"
        And I should see a checkbox labeled "Lock this instrument?" that is unchecked

        When I click on the checkbox for the field labeled "Lock this instrument?"
        And I click on the button labeled "Save & Exit Form"
        Then I should see "Record Home Page"
        And I should see "Record ID 3 successfully edited."
        ##VERIFY_RH
        And I should see a table header and rows containing the following values in a table:
            | Data Collection Instrument | Event 1     | Event 2 | Event Three |
            | Text Validation            | [lock icon] |         |             |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action               | List of Data Changes OR Fields Exported                                   |
            | test_admin | Lock/Unlock Record 3 | Action: Lock instrument |
            |            |                      | Record: 3               |
            |            |                      | Form: Text Validation   |
            |            |                      | Event: Event 1          |

        ##VERIFY_LOCK_ESIG: Record instrument lock on Locking Management
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        And I click on the link labeled "E-signature and Locking Management"
        Then I should see a table header and rows containing the following values in a table:
            | Record | Event Name | Form Name       | Repeat Instance | Locked?     |
            | 3      |            | Text Validation |                 | [lock icon] |
            | 3      |            | Consent         |                 |             |

        #FUNCTIONAL REQUIREMENT
        ##ACTION Enable Locking/E-signatures at instrument level
        And I should see "SHOW ALL ROWS"
        And I should see "Show timestamp / user"
        And I should see "Hide timestamp / user"
        And I should see "Show locked"
        And I should see "Show not locked"
        And I should see "Show e-signed"
        And I should see "Show not e-signed (excludes N/A)"
        And I should see "Show both locked and e-signed"
        And I should see "Show neither locked nor e-signed (excludes N/A)"
        And I should see "Show locked but not e-signed (excludes N/A)"

        When I click on the button labeled "Export all (CSV)"
        Then the downloaded CSV with filename "C219300100_EsignLockMgmt_yyyy-mm-dd_hhmm.csv" has a value "3" for column "Record"
        Then the downloaded CSV with filename "C219300100_EsignLockMgmt_yyyy-mm-dd_hhmm.csv" has a value "Event 1 (Arm 1: Arm1)" for column "Event Name"
        Then the downloaded CSV with filename "C219300100_EsignLockMgmt_yyyy-mm-dd_hhmm.csv" has a value "Text Validation" for column "Form Name"
        Then the downloaded CSV with filename "C219300100_EsignLockMgmt_yyyy-mm-dd_hhmm.csv" has a value " " for column "Repeat Instance"
        Then the downloaded CSV with filename "C219300100_EsignLockMgmt_yyyy-mm-dd_hhmm.csv" has a value "MM/DD/YYYY" for column "Locked?"
        Then the downloaded CSV with filename "C219300100_EsignLockMgmt_yyyy-mm-dd_hhmm.csv" has a value "N/A" for column "E-signed?"
#Manual: Close file
#END