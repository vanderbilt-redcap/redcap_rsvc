Feature: Field Creation: The system shall support the creation and spliting matrix of fields

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.2000.100 Matrix of Fields through the Online Designer

        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        #Manual: Append project name with the current version (i.e. "X.X.X.XXX.XXX - LTS X.X.X")
        When I click on the link labeled "New Project"
        And I enter "B.6.7.2000.100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"

        ##SETUP_PRODUCTION
        When I click on the link labeled "My Projects"
        And I click on the link labeled "B.6.7.2000.100"
        And I click on the button labeled "Online Designer"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: matrix fields creation
        When I click on the link labeled "Form 1"
        And I click on the button labeled "Add Matrix of Fields"

        And I enter "Vanilla" into the last input field in the Matrix column labeled exactly "Field Label" in the dialog box
        And I enter "flavor1" into the last input field in the Matrix column labeled exactly "Variable Name" in the dialog box
        And I click on the button labeled "Add another row" in the dialog box

        And I enter "Chocolate" into the last input field in the Matrix column labeled exactly "Field Label" in the dialog box
        And I enter "flavor2" into the last input field in the Matrix column labeled exactly "Variable Name" in the dialog box
        And I click on the button labeled "Add another row" in the dialog box

        And I enter "Strawberry" into the last input field in the Matrix column labeled exactly "Field Label" in the dialog box
        And I enter "flavor3" into the last input field in the Matrix column labeled exactly "Variable Name" in the dialog box

        And I enter "1, Dislike {enter} 2, Neutral {enter} 3, Love" into the textarea field labeled "Matrix Column Choices" in the dialog box
        And I enter "ice_cream" into the input field labeled "Matrix group name" in the dialog box

        And I click on the button labeled "Save" in the dialog box

        Then I should see the field labeled "Matrix Group:  ice_cream"
        And I should see a table row containing the following values in a table:
            | Dislike | Neutral | Love |

        ##VERIFY_LOGGING
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported               |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Create matrix of fields                               |

        #VERIFY: SPLIT OF MATRIX
        When I click on the link labeled "Designer"  
        And I click on the link labeled "Form 1"
        And I click on the Edit Matrix image for the field named "ice_cream"

        Given I see "Edit Matrix of Fields"
        And I click on the button labeled "Save & split matrix into separate fields" in the dialog box
        And I click on the button labeled "Split matrix" in the dialog box

        Then I should see the field labeled "Vanilla"
        And I should see the field labeled "Chocolate"
        And I should see the field labeled "Strawberry"
        And I should NOT see the field labeled "Matrix Group:  ice_cream"

        ##VERIFY_LOGGING
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action        | List of Data Changes OR Fields Exported               |
            | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Edit matrix of fields                                 |
#END