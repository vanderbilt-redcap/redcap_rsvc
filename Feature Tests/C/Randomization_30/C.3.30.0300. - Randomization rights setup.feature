Feature: C.3.30.0300 	User Interface: The system shall allow user rights configuration to create and manage Randomization Setup.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

  Scenario: #SETUP project with randomization enabled - "Project 3.30 randAM.xml"
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "C.3.30.0300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project 3.30 baserand.REDCap.xml", and clicking the "Create Project" button

  Scenario: #SETUP Randomization User Rights (Give User all Rand Rights)
    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I check the checkbox labeled "Setup"
    And I check the checkbox labeled "Dashboard"
    And I check the checkbox labeled "Randomize"
    And I click on the button labeled "Save Changes"
    Then I should see 'User "Test_User1" was successfully edited' 

  Scenario: C.3.30.0300.0100. User with Randomization Setup rights can use Randomization Module Setup Configuration page.
    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    Then I should see "Randomization"
    And I should see a button labeled "Add new randomization model"
    When I click on the button labeled "Add new randomization model"
    And I select "rand_group (Randomization group 1)" on the dropdown field labeled "- select a field -"
    And I click on the button labeled "Save randomization model"
    Then I should see "Success! The randomization model has been saved!"
    

  Scenario: C.3.30.0300.0200. User without Randomization Setup rights cannot use Randomization Module Setup Configuration page.
    When I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges"
    And I uncheck the checkbox labeled "Setup"
    And I click on the button labeled "Save Changes"
    Then I should see 'User "test_user1" was successfully edited'

    When I click on the link labeled "Setup"
    And I click on the button labeled "Set up randomization"
    Then I should see "Randomization"
    Then I should NOT see a button labeled "Add new randomization model"
#END