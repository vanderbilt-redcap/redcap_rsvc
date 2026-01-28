Feature: A.3.28.1000. The system shall store general file attachments (e.g., Descriptive fields, Data Resolution Workflow) in the configured file storage location (local or external) based on the Control Center settings.

  As a REDCap site administrator
  I want to confirm that general attachments uploaded via Descriptive fields or DRW are stored externally
  So that I can validate audit-readiness across all upload methods

  Scenario: A.3.28.1000.0100. Verify external storage for general file attachments
    #Redundant tested in A.3.28.1200.

    #CONTEXT
    # This verification must be performed manually by the local site administrator.
    # Must include a project with Descriptive fields that allow file upload or open queries in DRW.

    #Given I have configured external storage and enabled general file attachments in the Control Center
    #And I have completed Scenario A.3.28.0500.200 (Enable general file attachments)

    #When I upload a file via a Descriptive field or DRW
    #Then I confirm the uploaded file exists in the expected external storage location