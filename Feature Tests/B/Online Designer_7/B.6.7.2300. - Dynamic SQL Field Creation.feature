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
        And I click on the field labeled "Select a Type of Field"
        Then I should see the dropdown field labeled "Field Type" with the options below
            | Users with Non-compliant Rights (non-expired)              |
            | Users with Non-compliant Rights (all)                      |
            | Projects with Non-compliant Rights (non-expired)           |
            | Projects with Non-compliant Rights (all)                   |
            | Users and Projects with Non-compliant Rights (non-expired) |
            | Users and Projects with Non-compliant Rights (all)         |

        Then I should NOT see "Dynamic Query (SQL)" in the dropdown field labeled "Field Type"
        And I select "Dynamic Query (SQL)" on the dropdown field labeled "Field Type"
        And I enter "dynamic_sql_test" into the field labeled "Variable Name"
        And I enter "Dynamic SQL Test Field" into the textarea field labeled "Field Label"
        And I enter "SELECT value, label FROM my_table ORDER BY label" into the textarea field labeled "SQL Query ('select' query only)"
        And I click on the button labeled "Update & Close Editor"
        And I click on the button labeled "Save"

        ##ACTION: Attempt to add a new field and inspect available field types
        When I click on the link labeled "My First Instrument"
        And I click on the button labeled "Add Field"

        ##VERIFY: The Dynamic SQL Field type is not available to non-administrator users
        Then I should NOT see "Dynamic SQL Field" in the dropdown field labeled "Field Type"


    Scenario: B.6.7.2300.300 A Dynamic SQL Field created by an administrator is visible in the Online Designer instrument field list
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.6.7.2300.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to the Online Designer and open the instrument
        When I click on the link labeled "Online Designer"
        Then I should see "Online Designer"
        When I click on the link labeled "My First Instrument"

        ##ACTION: Add a Dynamic SQL Field
        And I click on the button labeled "Add Field"
        And I select "Dynamic SQL Field" on the dropdown field labeled "Field Type"
        And I enter "dynamic_sql_verify" into the field labeled "Variable Name"
        And I enter "Dynamic SQL Verify Field" into the field labeled "Field Label"
        And I enter "SELECT value, label FROM my_table ORDER BY label" into the field labeled "SQL Query"
        And I save the field

        ##VERIFY: The newly created Dynamic SQL Field appears in the instrument field list
        Then I should see "dynamic_sql_verify"
        And I should see "Dynamic SQL Field"
        And I should see "Dynamic SQL Verify Field"


    Scenario: B.6.7.2300.400 An administrator can edit an existing Dynamic SQL Field using the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.6.7.2300.400" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to the Online Designer and add a Dynamic SQL Field
        When I click on the link labeled "Online Designer"
        Then I should see "Online Designer"
        When I click on the link labeled "My First Instrument"
        And I click on the button labeled "Add Field"
        And I select "Dynamic SQL Field" on the dropdown field labeled "Field Type"
        And I enter "dynamic_sql_edit" into the field labeled "Variable Name"
        And I enter "Original Label" into the field labeled "Field Label"
        And I enter "SELECT value, label FROM my_table ORDER BY label" into the field labeled "SQL Query"
        And I save the field

        ##ACTION: Edit the Dynamic SQL Field
        And I click on the edit icon for the field labeled "Original Label"
        And I clear the field labeled "Field Label"
        And I enter "Updated Label" into the field labeled "Field Label"
        And I save the field

        ##VERIFY: The Dynamic SQL Field reflects the updated label
        Then I should see "Updated Label"
        And I should NOT see "Original Label"


    Scenario: B.6.7.2300.500 An administrator can delete a Dynamic SQL Field using the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.6.7.2300.500" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to the Online Designer and add a Dynamic SQL Field
        When I click on the link labeled "Online Designer"
        Then I should see "Online Designer"
        When I click on the link labeled "My First Instrument"
        And I click on the button labeled "Add Field"
        And I select "Dynamic SQL Field" on the dropdown field labeled "Field Type"
        And I enter "dynamic_sql_delete" into the field labeled "Variable Name"
        And I enter "Dynamic SQL Delete Field" into the field labeled "Field Label"
        And I enter "SELECT value, label FROM my_table ORDER BY label" into the field labeled "SQL Query"
        And I save the field

        ##ACTION: Delete the Dynamic SQL Field
        And I click on the delete icon for the field labeled "Dynamic SQL Delete Field"
        And I confirm the deletion

        ##VERIFY: The Dynamic SQL Field is no longer visible on the instrument
        Then I should NOT see "dynamic_sql_delete"
        And I should NOT see "Dynamic SQL Delete Field"
    #END
