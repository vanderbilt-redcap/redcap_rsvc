Feature: User Interface: The tool shall support the ability to navigate directly to a selected record.

    As a REDCap end user
    I want to see that Record locking and E-signatures is functioning as expected

    Scenario: C.2.19.600.100 Navigate to record

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        And I create a new project named "C.2.19.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"
 
        #FUNCTIONAL REQUIREMENT
        ##ACTION Navigate to record
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        And I click on the link labeled "E-signature and Locking Management"
        Then I should see a table header and rows containing the following values in a table:
            | Record | Event Name             | Form Name       | Repeat Instance | Locked? | E-signed |             |
            | 3      | Event 1 (Arm 1: Arm 1) | Text Validation |                 |         | N/A      | View record |

        And I click on the "View record" link within the e-signature and locking management table in the following row:
            | Record | Event Name             | Form Name       |
            | 3      | Event 1 (Arm 1: Arm 1) | Text Validation |

        ##VERIFY
        Then I should see "Text Validation"
        And I should see a checkbox labeled "Lock this instrument?" that is unchecked
#END