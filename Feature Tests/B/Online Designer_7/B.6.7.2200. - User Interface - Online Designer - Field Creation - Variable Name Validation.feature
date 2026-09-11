Feature: B.6.7.2200.: User Interface - Online Designer - Field Creation - Variable Name Validation

    As a REDCap designer
    I want the Online Designer to require unique variable names made only of lowercase letters, numbers, and underscores and beginning with a letter
    So that field variable names are valid and predictable.

    Scenario: Setup
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.6.7.2200." by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        Then I should see "Your new REDCap project has been created"

    Scenario: Warning shown at 26 characters
        Given I click on the button labeled "Online Designer"
        And I click on the link labeled "Text Validation" 
        And I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Text Box" into the Field Label of the open "Add New Field" dialog box
        When I enter "abcdefghijklmnopqrstuvwxyzz" into the input field labeled "Variable Name"
        And I press the "Tab" key
        Then I should see "Variable names are recommended to be no more than 26 characters in length because of the risk of them being truncated during analysis in a statistical software package. However, it is allowable to keep it as its current value, if you wish." 
        And I click on the button labeled "Close"
        And I click on the button labeled "Save"  
            

    Scenario: Hiding the 26-character warning when name shortened
        Given I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Text Box 2" into the Field Label of the open "Add New Field" dialog box
        When I enter "abcdefghijklmnopqrstuvw" into the input field labeled "Variable Name"
        And I click on the button labeled "Save"

        #VERIFY
        Then I should see "Field Name: abcdefghijklmnopqrstuvw"

    Scenario: Variable name starting with underscore is rejected
        Given I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Start with underscore" into the Field Label of the open "Add New Field" dialog box
        When I enter "_start_with_underscore" into the input field labeled "Variable Name"
        And I click on the button labeled "Save"
        
        #VERIFY
        And I should NOT see "Field Name: _start_with_underscore"
        Then I should see "Field Name: start_with_underscore"
    # NOTE: REDCap silently auto-corrects the variable name instead of showing a validation warning. This scenario documents the desired behavior.

    Scenario: Variable name starting with a number is rejected
        Given I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Start with number" into the Field Label of the open "Add New Field" dialog box
        When I enter "1st_field" into the input field labeled "Variable Name"
        And I click on the button labeled "Save"

        #VERIFY
        And I should NOT see "Field Name: 1st_field"
        Then I should see "Field Name: st_field"
    # NOTE: REDCap silently auto-corrects the variable name instead of showing a validation warning. This scenario documents the desired behavior.

    Scenario: Variable name with a capital letter is rejected
        Given I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "With capital letter" into the Field Label of the open "Add New Field" dialog box
        When I enter "FieldName" into the input field labeled "Variable Name"
        And I click on the button labeled "Save"
        
        #VERIFY
        And I should NOT see "Field Name: FieldName"
        Then I should see "Field Name: fieldname"
    # NOTE: REDCap silently auto-corrects the variable name instead of showing a validation warning. This scenario documents the desired behavior.


    Scenario: Variable name with non-underscore symbol is rejected
        And I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Non-underscore symbol" into the Field Label of the open "Add New Field" dialog box
        When I enter "field-name$" into the input field labeled "Variable Name"
        And I click on the button labeled "Save"

        #VERIFY
        And I should NOT see "Field Name: field-name$"
        Then I should see "Field Name: fieldname"
    # NOTE: REDCap silently auto-corrects the variable name instead of showing a validation warning. This scenario documents the desired behavior.

     Scenario: Duplicate names remain blocked
        And I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Unique field" into the Field Label of the open "Add New Field" dialog box
        And I enter "duplicate_name" into the input field labeled "Variable Name"
        And I click on the button labeled "Save"
        And I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Duplicate field" into the Field Label of the open "Add New Field" dialog box
        When I enter "duplicate_name" into the input field labeled "Variable Name"
        Then I should see "The variable name 'duplicate_name' already exists in this project and thus cannot be duplicated. Please enter another value."
        And I click on the button labeled "Close"
        And I enter "duplicate_name_2" into the input field labeled "Variable Name"
        And I click on the button labeled "Save"
         #VERIFY
        Then I should see "Field Name: duplicate_name_2"

    Scenario: Automatic naming from Field Label
        Given I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I click on the checkbox labeled "Enable auto naming of variable based upon its Field Label?"
        And I click on the button labeled "Enable auto naming"
        And I enter "Text Box 3" into the Field Label of the open "Add New Field" dialog box
    # NOTE: REDCap will insert underscores in the place of the spaces. Then I should see the "text_box_3" for the variable name.
        And I click on the button labeled "Save"
        #VERIFY
        Then I should see "Field Name: text_box_3"
        

    Scenario: Grant a second user design rights on the project
        Given I click on the link labeled "User Rights"
        And I enter "Test_User1" into the input field labeled "Add with custom rights"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"
        And I check the User Right named "Project Setup & Design"
        And I check the radio labeled "Full Access"
        And I click on the button labeled "Add user"
        And I logout

    Scenario: Suppressed warning does not carry over to a different user in the same project
        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.6.7.2200."
        And I click on the button labeled "Online Designer"
        And I click on the link labeled "Text Validation"
        And I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Different User Field" into the Field Label of the open "Add New Field" dialog box
        When I enter "abcdefghijklmnopqrstuvwxyzc" into the input field labeled "Variable Name"
        And I press the "Tab" key
        Then I should see "Variable names are recommended to be no more than 26 characters in length because of the risk of them being truncated during analysis in a statistical software package. However, it is allowable to keep it as its current value, if you wish."
        And I click on the button labeled "Close"
        And I click on the button labeled "Save"

#END
