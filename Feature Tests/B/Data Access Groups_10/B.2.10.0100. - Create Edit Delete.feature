Feature: B.2.10.0100. User Interface: The system shall allow for the creation of DAGs and the deletion of DAGs if no users or records are assigned to it.

    As a REDCap end user
    I want to see that Data Access Groups is functioning as expected

    Scenario: B.2.10.0100.100 Create, Edit & Delete DAGs
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.2.10.0100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.2.10.0100.100"
        And I click on the link labeled "DAGs"
        Then I should see "Assign user to a group"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Create DAG
        When I enter "TestGroup3" into the field with the placeholder text of "Enter new group name"
        And I click on the button labeled "Add Group"

        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups |
            | TestGroup1         |
            | TestGroup2         |
            | TestGroup3         |

        ##ACTION: Edit DAG
        When I click on a table cell containing the text "TestGroup3" in the data access groups table and clear field and enter "RenameGroup3"

        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups |
            | TestGroup1         |
            | TestGroup2         |
            | RenameGroup3       |

        #FUNCTIONAL REQUIREMENT - Cannot delete DAG with User
        ##ACTION: Add User with Basic custom rights
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see a dialog containing the following text: "Adding new user"
        And I click on the button labeled "Add user"

        ##ACTION: Assign User to DAG
        Given I click on the link labeled "DAGs"
        When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
        And I select "RenameGroup3" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"

        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups | Users in group          |
            | TestGroup1         |                         |
            | TestGroup2         |                         |
            | RenameGroup3       | test_user1 (Test User1) |

        ##ACTION: Cannot Delete DAG with User
        And I wait for 2 seconds
        Given I click on the icon in the column labeled "Delete" and the row labeled "RenameGroup3"
        Then I should see a dialog containing the following text: "Delete group?"
        When I click on the button labeled "Delete" on the dialog box
        Then I should see "The group could not be deleted because users or roles are still assigned to it."

        ##VERIFY
        And I should see a table header and rows containing the following values in a table:
            | Data Access Groups | Users in group          |
            | TestGroup1         |                         |
            | TestGroup2         |                         |
            | RenameGroup3       | test_user1 (Test User1) |

        ##ACTION: Remove User from DAG
        When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
        When I select "[No Assignment]" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"

        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups | Users in group |
            | TestGroup1         |                |
            | TestGroup2         |                |
            | RenameGroup3       |                |

        ##ACTION: Delete DAG
        And I wait for 2 seconds
        Given I click on the icon in the column labeled "Delete" and the row labeled "RenameGroup3"
        Then I should see a dialog containing the following text: "Delete group?"
        When I click on the button labeled "Delete" on the dialog box

        ##VERIFY
        Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups |
            | TestGroup1         |
            | TestGroup2         |
        Then I should NOT see "RenameGroup3"

        ##VERIFY_LOG: Verify Update, Edit and Delete for DAG
        And I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Delete data access group                |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Rename data access group                |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Create data access group                |
#END