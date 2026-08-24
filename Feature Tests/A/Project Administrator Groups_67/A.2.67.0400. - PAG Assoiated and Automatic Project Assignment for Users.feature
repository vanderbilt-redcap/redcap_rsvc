Feature: A.2.67.0400. - Control Center: The system shall allow users to be associated with a Project Administrator Group to automatically assign newly created projects to the appropriate administrative group. A user shall be associated with only one Project Administrator Group at a time.

  As a REDCap system administrator
  I want to ensure that users associated with a Project Administrator Group have their newly created projects automatically assigned to that group, and that a user cannot be associated with more than one PAG at a time.

  Scenario: Create a project before any PAG association
    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "New Project"
    And I enter "Pre-Association Project" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "Your new REDCap project has been created"
    And I should see "Pre-Association Project"

  Scenario: REDCap+ Setup
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "REDCap Plus"
    And I click on the button labeled "Enter a REDCap+ subscription key"
    And I enter a REDCap+ subscription key into the textarea field labeled "Enter a REDCap+ subscription key"
    And I click on the button labeled "Save key"
    Then I should see "REDCap+ subscription activated!"

    When I click on the button "OK"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    And I click on "Create new PAG"
    Then I should see "Create new Project Administrator Group"

  Scenario: A.2.67.0400.0100 Assign a user to a PAG
    When I enter "New PAG 1" into the field with the placeholder text of "Enter name for new PAG"
    And I enter "Test_User1" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Create new PAG"
    Then I should see "PAG successfully created!"
    And I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1)     |0                          | 0                      |1        |
    
    When I click on the second button labeled "View & Manage" in the row labeled "New PAG 1"
    And I click on the button labeled "Assign user"
    And I enter "Test_User2" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Assign"
    Then I should see "User assigned successfully!"
    And I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1)     |0                          | 1                      |1        |

  Scenario: A.2.67.0400.0200 Verify projects created by the user are automatically assigned to the PAG
    Given I logout
    And I login to REDCap with the user "Test_User2"
    And I click on the link labeled "New Project"
    And I enter "Auto Assigned Project" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "Your new REDCap project has been created"
    And I should see "Auto Assigned Project"

    Given I logout
    And I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "View & Manage" in the row labeled "New PAG 1"
    Then I should see a table header and rows containing the following values in a table:
        |PID        |Project Title           | Remove | 
        |14         |Auto Assigned Project   |        |

    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1)     |1                          | 1                      |1        |


  Scenario: A.2.67.0400.0300 Verify existing projects are not automatically reassigned
    Given I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "View & Manage" in the row labeled "New PAG 1"
    Then I should see a table header and rows containing the following values in a table:
        |PID        |Project Title           | Remove | 
        |14         |Auto Assigned Project   |        |
    And I should NOT see "Pre-Association Project"
    
    Given I logout
    And I login to REDCap with the user "Test_User1"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    And I click on the button labeled "View all projects"
    Then I should see "Auto Assigned Project"
    And I should NOT see "Pre-Association Project"

  Scenario: A.2.67.0400.0400 Attempt to associate a user with multiple PAGs simultaneously
    Given I logout
    And I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "Create new PAG"
    And I enter "New PAG 2" into the field with the placeholder text of "Enter name for new PAG"
    And I enter "Test_User3" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Create new PAG"
    Then I should see "PAG successfully created!"
    
    When I click on the second button labeled "View & Manage" in the row labeled "New PAG 2"
    And I click on the button labeled "Assign user"
    And I enter "Test_User2" into the field with the placeholder text of "Search user to add as a project-level admin"
    And I click on the button labeled "Assign"
    Then I should see "User assigned successfully!"
    And I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1)     |1                          | 0                      |1        |
        |New PAG 2                    |Test_User3 (Test User3)     |0                          | 1                      |2        |

    #Validate the PAG user moved from New Pag 1 to New Pag 2
    When I click on the second button labeled "View & Manage" in the row labeled "New PAG 2"
    Then I should see a table header and rows containing the following values in a table:
    |Username  |Name      |Remove|
    |test_user2|Test User2|      |
    And I click on the button labeled "Close"
    Then I should see "Project Administrator Groups"

    #Validate the user is no longer in New PAG 1
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    When I click on the second button labeled "View & Manage" in the row labeled "New PAG 1"
    Then I should see a table header and rows containing the following values in a table:
    |Username  |Name      |Remove|
    And I should see "No data available in table"
    And I click on the button labeled "Close"

  Scenario: A.2.67.0400.0500 Move the user to another PAG and verify subsequently created projects are assigned to the new PAG
    #User was moved to another PAG in the previous step.
    Given I logout
    And I login to REDCap with the user "Test_User2"
    And I click on the link labeled "New Project"
    And I enter "New PAG 2 Auto Assigned Project" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "Your new REDCap project has been created"
    And I should see "New PAG 2 Auto Assigned Project"

    Given I logout
    And I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "View & Manage" in the row labeled "New PAG 2"
    Then I should see a table header and rows containing the following values in a table:
        |PID        |Project Title                    | Remove | 
        |15         |New PAG 2 Auto Assigned Project  |        |

    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1)     |1                          | 0                      |1        |
        |New PAG 2                    |Test_User3 (Test User3)     |1                          | 1                      |2        |


  Scenario: A.2.67.0400.0600 Remove the user and verify future projects are no longer automatically assigned
    Given I click on the second button labeled "View & Manage" in the row labeled "New PAG 2"
    And I click on the icon in the column labeled "Remove" and the row labeled "test_user2"
    And I click on the button labeled "Unassign user from PAG"
    Then I should see "The user was successfully removed from the PAG!"
    And I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1)     |1                          | 0                      |1        |
        |New PAG 2                    |Test_User3 (Test User3)     |1                          | 0                      |2        |

    Given I logout
    And I login to REDCap with the user "Test_User2"
    And I click on the link labeled "New Project"
    And I enter "No PAG After Removal Project" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "Your new REDCap project has been created"
    And I should see "No PAG After Removal Project"

    Given I logout
    And I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Project Administrator Groups"
    Then I should see "Project Administrator Groups"
    When I click on the button labeled "View & Manage" in the row labeled "New PAG 1"
    Then I should NOT see "No PAG After Removal Project"

    When I click on the button labeled "Close"
    And I click on the button labeled "View & Manage" in the row labeled "New PAG 2"
    Then I should NOT see "No PAG After Removal Project"

    When I click on the button labeled "Close"
    Then I should see a table header and rows containing the following values in a table:
        |Project Administrator Group  |Project-level Admins        |Projects Assigned to PAG   | Users Assigned to PAG  |  PAG ID | 
        |New PAG 1                    |Test_User1 (Test User1)     |1                          | 0                      |1        |
        |New PAG 2                    |Test_User3 (Test User3)     |1                          | 0                      |2        |

#End
