Feature: B.3.14.1300. - User Interface: Add/Edit Records: The system shall support retaining user preferences for record search, navigation, and arm selection.
    As a REDCap end user
    I want to see that Add/Edit Records user preferences are retained across sessions

    Scenario: B.3.14.1300.100 Add/Edit Records remembers the user's last selected Data Search target
        #SETUP
        Given I login to REDCap with the user "Test_User1"
        And I create a new project named "B.3.14.1300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to Add / Edit Records and change the Data Search target
        When I click on the link labeled "Add / Edit Records"
        Then I should see "Add / Edit Records"

        ##ACTION: Select a non-default Data Search target
        When I select "Record ID" on the dropdown field labeled "Choose a field to search"
        And I check the checkbox labeled "Remember this selection"

        ##VERIFY: The selected Data Search target is retained after navigating away and returning
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.14.1300.100"
        And I click on the link labeled "Add / Edit Records"
        Then I should see "record_id (Record ID)"

    Scenario: B.3.14.1300.200 When configured, selecting a Data Search result navigates to the record's Record Home Page
        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to Add / Edit Records and enable "Navigate directly to Record Home Page" preference
        When I click on the link labeled "Add / Edit Records"
        Then I should see "Add / Edit Records"

        ##ACTION: Enable the preference to navigate directly to the Record Home Page on search result selection
        And I click on the radio labeled "Record Home Page"

        ##ACTION: Search for an existing record and select the result
        And I enter "1" into the input field labeled "Search query"
        And I click on '"1" in Record ID 1  for event Event 1 (Arm 1: Arm 1)'

        ##VERIFY: The user is taken directly to the Record Home Page
        Then I should see "Record Home Page"
        And I should see "Record ID 1"

    Scenario: B.3.14.1300.300 Add/Edit Records remembers and preselects the user's last selected arm
        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to Add / Edit Records and select Arm 2
        Given I click on the link labeled "Add / Edit Records"
        Then I should see "Add / Edit Records"

        ##ACTION: Switch to Arm 2
        When I select "Arm 2: Arm Two" on the dropdown field labeled "Choose an existing Record ID"
        Then I should see "Arm 2"
        Given I logout

        ##VERIFY: Arm 2 is retained as the selected arm after navigating away and returning
        When I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.14.1300.100"
        And I click on the link labeled "Add / Edit Records"
        Then I should see "Arm 2"
        
        #Create a test record for arm 2
        When I click on the button labeled "Add new record for the arm selected above"
        And I click on the button labeled "Save & Exit Form"
        Then I should see  "Record ID 7 successfully added." 
        When I click on the link labeled "Home"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.3.14.1300.100"
        And I click on the link labeled "Add / Edit Records"
        Then I should see "Arm 2"

    Scenario: B.3.14.1300.400 In a multi-arm project, the configured preference synchronizes arm selection between Add/Edit Records and the Record Status Dashboard
        #FUNCTIONAL REQUIREMENT
        ##ACTION: Enable arm synchronization between Add/Edit Records and Record Status Dashboard
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Maintain arm selection with Record Status Dashboard"
        Then I should see "Add / Edit Records"
        And I should see "Arm 2"

        ##VERIFY: Navigating to Record Status Dashboard reflects the same arm selection
        When I click on the link labeled "Record Status Dashboard"
        Then I should see "Arm 2"
        And I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID |
            | 7         |

        ##ACTION: Switch arm selection to Arm 1 on Record Status Dashboard
        When I click on the link labeled "Arm 1:Arm 1"
        Then I should see "Arm 1"
        And I should see a table header and rows containing the following values in the record status dashboard table:
            | Record ID | 
            | 1         |
            | 2         |  
            | 3         |  
            | 4         |  
            | 5         |  
            | 6         | 


        ##VERIFY: Navigating back to Add / Edit Records reflects the updated arm selection
        When I click on the link labeled "Add / Edit Records"
        Then I should see "Add / Edit Records"
        And I should see "Arm 1"

    Scenario: B.3.14.1300.500 The Record Status Dashboard arm-synchronization preference is not displayed for single-arm projects
        #SETUP
        Given I click on the link labeled "REDCap"
        And I click on the link labeled "New Project"
        And I enter "Single-arm project" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "Single-arm project"

        #FUNCTIONAL REQUIREMENT
        ##ACTION: Navigate to Add / Edit Records on a single-arm project
        When I click on the link labeled "Add / Edit Records"
        Then I should see "Add / Edit Records"
        ##VERIFY: The arm synchronization preference is not visible for single-arm projects
        And I should NOT see "Maintain arm selection with Record Status Dashboard"

    #END
