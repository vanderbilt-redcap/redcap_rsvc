Feature: User Interface: The system shall allow users to export data from all records and data collection instruments in a project as a PDF document.

    As a REDCap end user
    I want to export the data for all records and all data collection instruments as a single PDF document
    So that I can review, share, or archive a complete copy of the project data in a printable format

    Scenario: B.5.21.0800 Export all records and all instruments as a PDF
        #SETUP
        Given I login to REDCap with the user "Test_Admin"
        And I create a new project named "B.5.21.0800" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

        #FUNCTIONAL_REQUIREMENT: The PDF export option is available for all records
        When I click on the link labeled "Data Exports, Reports, and Stats"
        And I click on the link labeled "Other Export Options"
        Then I should see "PDF of data collection instruments containing saved data (all records)"
        And I should see "The data for all records in this project may be downloaded in a single PDF file"
        And I should see "a copy of that downloaded PDF will be archived and stored in the File Repository"

        #FUNCTIONAL_REQUIREMENT: Download the PDF containing all records and all instruments
        When I click on the first link labeled "Download PDF with all data"
        Then I should see a downloaded file named "B5210800_yyyy-mm-dd_hhmm.pdf"
        #Manual: Close file

        #FUNCTIONAL_REQUIREMENT: Download the compact PDF containing only saved data
        When I click on the link labeled "Download PDF with all data (compact)"
        Then I should see a downloaded file named "B5210800_yyyy-mm-dd_hhmm.pdf"
        # #Manual: Close file

        #VERIFY: A copy of each PDF (standard and compact) is archived in the File Repository
        When I click on the link labeled "File Repository"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name              | Size    |
            | Data Export Files | 2 Files |

        When I click on the link labeled "Data Export Files"
        Then I should see a table header and rows containing the following values in the file repository table:
            | Name               | Time of Export    | Comments                                   |
            | pdf_allrecords_pid | mm/dd/yyyy hh:mm | Data export file created by test_admin on |
            | pdf_allrecords_pid | mm/dd/yyyy hh:mm | Data export file created by test_admin on |

        #VERIFY: The PDF exports are logged
        When I click on the link labeled "Logging"
        Then I should see a table header and rows containing the following values in the logging table:
            | Time / Date      | Username   | Action               | List of Data Changes OR Fields Exported                             |
            | mm/dd/yyyy hh:mm | test_admin | PDF Export with data | Download all data entry forms as PDF (all records) |
            | mm/dd/yyyy hh:mm | test_admin | PDF Export with data | Download all data entry forms as PDF (all records)   |
#END
