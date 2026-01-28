Feature: A.3.28.0900. The system shall store files uploaded via the Send-It module in the configured file storage location (local or external) based on the Control Center settings.

  As a REDCap site administrator
  I want to confirm that files sent using Send-It are stored externally if configured
  So that I can verify secure storage for shared files

  Scenario: A.3.28.0900.0100. Verify the external storage location for Send-It file
    #Redundant; verified in A.3.28.0400.
    
    #CONTEXT
    # This verification must be performed manually by the local site administrator.
    # Send-It uploads are managed via the Send-It module and may include both project and non-project files.

    #Given I have configured external storage and enabled Send-It in the Control Center
    #And I have completed Scenario A.3.28.0400.200 (Send-It with size limits)

    #When I use Send-It to upload and share a file
    #Then I confirm the uploaded file exists in the expected external storage location