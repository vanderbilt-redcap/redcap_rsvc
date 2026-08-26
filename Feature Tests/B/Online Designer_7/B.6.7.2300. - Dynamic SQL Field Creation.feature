Feature: B.6.7.2300. - User Interface – Online Designer - Field Creation: The system shall allow administrators only to create Dynamic SQL Fields using the Online Designer.

    As a REDCap administrator
    I want to ensure only authorized administrators can create Dynamic SQL Fields using the Online Designer

    Scenario: B.6.7.2300.100 An administrator can create a Dynamic SQL Field using the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.6.7.2300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created and is ready to be accessed."
        
        #Adding non-administrator user to the project with full rights
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Add new user"
        And I click on the button labeled "Add with custom rights"
        And I click on the checkbox labeled "Project Design and Setup"
        And I click on the button labeled "Add user"
        Then I should see "Test User1"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to the Online Designer
        When I click on the link labeled "Designer"
        Then I should see "Online Designer"

        ##ACTION: Open the instrument to add a field
        When I click on the link labeled "Text Validation"

        ##ACTION: Add a new Dynamic SQL Field
        And I click on the button labeled "Add Field"
        And I select "Dynamic Query (SQL)" on the dropdown field labeled "Field Type"
        And I enter "dynamic_sql_test" into the field labeled "Variable Name"
        And I enter "Dynamic SQL Test Field" into the textarea field labeled "Field Label"
        And I enter "SELECT value, label FROM my_table ORDER BY label" into the textarea field labeled "SQL Query ('select' query only)"
        And I click on the button labeled "Update & Close Editor"
        And I click on the button labeled "Save"

        ##VERIFY: The Dynamic SQL Field is created and visible on the instrument
        Then I should see "dynamic_sql_test"
        And I should see "Dynamic SQL Test Field"
        ##VERIFY: Logging
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported       |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design    |Create project field                           |
        
    Scenario: B.6.7.2300.200 A non-administrator user cannot create a Dynamic SQL Field using the Online Designer
        #SETUP
        #FUNCTIONAL REQUIREMENT
        ##ACTION: Log in as a non-administrator user and navigate to the Online Designer
        Given I login to REDCap with the user "Test_User1"
        Then I should see "B.6.7.2300.100"

        ##ACTION: Navigate to the Online Designer
        When I click on the link labeled "Designer"
        Then I should see "Text Validation"

        ##ACTION: Open the instrument to add a field
        When I click on the link labeled "Text Validation"

        ##ACTION: Try to add a new Dynamic SQL Field
        And I click on the button labeled "Add Field"
        Then I should NOT see "Dynamic Query (SQL)" on the dropdown field labeled "Field Type:"


    Scenario: B.6.7.2300.300 A Dynamic SQL Field created by an administrator is visible in the Online Designer instrument field list
        #SETUP
        ##ACTION: Navigate to the Online Designer
        When I click on the link labeled "Designer"
        Then I should see "Text Validation"

        ##ACTION: Open the instrument to add a field
        When I click on the link labeled "Text Validation"
        Then I should see "dynamic_sql_test"
        And I should see "Dynamic SQL Test Field"
        And I logout

    Scenario: B.6.7.2300.400 An administrator can edit an existing Dynamic SQL Field using the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        #FUNCTIONAL REQUIREMENT

        When I click on the link labeled "Designer"
        And I click on the link labeled "Text Validation"
        Then I should see "Text Validation"
        ##ACTION: Edit the Dynamic SQL Field
        When I click on the Edit image for the field named "Dynamic SQL Test Field"
        And I enter "dynamic_sql_edit" into the field labeled "Variable Name"
        And I enter "Dynamic SQL Edit Field" into the textarea field labeled "Field Label"
        And I enter "SELECT value, label FROM my_table ORDER BY label edit" into the textarea field labeled "SQL Query ('select' query only)"
        And I click on the button labeled "Update & Close Editor"
        And I click on the button labeled "Save"
        ##VERIFY: The Dynamic SQL Field reflects the updated label
        Then I should see "dynamic_sql_edit"
        And I should see "Dynamic SQL Edit Field"
        ##VERIFY: Logging
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported       |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design    | Edit project field                            |
        
    Scenario: B.6.7.2300.500 An administrator can delete a Dynamic SQL Field using the Online Designer
        #SETUP
        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to the Online Designer and add a Dynamic SQL Field
        When I click on the link labeled "Designer"
        And I click on the link labeled "Text Validation"
        Then I should see "Text Validation"

        ##ACTION: Delete the Dynamic SQL Field and verify SQL Field is no longer visible on the instrument
        When I click on the Delete Field image for the field named "Dynamic SQL Edit Field"
        Then I should see "Are you sure you wish to delete the field"
        When I click on the button labeled "Delete"
        Then I should NOT see "Dynamic SQL Edit Field"

        ##VERIFY: Logging
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action           | List of Data Changes OR Fields Exported    |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design    | Delete project field                       |
        
    #END
