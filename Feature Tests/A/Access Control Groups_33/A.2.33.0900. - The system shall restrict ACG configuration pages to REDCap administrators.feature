Feature: A.2.33.0900: The system shall restrict ACG configuration pages to REDCap administrators.---Control Center

    As an Admin
    I want to see that I can restrict ACG configuration pages to REDCap administrators.

    Scenario: The system shall restrict ACG configuration pages to REDCap administrators.---Control Center
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "Control Center"
        And I click on the link labeled "Access Control Groups"
        And I click on the button labeled "Enable Access Control Groups"
        Then I should see "Enable the Access Control Groups feature?"
        When I click on the button labeled "Enable"
        Then I should see "ACG enabled"
        

        