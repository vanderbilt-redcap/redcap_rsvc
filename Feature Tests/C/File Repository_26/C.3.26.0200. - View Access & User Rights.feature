Feature: User Interface: The system shall support limiting file repository user view access and export rights.

    As a REDCap end user
    I want to see that file repository is functioning as expected

    Scenario: C.3.26.200.100 - Limit user view and export access based on User Rights and DAG

    #SETUP
        Given I login to REDCap with the user "Test_Admin"
        When I create a new project named "C.3.26.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"

    ##SETUP auto-archive
        When I click on the link labeled "Designer"
        And I click on the button labeled "e-Consent"
        And I enable the toggle button labeled "Consent"
        And I should see a toggle button labeled "Consent" that is in the enabled state

    ##SETUP File Repository
        And I click on the link labeled "File Repository"

    #Create DAG limited folder
        And I click on the button labeled "Create folder"
        And I enter "TestGroup1_Folder" into the input field labeled "New folder name:"
        And I select "TestGroup1" on the dropdown field labeled "Limit access by Data Access Group?"
        And I click on the button labeled "Create folder" in the dialog box
        Then I should see "TestGroup1_Folder"

    #Create role limited folder
        And I click on the button labeled "Create folder"
        And I enter "Role1_Folder" into the input field labeled "New folder name"
        And I select "1_FullRights" on the dropdown field labeled "Limit access by User Role?"
        And I click on the button labeled "Create folder" in the dialog box
        Then I should see "Role1_Folder"

  #Scenario: SETUP User Rights
    ##SETUP User Rights:
        When I click on the link labeled "User Rights"
        And I click on the button labeled "Upload or download users, roles, and assignments"
        And I click on the link labeled "Upload users (CSV)"
        Then I upload a "csv" format file located at "/import_files/user list for project 1.csv", by clicking the button near "Select your CSV file of users and their user rights to be added/modified:" to browse for the file, and clicking the button labeled "Upload" to upload the file
        Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
        And I should see a table header and rows containing the following values in a table in the dialog box:
            | username   |
            | test_admin |
            | test_user1 |
            | test_user2 |
            | test_user3 |
            | test_user4 |

        Given I click on the button labeled "Upload" in the dialog box
        Then I should see a dialog containing the following text: "SUCCESS!"
        And I click on the button labeled "Close" in the dialog box

        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | test_admin          |
            | —                       | test_user1          |
            | —                       | test_user2          |
            | —                       | test_user3          |
            | —                       | test_user4          |
            | 1_FullRights            | [No users assigned] |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | [No users assigned] |
            | 4_NoAccess_Noexport     | [No users assigned] |
            | TestRole                | [No users assigned] |

    ##SETUP Assign to roles
        When I click on the link labeled "test_user1 (Test User1)"
        And I click on the button labeled "Assign to role" on the tooltip
        And I select "1_FullRights" on the dropdown field labeled "Select Role" in the role selector dropdown
        And I click on the button labeled exactly "Assign"
        Then I should see "successfully ASSIGNED to the user role"
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | test_admin          |
            | —                       | test_user2          |
            | —                       | test_user3          |
            | —                       | test_user4          |
            | 1_FullRights            | test_user1          |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | [No users assigned] |
            | 4_NoAccess_Noexport     | [No users assigned] |
            | TestRole                | [No users assigned] |

        When I click on the link labeled "test_user2 (Test User2)"
        And I click on the button labeled "Assign to role" on the tooltip
        And I select "1_FullRights" on the dropdown field labeled "Select Role" in the role selector dropdown
        And I click on the button labeled exactly "Assign"
        Then I should see "successfully ASSIGNED to the user role"
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | test_admin          |
            | —                       | test_user3          |
            | —                       | test_user4          |
            | 1_FullRights            | test_user1          |
            |                         | test_user2          |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | [No users assigned] |
            | 4_NoAccess_Noexport     | [No users assigned] |
            | TestRole                | [No users assigned] |

        When I click on the link labeled "test_user3 (Test User3)"
        And I click on the button labeled "Assign to role" on the tooltip
        And I select "3_ReadOnly_Deidentified" on the dropdown field labeled "Select Role" in the role selector dropdown
        And I click on the button labeled exactly "Assign"
        Then I should see "successfully ASSIGNED to the user role"
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | test_admin          |
            | —                       | test_user4          |
            | 1_FullRights            | test_user1          |
            |                         | test_user2          |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | test_user3          |
            | 4_NoAccess_Noexport     | [No users assigned] |
            | TestRole                | [No users assigned] |

        When I click on the link labeled "test_user4 (Test User4)"
        And I click on the button labeled "Assign to role" on the tooltip
        And I select "3_ReadOnly_Deidentified" on the dropdown field labeled "Select Role" in the role selector dropdown
        And I click on the button labeled exactly "Assign"
        Then I should see "successfully ASSIGNED to the user role"
        Then I should see a table header and rows containing the following values in a table:
            | Role name               | Username            |
            | —                       | test_admin          |
            | 1_FullRights            | test_user1          |
            |                         | test_user2          |
            | 2_Edit_RemoveID         | [No users assigned] |
            | 3_ReadOnly_Deidentified | test_user3          |
            |                         | test_user4          |
            | 4_NoAccess_Noexport     | [No users assigned] |
            | TestRole                | [No users assigned] |

    #SETUP DAG: Assign User to DAG
        Given I click on the link labeled "Data Access Groups"
        When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
        And I select "TestGroup1" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"
        Then I should see "has been assigned to Data Access Group"
        Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups        | Users in group |
            | TestGroup1                | test_user1     |
            | TestGroup2                |                |
            | [Not assigned to a group] | test_admin     |
            |                           | test_user2     |
            |                           | test_user3     |
            |                           | test_user4     |

        When I select "test_user2 (Test User2)" on the dropdown field labeled "Assign user"
        And I select "TestGroup2" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"
        Then I should see "has been assigned to Data Access Group"
        Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups        | Users in group |
            | TestGroup1                | test_user1     |
            | TestGroup2                | test_user2     |
            | [Not assigned to a group] | test_admin     |
            |                           | test_user3     |
            |                           | test_user4     |

        When I select "test_user3 (Test User3)" on the dropdown field labeled "Assign user"
        And I select "TestGroup1" on the dropdown field labeled "to"
        And I click on the button labeled "Assign"
        Then I should see "has been assigned to Data Access Group"
        Then I should see a table header and rows containing the following values in a table:
            | Data Access Groups        | Users in group |
            | TestGroup1                | test_user1     |
            |                           | test_user3     |
            | TestGroup2                | test_user2     |
            | [Not assigned to a group] | test_admin     |
            |                           | test_user4     |

    #"Test_User4" is not assigned to a DAG
        And I logout

    #SETUP Record: Create record while in DAG through eConsent framework
        Given I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Consent" longitudinal instrument on event "Event 1" and click on the bubble
        Then I should see "Adding new Record ID"
        When I click on the button labeled "Save & Exit Form"
        And I should see "successfully added."

        Then I click the bubble to add a record for the "Consent" longitudinal instrument on event "Event 1" and click on the bubble
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        And I click on the button labeled "Next Page"
        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        And I click on the button labeled "Submit"
        When I click on the button labeled "Close survey"
        Then I should see "You may now close this tab/window"

        Given I return to the REDCap page I opened the survey from
        When I click on the link labeled "Record Status Dashboard"
        Then I should see "Record Status Dashboard (all records)"
        When I click on the link labeled exactly "1-1"
        And I wait for 1 seconds
        Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"
        And I should see "TestGroup1"

    #FUNCTIONAL_REQUIREMENT
    #ACTION Upload to top tier file repo (all users will see file) - using the Drag and drop files here to upload button
        When I click on the link labeled "File Repository"
        Then I should NOT see "All Files/TestGroup1_Folder" in the File Repository breadcrumb
        And I should see "All Files" in the File Repository breadcrumb
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                 |
            | Data Export Files    |
            | PDF Snapshot Archive |
            | Recycle Bin          |
            | TestGroup1_Folder    |
            | Role1_Folder         |

        When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
            | /import_files/user_list_for_project_1.csv |

    ##VERIFY file uploaded in folder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        | Time Uploaded    | Comments                |
            | TestGroup1_Folder           |                  |                         |
            | Role1_Folder                |                  |                         |
            | user_list_for_project_1.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    ##ACTION Upload to top tier file repo (all users will see file) - using the Select files to upload button
        When I click on the link labeled "File Repository"
        Then I should NOT see "All Files/TestGroup1_Folder" in the File Repository breadcrumb
        And I should see "All Files" in the File Repository breadcrumb
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                 |
            | Data Export Files    |
            | PDF Snapshot Archive |
            | Recycle Bin          |
            | TestGroup1_Folder    |
            | Role1_Folder         |

        When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
            | /import_files/testusers_bulkupload.csv |

    ##VERIFY file uploaded in folder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                     | Time Uploaded    | Comments                |
            | testusers_bulkupload.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Upload to DAG folder
        When I click on the link labeled "File Repository"
        Then I should NOT see "All Files/TestGroup1_Folder" in the File Repository breadcrumb
        And I should see "All Files" in the File Repository breadcrumb
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        |
            | Data Export Files           |
            | PDF Snapshot Archive        |
            | Recycle Bin                 |
            | TestGroup1_Folder           |
            | Role1_Folder                |
            | testusers_bulkupload.csv    |
            | user_list_for_project_1.csv |

        When I click on the link labeled "TestGroup1_Folder" in the File Repository table
        Then I should see "All Files/TestGroup1_Folder" in the File Repository breadcrumb
        And I should see "DAG-Restricted:TestGroup1" in the File Repository breadcrumb
        And I should see a table row containing the following values in the file repository table:
            | No files or subfolders exist in this folder |

        When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
            | /import_files/testusers_bulk_upload.csv |

    ##VERIFY uploaded in subfolder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                      | Time Uploaded    | Comments                |
            | testusers_bulk_upload.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Upload to Role folder
        When I click on the link labeled "File Repository"
        Then I should NOT see "All Files/TestGroup1_Folder" in the File Repository breadcrumb
        And I should see "All Files" in the File Repository breadcrumb
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                 |
            | Data Export Files    |
            | PDF Snapshot Archive |
            | Recycle Bin          |
            | TestGroup1_Folder    |
            | Role1_Folder         |

        And I should see "Data Export Files"
        And I click on the link labeled "Role1_Folder" in the File Repository table
        Then I should see "All Files/Role1_Folder" in the File Repository breadcrumb
        And I should see a table row containing the following values in the file repository table:
            | No files or subfolders exist in this folder |

    #C.3.26.400.100 #Upload more than one file at the same time using the select files to upload button
        When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
            | /import_files/File_Upload.docx           |
            | /import_files/instrument_designation.csv |

    #VERIFY uploaded in subfolder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                       | Time Uploaded    | Comments                |
            | File_Upload.docx           | mm/dd/yyyy hh:mm | Uploaded by test_user1. |
            | instrument_designation.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Auto-archive file in DAG TestGroup1
        When I click on the link labeled "File Repository"
        Then I should NOT see "All Files/Role1_Folder" in the File Repository breadcrumb
        And I should see "All Files" in the File Repository breadcrumb
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                 |
            | Data Export Files    |
            | PDF Snapshot Archive |
            | Recycle Bin          |
            | TestGroup1_Folder    |
            | Role1_Folder         |

        Given I click on the link labeled "PDF Snapshot Archive" in the File Repository table
        Then I should see a table header and rows containing the following values in the file repository table:
            | Record         | Survey                           | File Storage Time | Type      |
            | 1-1 TestGroup1 | Consent (Event 1 (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm  | e-Consent |

        And I logout

    ##SETUP Record: Create record while in DAG through
        Given I login to REDCap with the user "Test_User2"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        When I click on the link labeled "Add / Edit Records"
        And I click on the button labeled "Add new record for the arm selected above"
        And I click the bubble to add a record for the "Consent" longitudinal instrument on event "Event 1" and click on the bubble
        Then I should see "Adding new Record ID"
        When I click on the button labeled "Save & Exit Form"
        And I should see "successfully added."

        Then I click the bubble to add a record for the "Consent" longitudinal instrument on event "Event 1" and click on the bubble
        And I click on the button labeled "Survey options"
        And I click on the survey option label containing "Open survey" label
        And I click on the button labeled "Next Page"
        When I check the checkbox labeled "I certify that all of my information in the document above is correct."
        And I click on the button labeled "Submit"
        When I click on the button labeled "Close survey"
        Then I should see "You may now close this tab/window"
        Then I return to the REDCap page I opened the survey from
        When I click on the link labeled "Record Status Dashboard"
        Then I should see "Record Status Dashboard (all records)"
        And I should see the link labeled "2-1"

        When I click on the link labeled "2-1"
        And I wait for 1 second
        Then I should see the "Completed Survey Response" icon for the "Consent" longitudinal instrument on event "Event 1"
        And I should see "TestGroup2"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Unable to access DAG folder
        When I click on the link labeled "File Repository"
        And I should see "All Files" in the File Repository breadcrumb

    ##VERIFY See file uploaded by Test_User1
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        |
            | Data Export Files           |
            | PDF Snapshot Archive        |
            | Recycle Bin                 |
            | Role1_Folder                |
            | user_list_for_project_1.csv |
            | testusers_bulkupload.csv    |

        And I should NOT see "TestGroup1_Folder"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Interact in Role folder
        Given I click on the link labeled "Role1_Folder" in the File Repository table
        Then I should see "All Files/Role1_Folder" in the File Repository breadcrumb
        And I should see a table header and rows containing the following values in the file repository table:
            | Name                       | Time Uploaded    | Comments                |
            | File_Upload.docx           | mm/dd/yyyy hh:mm | Uploaded by test_user1. |
            | instrument_designation.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    #Download file previously uploaded by test_user1
        And I download a file by clicking on the link labeled "instrument_designation.csv"
        Then I should see a downloaded file named "instrument_designation.csv"

        Given I click on the link labeled "All Files" in the File Repository breadcrumb
        And I click on the link labeled "Role1_Folder" in the File Repository table
        Then I should see "All Files/Role1_Folder" in the File Repository breadcrumb

    ##ACTION Upload to Role folder
        When I click the button labeled "Select files to upload" to select and upload the following file to the File Repository:
            | /import_files/user-list-for-project-1.csv |

    ##VERIFY uploaded in subfolder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        | Time Uploaded    | Comments                |
            | user-list-for-project-1.csv | mm/dd/yyyy hh:mm | Uploaded by test_user2. |
            | File_Upload.docx            | mm/dd/yyyy hh:mm | Uploaded by test_user1. |
            | instrument_designation.csv  | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Auto-archive file in DAG TestGroup2
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive" in the File Repository table
    #See consent just created in testgroup2
    #Don't see consent created by testgroup1

        Then I should see a table header and rows containing the following values in the file repository table:
            | Record         | Survey                           | File Storage Time | Type      |
            | 2-1 TestGroup2 | Consent (Event 1 (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm  | e-Consent |

        But I should NOT see "TestGroup1"
        And I should NOT see "1-1"
        And I logout

    #FUNCTIONAL_REQUIREMENT
        Given I login to REDCap with the user "Test_User3"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        When I click on the link labeled "File Repository"
    ##ACTION Unable to access Role folder
    ##VERIFY See file uploaded by Test_User1

        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        | Time Uploaded    | Comments                |
            | Data Export Files           |                  |                         |
            | PDF Snapshot Archive        |                  |                         |
            | Recycle Bin                 |                  |                         |
            | TestGroup1_Folder           |                  |                         |
            | user_list_for_project_1.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |
            | testusers_bulkupload.csv    | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

        And I should NOT see "Role1_Folder"

    ##ACTION Download to top tier file imported by user 1 & user 2
        When I download a file by clicking on the link labeled "user_list_for_project_1.csv"
    #Note the underscores below - REDCap adds them automatically onto the filename when downloading
        Then I should see a downloaded file named "user_list_for_project_1.csv"
        When I download a file by clicking on the link labeled "testusers_bulkupload.csv"
        Then I should see a downloaded file named "testusers_bulkupload.csv"

  #Scenario: Access DAG folder

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Access DAG folder
        When I click on the link labeled "TestGroup1_Folder" in the File Repository table
        Then I should see the link labeled "testusers_bulk_upload.csv"

        When I download a file by clicking on the link labeled "testusers_bulk_upload.csv"
    ##VERIFY Download another users file in subfolder
        Then I should see a downloaded file named "testusers_bulk_upload.csv"

  #Scenario: Auto-archive file in DAG TestGroup1

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Auto-archive file in DAG TestGroup1
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive" in the File Repository table

    #Don't see consent created by testgroup2
        Then I should see a table header and rows containing the following values in the file repository table:
            | Record         | Survey                           | File Storage Time | Type      |
            | 1-1 TestGroup1 | Consent (Event 1 (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm  | e-Consent |

        But I should NOT see "TestGroup2"
        And I should NOT see "2-1"

        And I logout

  #Scenario: Download to top tier file

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Download to top tier file
        Given I login to REDCap with the user "Test_User4"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        When I click on the link labeled "File Repository"
    ##ACTION Unable to access Role folder
    ##VERIFY See file uploaded by Test_User1 & Test_User2

        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        | Time Uploaded    | Comments                |
            | Data Export Files           |                  |                         |
            | PDF Snapshot Archive        |                  |                         |
            | Recycle Bin                 |                  |                         |
            | TestGroup1_Folder           |                  |                         |
            | testusers_bulkupload.csv    | mm/dd/yyyy hh:mm | Uploaded by test_user1. |
            | user_list_for_project_1.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

        And I should NOT see "Role1_Folder"

    ##ACTION Download to top tier file imported by user 1 & user 2
        When I download a file by clicking on the link labeled "user_list_for_project_1.csv"
        Then I should see a downloaded file named "user_list_for_project_1.csv"
        When I download a file by clicking on the link labeled "testusers_bulkupload.csv"
        Then I should see a downloaded file named "testusers_bulkupload.csv"

  #Scenario: Access DAG folder

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Access DAG folder
        Given I click on the link labeled "TestGroup1_Folder" in the File Repository table
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                      | Time Uploaded    | Comments                |
            | testusers_bulk_upload.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

        When I download a file by clicking on the link labeled "testusers_bulk_upload.csv"
    ##VERIFY Download another users file in subfolder
        Then I should see a downloaded file named "testusers_bulk_upload.csv"

  #Scenario: Auto-archive access all file

    #FUNCTIONAL_REQUIREMENT
    ##ACTION Auto-archive access all file
        When I click on the link labeled "File Repository"
        And I click on the link labeled "PDF Snapshot Archive"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Record | Survey                           | File Storage Time | Type      |
            | 1-1    | Consent (Event 1 (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm  | e-Consent |
            | 2-1    | Consent (Event 1 (Arm 1: Arm 1)) | mm/dd/yyyy hh:mm  | e-Consent |

  Scenario: Delete folders - unable to delete with file in folder

    #FUNCTIONAL_REQUIREMENT
    ##ACTION C.3.26.500.100 Delete folders - unable to delete with file in folder
        When I click on the link labeled "File Repository"
        And I check the checkbox labeled "TestGroup1_Folder"
        And I click on the button labeled "Delete"
    ##VERIFY will not let you delete folder with file inside
        Then I should see a dialog containing the following text: "Alert"
        And I should see a dialog containing the following text: "Sorry, but folders can't be deleted this way. They must instead be deleted individually by clicking the X on the right-hand side of each folder."
        When I click on the button labeled "Close" in the dialog box
        Then I should see "TestGroup1_Folder"
        And I click on the Delete icon for the File Repository file named "TestGroup1_Folder"
        Then I should see a dialog containing the following text: "Cannot delete folder!"
        And I should see a dialog containing the following text: "Sorry, but the folder below cannot be deleted because it still has files in it."
        When I click on the button labeled "Close" in the dialog box
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        | Time Uploaded    | Comments                |
            | Data Export Files           |                  |                         |
            | PDF Snapshot Archive        |                  |                         |
            | Recycle Bin                 |                  |                         |
            | TestGroup1_Folder           |                  |                         |
            | testusers_bulkupload.csv    | mm/dd/yyyy hh:mm | Uploaded by test_user1. |
            | user list for project 1.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    ##ACTION Cancel Remove files from folder
        When I click on the link labeled "TestGroup1_Folder" in the File Repository table
        Then I should see "All Files/TestGroup1_Folder" in the File Repository breadcrumb
        And I should see a table header and rows containing the following values in the file repository table:
            | Name                      | Time Uploaded    | Comments                |
            | testusers_bulk_upload.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

        And I check the checkbox labeled "testusers_bulk_upload.csv"
        And I click on the button labeled "Delete"
        Then I should see a dialog containing the following text: "DELETE MULTIPLE FILES?"
        And I click on the button labeled "Cancel" in the dialog box
    ##VERIFY file still in folder
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                      | Time Uploaded    | Comments                |
            | testusers_bulk_upload.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    ##ACTION Delete/Remove files from folder
        When I check the checkbox labeled "testusers_bulk_upload.csv"
        And I click on the button labeled "Delete"
        Then I should see a dialog containing the following text: "DELETE MULTIPLE FILES?"
        And I click on the button labeled "Delete" in the dialog box
    ##VERIFY file deleted in folder
        Then I should see a dialog containing the following text: "SUCCESS!"
        And I click on the button labeled "Close" in the dialog box
        Then I should see a table row containing the following values in the file repository table:
            | No files or subfolders exist in this folder |

    ##ACTION C.3.26.500.100 Delete folders - Cancel deletion
        When I click on the link labeled "File Repository"
        And I click on the Delete icon for the File Repository file named "TestGroup1_Folder"

    ##VERIFY Cancel deletion
        Then I should see a dialog containing the following text: "Folder: TestGroup1_Folder"
        When I click on the button labeled "Cancel" in the dialog box
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        | Time Uploaded    | Comments                |
            | Data Export Files           |                  |                         |
            | PDF Snapshot Archive        |                  |                         |
            | Recycle Bin                 |                  |                         |
            | TestGroup1_Folder           |                  |                         |
            | testusers_bulkupload.csv    | mm/dd/yyyy hh:mm | Uploaded by test_user1. |
            | user list for project 1.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

    ##ACTION C.3.26.500.100 Delete folders
        And I click on the Delete icon for the File Repository file named "TestGroup1_Folder"
    ##VERIFY Folder deleted
        Then I should see a dialog containing the following text: "Folder: TestGroup1_Folder"
        When I click on the button labeled "Delete" in the dialog box
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name                        | Time Uploaded    | Comments                |
            | Data Export Files           |                  |                         |
            | PDF Snapshot Archive        |                  |                         |
            | Recycle Bin                 |                  |                         |
            | testusers_bulkupload.csv    | mm/dd/yyyy hh:mm | Uploaded by test_user1. |
            | user list for project 1.csv | mm/dd/yyyy hh:mm | Uploaded by test_user1. |

        And I should NOT see "TestGroup1_Folder"

   Scenario: C.3.26.1000.0100 Admin can create administrator-only folder in File Repository
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        And I click on the link labeled "File Repository"
        When I click on the button labeled "Create folder"
        And I enter "Admin_Folder" into the input field labeled "New folder name"
        And I check the checkbox labeled "Limit access to REDCap administrators only"
        And I click on the button labeled "Create folder" in the dialog box
        Then I should see "Admin_Folder"
        And I should see "Admin-Restricted" in the row labeled "Admin_Folder"

    Scenario: C.3.26.1000.0200 Non-admin users cannot see or access admin-only folders
        Given I logout
        And I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        And I click on the link labeled "File Repository"
        Then I should NOT see "Admin_Folder"
    
    Scenario: C.3.26.1000.0300 Admin-only overrides DAG and role limits
        And I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        And I click on the link labeled "File Repository"
        Then I should NOT see "Admin_Folder"
    
    Scenario: C.3.26.1000.0400 Nested folders inherit admin-only restriction
        Given I login to REDCap with the user "Test_Admin"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        And I click on the link labeled "File Repository"
        And I click on the link labeled "Admin_Folder"
        When I click on the button labeled "Create folder"
        And I enter "Nested_Admin_Only" into the input field labeled "New folder name"
        And I click on the button labeled "Create folder" in the dialog box
        Then I should see "All Files/Admin_Folder" in the File Repository breadcrumb
        Then I should see "Nested_Admin_Only"
        #Manual: Make sure it says "Admin-Restricted" in the "All Files/Admin_Folder" row.  Should we consider a way to verify this on Automation as well?
        And I should see "Admin-Restricted"
       
        Given I logout
        And I login to REDCap with the user "Test_User1"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "C.3.26.200.100"
        And I click on the link labeled "File Repository"
        Then I should NOT see "Admin_Folder"
        And I should NOT see "Nested_Admin_Only"
#END
