Feature: User Interface: The system shall support the ability to download two versions of a data import template formatted as a CSV file, one to accommodate records in rows and one to accommodate records in columns.

  As a REDCap end user
  I want to see that Data import is functioning as expected

  Scenario: B.3.16.0100.100 data import template
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.3.16.0100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button

    #SETUP_PRODUCTION
    When I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Data Import Template (with records in rows)
    When I click on the link labeled "Data Import Tool"
    Then I should see a link labeled "Download your Data Import Template"
    And I click on the link labeled "Download your Data Import Template"
    Then I should see a downloaded file named "B3160100100_ImportTemplate_yyyy-mm-dd.csv"

    ##VERIFY
    And the downloaded CSV with filename "B3160100100_ImportTemplate_yyyy-mm-dd.csv" has the header below
      | record_id | name | email | text_validation_complete | ptname | bdate | role | notesbox | multiple_dropdown_auto | multiple_dropdown_manual | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | required | identifier_ssn | identifier_phone | slider | date_time_hh_mm | date_time_hh_mm_ss | data_types_complete | data_dictionary_form_complete | phone | demo_branching_complete |  |
    #Manual: close csv file

    #FUNCTIONAL REQUIREMENT
    ##ACTION Data Import Template (with records in columns)
    Then I should see a link labeled "column format"
    And I click on the link labeled "column format"
    Then I should see a downloaded file named "B3160100100_ImportTemplate_yyyy-mm-dd.csv"
    #Manual: close csv file

    ##VERIFY
    And the downloaded CSV with filename "B3160100100_ImportTemplate_yyyy-mm-dd.csv" has the header and rows below
      | Variable / Field Name         | Record |
      | record_id                     |        |
      | name                          |        |
      | email                         |        |
      | text_validation_complete      |        |
      | ptname                        |        |
      | bdate                         |        |
      | role                          |        |
      | notesbox                      |        |
      | multiple_dropdown_auto        |        |
      | multiple_dropdown_manual      |        |
      | multiple_radio_auto           |        |
      | radio_button_manual           |        |
      | checkbox___1                  |        |
      | checkbox___2                  |        |
      | checkbox___3                  |        |
      | required                      |        |
      | identifier_ssn                |        |
      | identifier_phone              |        |
      | slider                        |        |
      | date_time_hh_mm               |        |
      | date_time_hh_mm_ss            |        |
      | data_types_complete           |        |
      | data_dictionary_form_complete |        |
      | phone                         |        |
      | demo_branching_complete       |        |
#END