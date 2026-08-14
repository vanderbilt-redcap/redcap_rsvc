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
        # Then I should see an alert box with the following text: "Variable names are recommended to be no more than 26 characters in length because of the risk of them being truncated during analysis in a statistical software package. However, it is allowable to keep it as its current value, if you wish." 
        And I wait for 1 second
        And I click on the button labeled "Close"
        And I click on the button labeled "Save"      

    Scenario: Hiding the 26-character warning when name shortened
        # Given I click on the button labeled "Online Designer"
        Given I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Text Box 2" into the Field Label of the open "Add New Field" dialog box
        When I enter "abcdefghijklmnopqrstuvw" into the input field labeled "Variable Name"
        # Then I should not see a validation warning containing "26 characters"
        And I click on the button labeled "Save"

    # Scenario: Variable name starting with underscore is rejected
        Given I click on the button labeled "Add Field"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
        And I enter "Start with underscore" into the Field Label of the open "Add New Field" dialog box
        When I enter "_start_with_underscore" into the input field labeled "Variable Name"
    #     Then I should see a validation warning containing "must begin with a letter"

    # Scenario: Variable name starting with a number is rejected
    #     Given I click on the link labeled "Online Designer"
    #     And I click on the button labeled "Add Field"
    #     When I enter "1st_field" into the input field labeled "Variable Name"
    #     Then I should see a validation warning containing "must begin with a letter"

    # Scenario: Variable name with a capital letter is rejected
    #     Given I click on the link labeled "Online Designer"
    #     And I click on the button labeled "Add Field"
    #     When I enter "FieldName" into the input field labeled "Variable Name"
    #     Then I should see a validation warning containing "lowercase"

    # Scenario: Variable name with non-underscore symbol is rejected
    #     Given I click on the link labeled "Online Designer"
    #     And I click on the button labeled "Add Field"
    #     When I enter "field-name$" into the input field labeled "Variable Name"
    #     Then I should see a validation warning containing "only lowercase letters, numbers, and underscores"

    # # Scenario: Automatic naming from Field Label
    #     Given I click on the button labeled "Add Field"
    #     And I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:"
    #     And I click on the checkbox labeled "Enable auto naming of variable based upon its Field Label?"
    #     And I click on the button labeled "Enable auto naming"
    #     And I enter "Text Box 3" into the Field Label of the open "Add New Field" dialog box
    #     # Then I should see the "text_box_3"
    #     # Then the input field labeled "Variable Name" should contain "text_box_3"
    #     And I click on the button labeled "Save"

#END
