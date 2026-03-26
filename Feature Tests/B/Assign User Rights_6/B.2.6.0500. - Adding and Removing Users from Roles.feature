Feature: B.2.6.0500. Project Level:  The system shall support adding and removing users from user roles.

  As a REDCap end user
  I want to see that assign user rights is functioning as expected

  Scenario: B.2.6.0500.100 Cancel, Assign, Re-assign, & Remove User Roles
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.6.0500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.0500.100"
    When I click on the link labeled "User Rights"
    And I click on the button labeled "Upload or download users, roles, and assignments"
    Then I should see "Upload users (CSV)"

    When I click on the link labeled "Upload users (CSV)"
    Then I should see a dialog containing the following text: "Upload users (CSV)"

    Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Displayed below is a preview of all the changes you are about to commit."
    And I should see a table header and rows containing the following values in a table in the dialog box:
      | username   |
      | test_user1 |
      | test_user2 |
      | test_user3 |
      | test_user4 |

    Given I click on the button labeled "Upload"
    Then I should see a dialog containing the following text: "SUCCESS!"

    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            |
      | —                       | test_admin          |
      | —                       | test_user1          |
      | —                       | test_user2          |
      | —                       | test_user3          |
      | —                       | test_user4          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Cancel assign to role
    When I click on the link labeled "Test User1"
    And I click on the button labeled "Assign to role"
    And I select "TestRole" on the dropdown field labeled "Select Role"
    And I click on the link labeled "Cancel"

    ##VERIFY
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            |
      | —                       | test_admin          |
      | —                       | test_user1          |
      | —                       | test_user2          |
      | —                       | test_user3          |
      | —                       | test_user4          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    ##ACTION: Assign to role
    When I click on the link labeled "Test User1"
    And I click on the button labeled "Assign to role"
    # I have to select this twice. Not sure why
    And I select "TestRole" on the dropdown field labeled "Select Role"
    And I click on the button labeled "Assign"

    ##VERIFY
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            |
      | —                       | test_admin          |
      | —                       | test_user2          |
      | —                       | test_user3          |
      | —                       | test_user4          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | test_user1          |

    ##ACTION: Re-assign to role
    When I click on the link labeled "Test User1"
    And I click on the button labeled "Re-assign to role"
    # I have to select this twice. Not sure why
    And I select "1_FullRights" on the dropdown field labeled "Select Role"
    And I click on the button labeled "Assign"

    ##VERIFY
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            |
      | —                       | test_admin          |
      | —                       | test_user2          |
      | —                       | test_user3          |
      | —                       | test_user4          |
      | 1_FullRights            | test_user1          |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    ##ACTION: Remove from role
    When I click on the link labeled "Test User1"
    And I click on the button labeled "Remove from role"

    ##VERIFY
    Then I should see a table header and rows containing the following values in a table:
      | Role name               | Username            |
      | —                       | test_admin          |
      | —                       | test_user1          |
      | —                       | test_user2          |
      | —                       | test_user3          |
      | —                       | test_user4          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    And I should see a dialog containing the following text: "User's privileges will remain the same"
    And I click on the button labeled "Close"
#End
