Feature: C.2.19.1500. User Interface: The system shall support exporting and importing Record Locking Customization settings as part of a Project XML file.
    As a REDCap end user
    I want to see that Record Locking Customization settings are part of a Project XML file.

    Scenario: C.2.19.1500. User Interface: The system shall support exporting and importing Record Locking Customization settings as part of a Project XML file.
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "C.2.19.1500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I check the checkbox in the column labeled "Also display E-signature option on instrument?" and the row labeled "Text Validation"
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | ock Record Custom Text  | Edit / Remove Custom Text |
            | [x]                                          | Text Validation            | [x]                                            | [text box]              |                           |
            | [x]                                          | Data Types                 | [ ]                                            | [text box]              |                           |
            | [x]                                          | Survey                     | [ ]                                            | [text box]              |                           |
            | [x]                                          | Consent                    | [ ]                                            | [text box]              |                           |

    Scenario:  #Export the project XML
        When I click on the link labeled "Setup"
        And I click on the link labeled "Other Functionality"
        And I click on the button labeled "Download metadata only (XML)"
        Then I should see a downloaded file named "C2191500_yyyy-mm-dd_hhmm.REDCap.xml"

    Scenario: #Create a project using downloaded XML
        Given I click on the link labeled "REDCap"
        And I click on the link labeled "New Project"
        And I create a new project named "C.2.19.1500.2" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "C2191500_yyyy-mm-dd_hhmm.REDCap.xml", and clicking the "Create Project" button
        Then I should see 'Project "C.2.19.1500.2" was successfully created.'
        #VERIFY settings imported correctly
        When I click on the link labeled "Customize & Manage Locking/E-signatures"
        And I check the checkbox in the column labeled "Also display E-signature option on instrument?" and the row labeled "Text Validation"
        Then I should see a table header and rows containing the following values in a table:
            | Display the Lock option for this instrument? | Data Collection Instrument | Also display E-signature option on instrument? | ock Record Custom Text  | Edit / Remove Custom Text |
            | [x]                                          | Text Validation            | [x]                                            | [text box]              |                           |
            | [x]                                          | Data Types                 | [ ]                                            | [text box]              |                           |
            | [x]                                          | Survey                     | [ ]                                            | [text box]              |                           |
            | [x]                                          | Consent                    | [ ]                                            | [text box]              |                           |

#END