Feature: Project Level:  The system shall allow for the creation, copying and deletion of user roles.

  As a REDCap end user
  I want to see that assign user rights is functioning as expected

  Scenario: B.2.6.0400.100 Create, Copy, & Delete User Roles
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
    And I create a new project named "B.2.6.0400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #FUNCTIONAL REQUIREMENT:
    ##ACTION: User Rights Create role
    Given I click on the link labeled "User Rights"
    And I enter "TestRole2" into the field with the placeholder text of "Enter new role name"
    And I click on the button labeled "Create role"
    Then I should see "Creating new role"

    ##VERIFY_UR
    When I click on the button labeled "Create role"
    Then I should see a table header and rows containing the following values in a table:
      | Role name               |
      | 1_FullRights            |
      | 2_Edit_RemoveID         |
      | 3_ReadOnly_Deidentified |
      | 4_NoAccess_Noexport     |
      | TestRole                |
      | TestRole2               |

    ##VERIFY_LOG
    Given I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Create user role | role = 'TestRole2'                      |


    Given I click on the link labeled "User Rights"
    And I click on the link labeled "TestRole2"
    Then I should see "Editing existing user role"

    ##ACTION: User Rights Copy role
    Given I click on the button labeled "Copy role"
    And I clear field and enter "Copy role" into the input field labeled "New role name:"
    And I click on the button labeled "Copy role"
    And I click on the button labeled "Cancel"

    ##VERIFY
    Then I should see a table header and rows containing the following values in a table:
      | Role name               |
      | 1_FullRights            |
      | 2_Edit_RemoveID         |
      | 3_ReadOnly_Deidentified |
      | 4_NoAccess_Noexport     |
      | Copy role               |
      | TestRole                |
      | TestRole2               |

    Given I click on the link labeled "TestRole2"

    ##ACTION: User Rights delete role
    Given I click on the button labeled "Delete role"
    When I should see "Delete role?"
    And I click on the button labeled "Delete role"

    ##VERIFY
    Then I should NOT see "TestRole2"
    But I should see a table header and rows containing the following values in a table:
      | Role name               |
      | 1_FullRights            |
      | 2_Edit_RemoveID         |
      | 3_ReadOnly_Deidentified |
      | 4_NoAccess_Noexport     |
      | Copy role               |
      | TestRole                |

    ##VERIFY_LOG
    Given I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Delete user role | role = 'TestRole2'                      |
      | mm/dd/yyyy hh:mm | test_admin | Create user role | role = 'Copy role'                      |
      | mm/dd/yyyy hh:mm | test_admin | Create user role | role = 'TestRole2'                      |
#End
