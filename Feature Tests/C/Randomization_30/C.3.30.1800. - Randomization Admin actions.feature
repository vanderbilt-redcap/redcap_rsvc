Feature: Project Interface Administrator Access: The system shall support the administrator role's ability to perform the following actions with specifying the reason on the randomization module allocation table: perform edit target field, edit target allocation, manual randomization, and make sequence unavailable.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

  Scenario: #SETUP - Create new project
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.1800" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button

    #Adding user rights Test_User1 (with randomize rights)
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled "Assign"
    Then I should see "test_user1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    #SETUP Creating randomiztion stategy and adding allocation table.
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the button labeled "Add new randomization model"
    And I check the checkbox labeled "A) Use stratified randomization?"
    And I select "strat_1 (Stratification 1)" on the first dropdown field labeled "- select a field -"
    And I select "rand_group (Randomization group 1)" on the dropdown field labeled "Choose your randomization field"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"

    #Adding valid allocation table
    When I upload a "csv" format file located at "import_files/Randomization_one_strat.csv", by clicking the button near "for use in DEVELOPMENT status" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see "Already uploaded" in the row labeled "for use in DEVELOPMENT status"

    #Adding record with randomization
    And I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Demographics" on the column labeled "Status"
    And I select the radio option "Yes" for the field labeled "Stratification 1"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 2 successfully edited."
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize"
    Then I should see "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize"
    Then I should see "was randomized for"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 2 successfully edited."

    #Adding record with randomization
    And I click on the link labeled "Add / Edit Records"
    And I select "3" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Demographics" on the column labeled "Status"
    And I select the radio option "No" for the field labeled "Stratification 1"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 3 successfully edited."

  Scenario:#C.3.30.1800.0100. Admin can edit target field with reason.
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    Then I should see a table header and rows containing the following values in a table:
      | Used    | Not Used | Allocated records | Stratification 1 |Randomization group|
      | 0       |     1    |                   | No (0)           | Drug B (2)        |
      | 1       |     0    |     2             | Yes (1)          | Drug A (1)        |
    And I click on the icon in the column labeled "View" and the row labeled "Drug B"
    Then I should see "View Allocation Table"
    And I should see a table header and rows containing the following values in a table:
      | Sequence | Target Field | Alternate | Record | Edit |
      |  1       | 2            |           |        |      |
    And I should see a "2" within the "1" row of the column labeled "Target Field"

    When I click on the icon labeled "Edit Target Field"
    Then I should see "Specify Reason"
    And I should see "Enter new value"
    And I should see 'Type "CONFIRM"'

    When I enter "Test reason" into the input field labeled "Specify Reason"
    And I enter "3" into the input field labeled "Enter new value"
    And I enter "CONFIRM" into the input field labeled 'Type "CONFIRM"'
    And I click on the button labeled "Confirm"
    Then I should see a "3" within the "1" row of the column labeled "Target Field"
    And I should see a table header and rows containing the following values in a table:
      | Sequence | Target Field | Alternate | Record | Edit |
      |  1       | 3            |           |        |      |

    #VERIFY that the change to the target is reflected in the randomization dashboard
    When I click on the link labeled "Dashboard"
    Then I should see a table header and rows containing the following values in a table:
      | Used    | Not Used | Allocated records | Stratification 1 |Randomization group |
      | 0       |     1    |                   | No (0)           | Placebo (3)        |
      | 1       |     0    |     2             | Yes (1)          | Drug A (1)         |

    #VERIFY: Logging
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported      |
      | test_admin | Manage/Design | Update randomization allocation table (development) (aid: 2, target_field: "3", reason: "Test reason")|

  Scenario: #C.3.30.1800.0200. Admin can edit target alternative with reason.
    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    And I click on the icon in the column labeled "View" and the row labeled "Placebo"
    Then I should see "View Allocation Table"
    And I should see a " " within the "1" row of the column labeled "Alternate"
    When I click on the icon labeled "Edit Target Alternate"
    Then I should see "Specify Reason"
    And I should see "Enter new value"
    And I should see 'Type "CONFIRM"'

    When I enter "Test reason" into the input field labeled "Specify Reason"
    And I enter "1" into the input field labeled "Enter new value"
    And I enter "CONFIRM" into the input field labeled 'Type "CONFIRM"'
    And I click on the button labeled "Confirm"
    Then I should see a "1" within the "1" row of the column labeled "Alternate"
    And I should see a table header and rows containing the following values in a table:
      | Sequence | Target Field | Alternate | Record | Edit |
      |  1       | 3            | 1         |        |      |
    #VERIFY: Logging
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported      |
      | test_admin | Manage/Design | Update randomization allocation table (development) (aid: 2, target_field_alt: "1", reason: "Test reason")|

    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Setup" and the row labeled "1"
    And I click on the button labeled "Download table"
    Then I should see the latest downloaded "csv" file containing the headings and rows below
      | redcap_randomization_number | redcap_randomization_group | strat_1 |
      |                             | 1                          | 1       |
      | 1                           | 3                          | 0       |

  Scenario: #C.3.30.1800.0300. Admin can manually randomize a record with reason.
    #VERIFY record is not randomized.
    When I click on the link labeled "Add / Edit Records"
    And I select "3" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    Then I should see a button labeled "Randomize"
    And I should NOT see "Already randomized"

    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    And I click on the icon in the column labeled "View" and the row labeled "Placebo"
    Then I should see "View Allocation Table"
    And I should see a "" within the "1" row of the column labeled "Record"

    When I click on the icon labeled "Manual Randomization"
    Then I should see "Specify Reason"
    And I should see "Existing record to assign"
    And I should see 'Type "CONFIRM"'

    When I enter "Test reason" into the input field labeled "Specify Reason"
    And I enter "3" into the input field labeled "Existing record to assign"
    And I enter "CONFIRM" into the input field labeled 'Type "CONFIRM"'
    And I click on the button labeled "Confirm"
    Then I should see a "3" within the "1" row of the column labeled "Record"
    And I should see a table header and rows containing the following values in a table:
      | Sequence | Target Field | Alternate | Record | Edit |
      |  1       | 3            | 1         | 3      |      |

    When I click on the link labeled "Dashboard"
    Then I should see a table header and rows containing the following values in a table:
      | Used    | Not Used | Allocated records | Stratification 1 |Randomization group|
      | 1       |     0    |     2             | Yes (1)          | Drug A (1)        |
      | 1       |     0    |     3             | No (0)           | Placebo (3)       |

    #VERIFY: Logging
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported      |
      | test_admin | Manage/Design | Update randomization allocation table (development) - Randomize record (manual) (aid: 2, is_used_by: "3", reason: "Test reason")|

    #VERIFY the Manual record assignment is reflected in the record.
    When I click on the link labeled "Add / Edit Records"
    And I select "3" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    Then I should see "Already randomized"
    And I should NOT see a button labeled "Randomized"
    And I should see a radio labeled "Placebo" in the row labeled "Randomization group 1" that is disabled
    And I should see the radio labeled "Randomization group 1" with option "Placebo" selected

  Scenario: #C.3.30.1800.0600. Admin can remove randomization with reason.
    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    And I click on the icon in the column labeled "View" and the row labeled "Drug A"
    Then I should see "View Allocation Table"
    And I should see a table header and rows containing the following values in a table:
      | Sequence | Target Field | Alternate | Record | Edit |
      |  1       | 1            |           | 2      |      |

    When I click on the icon labeled "Remove Randomization"
    Then I should see "Remove Randomization"
    And I should see "Specify Reason"
    And I should see 'Type "CONFIRM"'

    When I enter "Test reason" into the input field labeled "Specify Reason"
    And I enter "CONFIRM" into the input field labeled 'Type "CONFIRM"'
    And I click on the button labeled "Confirm"
    Then I should see a "" within the "1" row of the column labeled "Record"
    And I should see an icon labeled "Edit Target Field" in the row labeled "1"
    And I should see an icon labeled "Edit Target Alternate" in the row labeled "1"
    And I should see an icon labeled "Manual Randomization" in the row labeled "1"
    And I should see an icon labeled "Make Sequence Unavailable" in the row labeled "1"
    And I should see a table header and rows containing the following values in a table:
      | Sequence | Target Field | Alternate | Record | Edit |
      |  1       | 1            |           |        |      |

    #VERIFY: Logging
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported      |
      | test_admin | Manage/Design | Update randomization allocation table (development) - Remove randomization (aid: 1, is_used_by: "", reason: "Test reason")|
      | test_admin | Update record 2 | rand_group = ''|

    #VERIFY record 2 is now not randomized
    Given I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    Then I should see a button labeled "Randomize"

  Scenario: #C.3.30.1800.0400. Admin can mark a sequence as unavailable with reason.
    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    And I click on the icon in the column labeled "View" and the row labeled "Drug A"
    Then I should see "View Allocation Table"

    When I click on the icon labeled "Make Sequence Unavailable"
    Then I should see "Make Sequence Unavailable"
    And I should see "Specify Reason"
    And I should see 'Type "CONFIRM"'

    When I enter "Test reason" into the input field labeled "Specify Reason"
    And I enter "CONFIRM" into the input field labeled 'Type "CONFIRM"'
    And I click on the button labeled "Confirm"
    Then I should see a "" within the "1" row of the column labeled "Record"
    And I should see an icon labeled "Restore" in the row labeled "1"
    And I should see a table header and rows containing the following values in a table:
      | Sequence | Target Field | Alternate | Record | Edit |
      |  1       | 1            |           |        |      |

    #VERIFY: Logging
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action                      | List of Data Changes OR Fields Exported      |
      | test_admin | Manage/Design               | Update randomization allocation table (development) (aid: 1, is_used_by: "1-UNAVAILABLE", reason: "Test reason")|
      | test_admin | Update record 1-UNAVAILABLE | rand_group = '1'|

    #VERIFY Sequence Unavailable when randomizing a record.
    Given I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize"
    Then I should see "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize"
    Then I should see "RANDOMIZATION ERROR"
    And I should see "cannot be randomized because there are no allocations available for assignment based upon the values you just submitted. If this is a problem, please speak to the person(s) in charge of randomization for this project (e.g., your project manager, data analyst, statistician) in order to resolve this."
    And I click on the button labeled "Close"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 2 successfully edited."

  Scenario: #C.3.30.1800.0500. Admin can restore allocation with reason.
    Given I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    And I click on the icon in the column labeled "Dashboard" and the row labeled "1"
    And I click on the icon in the column labeled "View" and the row labeled "Drug A"
    Then I should see "View Allocation Table"

    When I click on the icon labeled "Restore"
    Then I should see "Restore"
    And I should see "Specify Reason"
    And I should see 'Type "CONFIRM"'

    When I enter "Test reason" into the input field labeled "Specify Reason"
    And I enter "CONFIRM" into the input field labeled 'Type "CONFIRM"'
    And I click on the button labeled "Confirm"
    Then I should see a "" within the "1" row of the column labeled "Record"
    And I should see an icon labeled "Edit Target Field" in the row labeled "1"
    And I should see an icon labeled "Edit Target Alternate" in the row labeled "1"
    And I should see an icon labeled "Manual Randomization" in the row labeled "1"
    And I should see an icon labeled "Make Sequence Unavailable" in the row labeled "1"
    And I should see a table header and rows containing the following values in a table:
      | Sequence | Target Field | Alternate | Record | Edit |
      |  1       | 1            |           |        |      |

    #VERIFY: Logging
    Given I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data Changes OR Fields Exported      |
      | test_admin | Manage/Design | Update randomization allocation table (development) (aid: 1, is_used_by: "", reason: "Test reason")|

    #VERIFY restored value is used when randomizing a record
    Given I click on the link labeled "Add / Edit Records"
    And I select "2" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble for the row labeled "Randomization" on the column labeled "Status"
    And I click on the button labeled "Randomize"
    Then I should see "Below you may perform randomization for Record ID"
    And I click on the button labeled "Randomize"
    Then I should see "was randomized for"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record ID 2 successfully edited."

    Given I logout
#END