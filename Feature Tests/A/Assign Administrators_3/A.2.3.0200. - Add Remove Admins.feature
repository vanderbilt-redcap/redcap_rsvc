Feature: A.2.3.0200. Assign administrators and account managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

  Scenario: A.2.3.0200.100 Give/remove user admin user rights
    ##REDUNDANT_TEST This test is also testing for A.2.3.0100.100 View administrator accounts
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I should see a table header and rows containing the following values in the administrators table:
      | Administrators          |
      | Test_Admin (Admin User) |

    ##TEST Add administrator account no privileges
    Given I enter "Test_User1" into the field with the placeholder text of "Search users to add as admin"
    And I click on the button labeled "Add"
    Then I should see "check one or more"
    And I click on the button labeled "Close"

    Given I clear field and enter "Test_User1" into the field with the placeholder text of "Search users to add as admin"
    And I enable the Administrator Privilege "Set administrator privileges" for a new administrator
    And I click on the button labeled "Add"
    Then I should see 'The user "Test_User1" has now been granted one or more administrator privileges'

    Given  I click on the button labeled "OK"
    Then I should see a table header and rows containing the following values in the administrators table:
      | Administrators | Set administrator privileges | Access to all projects and data with maximum user privileges | Manage user accounts | Modify system configuration pages | Install, upgrade, and configure External Modules | Perform REDCap upgrades | Access to Control Center dashboards |
      | Test_User1     | [x]                          | [ ]                                                          | [ ]                  | [ ]                               | [ ]                                              | [ ]                     | [ ]                                 |

    Given I logout
    When I login to REDCap with the user "Test_User1"
    When I click on the link labeled "Control Center"
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I should see a table header and rows containing the following values in the administrators table:
      | Administrators | Set administrator privileges | Access to all projects and data with maximum user privileges | Manage user accounts | Modify system configuration pages | Install, upgrade, and configure External Modules | Perform REDCap upgrades | Access to Control Center dashboards |
      | Test_User1     | [x]                          | [ ]                                                          | [ ]                  | [ ]                               | [ ]                                              | [ ]                     | [ ]                                 |

    #TEST Modify by Enable Administrator Privileges
    When I enable the Administrator Privilege "Set administrator privileges" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Access to all projects and data with maximum user privileges" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Manage user accounts" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Modify system configuration pages" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Install, upgrade, and configure External Modules" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Perform REDCap upgrades" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Access to Control Center dashboards" for the administrator "Test_User1"

    Then I should see a table header and rows containing the following values in the administrators table:
      | Administrators | Set administrator privileges | Access to all projects and data with maximum user privileges | Manage user accounts | Modify system configuration pages | Install, upgrade, and configure External Modules | Perform REDCap upgrades | Access to Control Center dashboards |
      | Test_User1     | [x]                          | [x]                                                          | [x]                  | [x]                               | [x]                                              | [x]                     | [x]                                 |

    #VERIFY
    When I click on the link labeled "Control Center"
    Then I should see "Administrator Privileges"
    And I should see "Browse Projects"
    And I should see "Edit Project Settings"
    And I should see "Add Users"
    And I should see "General Configuration"
    And I should see "User Settings"

    #TEST Disable Administrator Privileges
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"
    When I enable the Administrator Privilege "Set administrator privileges" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Access to all projects and data with maximum user privileges" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Manage user accounts" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Modify system configuration pages" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Install, upgrade, and configure External Modules" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Perform REDCap upgrades" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Access to Control Center dashboards" for the administrator "Test_User1"

    Then I should see a table header and rows containing the following values in the administrators table:
      | Administrators | Set administrator privileges | Access to all projects and data with maximum user privileges | Manage user accounts | Modify system configuration pages | Install, upgrade, and configure External Modules | Perform REDCap upgrades | Access to Control Center dashboards |
      | Test_User1     | [x]                          | [ ]                                                          | [ ]                  | [ ]                               | [ ]                                              | [ ]                     | [ ]                                 |

    Given I logout

    #VERIFY
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "Control Center"
    Then I should see "Administrator Privileges"
    And I should see "Browse Projects"
    And I should NOT see "Edit Project Settings"
    And I should NOT see "Add Users"
    And I should see "General Configuration"
    And I click on the link labeled "User Settings"
    And I should see "Because you have restricted admin privileges, this page is read-only, and no settings can be modified"
    And I logout

  Scenario: A.2.3.0200.100 Remove admin
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    Given I click on the link labeled "Administrator Privileges"
    And I disable the Administrator Privilege "Set administrator privileges" for the administrator "Test_User1"
    Then I should see "Please be aware that you have unchecked ALL the administrator privileges for this user"

    Given I click on the button labeled "Close"
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I should NOT see "Test_User1"
    Given I logout

    ##VERIFY
    When I login to REDCap with the user "Test_User1"
    Then I should NOT see a link labeled "Control Center"
#End