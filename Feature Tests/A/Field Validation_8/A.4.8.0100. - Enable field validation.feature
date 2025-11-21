Feature: Control Center: The system shall support the enabling/disabling of field validation types.  (Date (Y-M-D) | Datetime (Y-M-D H:M) | Datetime w/seconds (Y-M-D H:M:S) | Email | Integer | Number | Number (1 decimal place - comma as decimal) | Time (HH:MM))

  As a REDCap end user
  I want to see that Field validation is functioning as expected

  Scenario: A.4.8.0100.100 Control center Enable/disable field validation
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.4.8.0100.100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION - Verify field validation Disable
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Field Validation Types"
    Then I should see "Validation Types Currently Available for Use in All Projects"

    When I click on the button labeled "Disable" in the row labeled "Date (D-M-Y)"
    Then I should see a button labeled "Enable" in the row labeled "Date (D-M-Y)"

    When I click on the button labeled "Disable" in the row labeled "Datetime (M-D-Y H:M)"
    Then I should see a button labeled "Enable" in the row labeled "Datetime (M-D-Y H:M)"

    When I click on the button labeled "Disable" in the row labeled "Datetime w/ seconds (Y-M-D H:M:S)"
    Then I should see a button labeled "Enable" in the row labeled "Datetime w/ seconds (Y-M-D H:M:S)"

    When I click on the button labeled "Disable" in the row labeled "Email"
    Then I should see a button labeled "Enable" in the row labeled "Email"

    When I click on the button labeled "Disable" in the row labeled "Integer"
    Then I should see a button labeled "Enable" in the row labeled "Integer"

    When I click on the button labeled "Disable" in the row labeled "Number"
    Then I should see a button labeled "Enable" in the row labeled "Number"

    # ATS : Step below skipped because already disabled by the default install of REDCap ...
    #And I click on the button labeled "Disable" in the row labeled "Number (1 decimal place - comma as decimal)"
    And I should see a button labeled "Enable" in the row labeled "Number (1 decimal place - comma as decimal)"

    When I click on the button labeled "Disable" in the row labeled "Time (HH:MM)"
    Then I should see a button labeled "Enable" in the row labeled "Time (HH:MM)"


    ##VERIFY: options not available on validation dropdown field
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.4.8.0100.100"
    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    And I click on the button labeled "Dismiss"
    Then I should see "The project is now in Draft Mode."
    When I click on the link labeled "Data Types"
    And I click on the button labeled "Dismiss"
    And I click on the first button labeled "Add Field"

    # MANUAL NOTE : You should NOT see the following options in the "Validation?" dropdown (because we disabled them in steps above):
    # - Date (D-M-Y)  
    # - Datetime (M-D-Y H:M)  
    # - Datetime w/seconds (Y-M-D H:M:S)
    # - Email 
    # - Integer 
    # - Number
    # - Number (1 decimal place - comma as decimal)
    # - Time (HH:MM)
    When I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:" in the dialog box
    Then I should see the dropdown field labeled "Validation?" with the options below
      | ---- None ----                    |
      | Date (M-D-Y)                      |
      | Date (Y-M-D)                      |
      | Datetime (D-M-Y H:M)              |
      | Datetime (Y-M-D H:M)              |
      | Datetime w/ seconds (D-M-Y H:M:S) |
      | Datetime w/ seconds (M-D-Y H:M:S) |
      | Phone (North America)             |
      | Time (HH:MM:SS)                   |
      | Zipcode (U.S.)                    |
    And I click on the button labeled "Cancel" on the dialog box

    #SETUP
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "Field Validation Types"
    Then I should see "Validation Types Currently Available for Use in All Projects"

    When I click on the button labeled "Enable" in the row labeled "Date (D-M-Y)"
    Then I should see a button labeled "Disable" in the row labeled "Date (D-M-Y)"

    When I click on the button labeled "Enable" in the row labeled "Datetime (M-D-Y H:M)"
    Then I should see a button labeled "Disable" in the row labeled "Datetime (M-D-Y H:M)"

    When I click on the button labeled "Enable" in the row labeled "Datetime w/ seconds (Y-M-D H:M:S)"
    Then I should see a button labeled "Disable" in the row labeled "Datetime w/ seconds (Y-M-D H:M:S)"

    When I click on the button labeled "Enable" in the row labeled "Email"
    Then I should see a button labeled "Disable" in the row labeled "Email"

    When I click on the button labeled "Enable" in the row labeled "Integer"
    Then I should see a button labeled "Disable" in the row labeled "Integer"

    When I click on the button labeled "Enable" in the row labeled "Number"
    Then I should see a button labeled "Disable" in the row labeled "Number"

    When I click on the button labeled "Enable" in the row labeled "Number (1 decimal place - comma as decimal)"
    Then I should see a button labeled "Disable" in the row labeled "Number (1 decimal place - comma as decimal)"

    When I click on the button labeled "Enable" in the row labeled "Time (HH:MM)"
    Then I should see a button labeled "Disable" in the row labeled "Time (HH:MM)"

    #FUNCTIONAL REQUIREMENT
    ##ACTION - Verify field validation Enable
    ##VERIFY: options are available on validation dropdown field

    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.4.8.0100.100"
    And I click on the link labeled "Designer"
    And I click on the link labeled "Data Types"
    And I click on the first button labeled "Add Field"

    When I select "Text Box (Short Text, Number, Date/Time, ...)" on the dropdown field labeled "Field Type:" in the dialog box
    Then I should see the dropdown field labeled "Validation?" with the options below
      | ---- None ----                              |
      | Date (D-M-Y)                                |
      | Date (M-D-Y)                                |
      | Date (Y-M-D)                                |
      | Datetime (D-M-Y H:M)                        |
      | Datetime (M-D-Y H:M)                        |
      | Datetime (Y-M-D H:M)                        |
      | Datetime w/ seconds (D-M-Y H:M:S)           |
      | Datetime w/ seconds (M-D-Y H:M:S)           |
      | Datetime w/ seconds (Y-M-D H:M:S)           |
      | Email                                       |
      | Integer                                     |
      | Number                                      |
      | Number (1 decimal place - comma as decimal) |
      | Phone (North America)                       |
      | Time (HH:MM:SS)                             |
      | Time (HH:MM)                                |
      | Zipcode (U.S.)                              |
    And I click on the button labeled "Cancel" on the dialog box
#End