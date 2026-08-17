Feature: B.6.7.2100. Field Creation: The system shall support the creation of Enhanced Signature fields to allow users to capture electronic signatures using typed or handwritten signatures.
    As a REDCap end user
    I want to see that enahnced signature fields are working as expected.

    Scenario: B.6.7.2100.0100 Creation of Enhanced Signature field through the Online Designer
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "New Project"
        And I enter "B.6.7.2100.0100" into the input field labeled "Project title"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
        And I click on the radio labeled "Empty project (blank slate)"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created"
        And I should see "B.6.7.2100.0100"

        #SETUP- Give User 1 full rights
        When I click on the link labeled "User Rights"
        And I enter "Test_User1" into the field with the placeholder text of "Add new user"
        And I click on the button labeled "Add with custom rights"
        And I check the User Right named "Create Records"
        And I check the User Right named "Logging"
        And I click on the button labeled "Add user"
        Then I should see "Test User1"

        ##SETUP_PRODUCTION
        When I click on the link labeled "Setup"
        And I click on the button labeled "Move project to production"
        And I click on the radio labeled "Keep ALL data saved so far"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see " Success! The project is now in production."

        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Enhanced Signature field creation
        Given I click on the link labeled "Form 1"
        And I click on the Add Field input button below the field named "Record ID"

        When I select "Enhanced Signature (draw or type signature)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Enhanced Signature" into the Field Label of the open "Add New Field" dialog box
        And I enter "enhanced_signature" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save"
        Then I should see the field labeled "Enhanced Signature"
        And I should see the link labeled "Add signature"

        ##SETUP_PRODUCTION
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit"
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close"

        ##VERIFY_CODEBOOK
        When I click on the link labeled "Codebook"
        Then I should see a table header and rows containing the following values in the codebook table:
            | Variable / Field Name  | Field Label        | Field Attributes           |
            | [enhanced_signature]   | Enhanced Signature | file (enhanced_signature)  |

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported |
            | test_admin | Manage/Design | Create project field                    |

     Scenario: B.6.7.2100.0200 Typed signature is rendered using a selectable font and stored as an image
        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "B.6.7.2100.0100"
        Then I should see "B.6.7.2100.0100"

        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Capture a typed signature using a selectable font
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"
        And I click on the link labeled "Add signature"
        Then I should see "Add signature"
        When I click on the button labeled "Type signature"
        And I enter "Jane Doe" into the input field labeled "Type your signature"
        #Select "Signature font"
        And I click on the icon labeled "Change Font"
        And I click on "Great Vibes"

        When I click on the button labeled "Save signature"
        Then I should see "Remove signature"
        And I should see ".png"
        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 1 successfully added."

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action           | List of Data Changes OR Fields Exported |
            | test_user1 | Create record 1   | enhanced_signature = '1'                    |

    Scenario: B.6.7.2100.0300 Handwritten signature is captured by drawing and stored as an image
        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Capture a handwritten signature by drawing
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"

        And I click on the link labeled "Add signature"
        Then I should see "Add signature"

        When I click on the button labeled "Draw signature"
        And I draw a signature in the signature field area
        And I click on the button labeled "Save signature"
        Then I should see a link labeled "Remove signature"
        #Manual testing should show a full file name.
        And I should see ".png"
        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 2 successfully added."

        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action            | List of Data Changes OR Fields Exported |
            | test_user1 | Create record 1   | enhanced_signature = '1'                   |

    Scenario: B.6.7.2100.0400 Existing Signature field converts to an Enhanced Signature field without loss of existing signature data
        #SETUP adding a classic signature field to a project
        Given I login to REDCap with the user "Test_Admin"
        And  I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        When I click on the link labeled "Online Designer"
        And I click on the link labeled "Form 1"
        And I click on the Add Field input button below the field named "Record ID"
       
        When I select "Signature (draw signature with mouse or finger)" from the Field Type dropdown of the open "Add New Field" dialog box
        And I enter "Classic Signature" into the Field Label of the open "Add New Field" dialog box
        And I enter "classic_signature" into the Variable Name of the open "Add New Field" dialog box
        And I click on the button labeled "Save"
        Then I should see the field labeled "Classic Signature"
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit"
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close"

        ##ACTION: Capture existing signature data on the classic field
        Given I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record"

        Given I click on the link labeled "Add signature"
        And I should see "Add signature"
        And I draw a signature in the signature field area
        When I click on the button labeled "Save signature"
        Then I should see a link labeled "Remove signature"
        When I click on the button labeled "Save & Exit Form"
        Then I should see "Record ID 3 successfully added."
        
        #VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action           | List of Data Changes OR Fields Exported |
            | test_admin | Create record 3  | classic_signature = '2'                   |
        
        #FUNCTIONAL_REQUIREMENT
        ##ACTION: Convert the Signature field to an Enhanced Signature field
        When I click on the link labeled "Designer"
        And I click on the button labeled "Enter Draft Mode"
        Then I should see "The project is now in Draft Mode"

        When I click on the link labeled "Form 1"
        And I click on the Edit image for the field named "Classic Signature"
        
        And I select "Enhanced Signature (draw or type signature)" from the Field Type dropdown of the open "Edit Field" dialog box
        And I click on the button labeled "Save"
        And I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit"
        Then I should see "Changes Were Made Automatically"
        When I click on the button labeled "Close"

        ##VERIFY: existing signature data is preserved after conversion
        Given I click on the link labeled "Add / Edit Records"
        And I select "1" on the dropdown field labeled "select record"
        And I click the bubble for the row labeled "Form 1" on the column labeled "Status"
        Then I should see a link labeled "Remove signature"
        And I should see ".png"

        ##VERIFY_LOG
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Username   | Action        | List of Data Changes OR Fields Exported             |
            | test_admin | Manage/Design | Approve production project modifications (automatic)|
            | test_admin | Manage/Design | Edit project field                                  |
#END
