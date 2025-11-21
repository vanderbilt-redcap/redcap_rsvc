Feature: User Interface: The E-signature and Locking Management tool shall display all records in a database with their status as locked or e-signed for all data entry forms.

    As a REDCap end user
    I want to see that Record locking and E-signatures is functioning as expected

    Scenario: C.2.19.100.100 Display locked and e-signed status

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.2.19.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #SETUP_PRODUCTION
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
        And I click on the button labeled "YES, Move to Production Status" in the dialog box
        Then I should see "Project status:  Production"

        #SETUP
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | Lock Record Custom Text |
            | [x]                                          | Text Validation            | [ ]                                            | [text box]              |
            | [x]                                          | Data Types                 | [ ]                                            | [text box]              |
            | [x]                                          | Survey                     | [ ]                                            | [text box]              |
            | [x]                                          | Consent                    | [ ]                                            | [text box]              |


        #FUNCTIONAL REQUIREMENT
        ##ACTION Lock Record Custom Text
        When I enter "Test custom text" into the textarea field labeled "Text Validation"
        And I click on the button labeled "Save" in the row labeled "Text Validation"
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | Lock Record Custom Text |
            | [x]                                          | Text Validation            | [ ]                                            | Test custom text        |
            | [x]                                          | Data Types                 | [ ]                                            | [text box]              |
            | [x]                                          | Survey                     | [ ]                                            | [text box]              |
            | [x]                                          | Consent                    | [ ]                                            | [text box]              |

        And I enter "Test custom text" into the textarea field labeled "Data Types"
        And I click on the button labeled "Save" in the row labeled "Data Types"
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | Lock Record Custom Text |
            | [x]                                          | Text Validation            | [ ]                                            | Test custom text        |
            | [x]                                          | Data Types                 | [ ]                                            | Test custom text        |
            | [x]                                          | Survey                     | [ ]                                            | [text box]              |
            | [x]                                          | Consent                    | [ ]                                            | [text box]              |


        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Customize record locking                |
            | test_admin | Manage/Design | Customize record locking                |

        ##VERIFY: custom text in record
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
        Then I should see "Text Validation"
        And I should see "Test custom text"

        When I click on the link labeled "Data Types"
        Then I should see "Data Types"
        And I should see "Test custom text"

        #FUNCTIONAL REQUIREMENT
        ##ACTION Edit / Remove Custom Text
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I click on the button labeled "I understand. Let me make changes" in the dialog box

        And I click on the icon labeled "Edit" in the row labeled "Text Validation"
        And I clear field and enter "New custom text" into the textarea field labeled "Text Validation"
        And I click on the button labeled "Save" in the row labeled "Text Validation"
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | Lock Record Custom Text |
            | [x]                                          | Text Validation            | [ ]                                            | New custom text         |
            | [x]                                          | Data Types                 | [ ]                                            | Test custom text        |
            | [x]                                          | Survey                     | [ ]                                            | [text box]              |
            | [x]                                          | Consent                    | [ ]                                            | [text box]              |

        And I click on the icon labeled "Remove" in the row labeled "Data Types"

        #Manual: confirmation windows are automatically accepted on automated side
        # And I click on the button labeled "OK" in the pop-up box
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | Lock Record Custom Text |
            | [x]                                          | Text Validation            | [ ]                                            | New custom text         |
            | [x]                                          | Data Types                 | [ ]                                            | [text box]              |
            | [x]                                          | Survey                     | [ ]                                            | [text box]              |
            | [x]                                          | Consent                    | [ ]                                            | [text box]              |


        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Customize record locking                |
            | test_admin | Manage/Design | Customize record locking                |
            | test_admin | Manage/Design | Customize record locking                |
            | test_admin | Manage/Design | Customize record locking                |


        ##VERIFY: custom text in record and revert back to template
        When I click on the link labeled "Record Status Dashboard"
        And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "1" and click on the bubble
        Then I should see "Text Validation"
        And I should see "New custom text"
        When I click on the link labeled "Data Types"
        Then I should see "Data Types"
        And I should see "Lock this instrument?"
        
        #END