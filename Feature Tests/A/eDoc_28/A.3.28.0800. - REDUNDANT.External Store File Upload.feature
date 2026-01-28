Feature: A.3.28.0800. Control Center: The system shall store files uploaded via 'File Upload' fields in the configured file storage location (local or external) based on the Control Center settings.

  As a REDCap site administrator
  I want to confirm that uploaded files from 'File Upload' fields are correctly stored in the configured external storage
  So that I can ensure compliance with my institution’s storage policies

  Scenario: A.3.28.0800.0100. Verify external storage location for File Upload field
    #Redundant; verified in A.3.28.1100.

    #CONTEXT
    # This verification must be performed manually by the local site administrator.
    # The test project should include at least one 'File Upload' field on a data entry form.

    #Given I have configured external file storage in the Control Center (Azure, S3, etc.)
    #And I have completed Scenario A.3.28.0300.200 (enable File Upload fields)

    # When I add a new record and upload a file using a File Upload field
    #Then I confirm the uploaded file exists in the expected external storage location