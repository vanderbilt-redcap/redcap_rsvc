Feature: Field Creation: The system shall support marking a data entry field as an identifier.

  As a REDCap end user
  I want to see that Project Designer is functioning as expected

  Scenario: B.6.7.1700.100 Designating field as identifier through the Online Designer
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.7.1700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_USER_RIGHTS
    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
    And I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.7.1700.100"
    And I click on the link labeled "Setup"
    And I click on the button labeled "Online Designer"
    Then I should see "Data Collection Instruments"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: designate identifier through online designer
    When I click on the link labeled "Data Types"
    #MANUAL NOTE: the last button is the one at the bottom of the instrument
    And I click on the last button labeled "Add Field"

    When I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Identifier 3" into the Field Label of the open "Add New Field" dialog box
    And I enter "identifier_3" into the Variable Name of the open "Add New Field" dialog box
    And I mark the field as an identifier
    And I click on the button labeled "Save"

    Then I should see the field labeled "Identifier 3"

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table row containing the following values in the codebook table:
      | [identifier_3] | Identifier 3 | text, Identifier |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported |
      | test_user1 | Manage/Design | Create project field                    |

  Scenario: B.6.7.1700.200 Designating field as identifier through Project Setup
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I create a new project named "B.6.7.1700.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    And I click on the link labeled "Check For Identifiers"
    Then I should see "Check For Identifiers"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: designate identifier
    When I click on the checkbox labeled "name"
    And I click on the button labeled "Update Identifiers"
    Then I should see "Your changes have been saved!"

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
      | Variable / Field Name | Field Label | Field Attributes |
      | [identifier]          | Identifier  | text, Identifier |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported |
      | test_admin | Manage/Design | Tag new identifier fields               |

  Scenario: B.6.7.1700.300 Designating field as identifier through Data Dictionary upload
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "New Project"
    And I enter "B.6.7.1700.300" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "Your new REDCap project has been created"
    And I should see "B.6.7.1700.300"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Upload data dictionary
    When I click on the link labeled "Dictionary"
    And I upload a "csv" format file located at "dictionaries/Project1xml_DataDictionary.csv", by clicking the button near "Choose File" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."

    When I click on the button labeled "Commit Changes"
    Then I should see "Changes Made Successfully!"

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
      | Variable / Field Name | Field Label | Field Attributes |
      | [identifier]          | Identifier  | text, Identifier |
#END