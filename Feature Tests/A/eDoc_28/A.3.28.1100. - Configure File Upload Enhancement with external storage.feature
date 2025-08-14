Feature: A.3.28.1100. Control Center: The system shall support File Upload field enhancement with Password verification to external storage solutions (i.e., Amazon S3, Google Cloud Storage, and Microsoft Azure Blob Storage).
  As a REDCap administrator
  I want to control whether non-e-Consent governed snapshots are stored externally
  So that storage behavior aligns with regulatory and institutional policies

  Scenario: A.3.28.1100.0100. One 6-digit per one session (trigger more than one 'File Upload' field enhancement to test) 
    #REDUNDANT - Tested in A.2.19.1000
  Scenario: A.3.28.1100.0200 New session requires 6-digit again (log out between two new 'File Upload' field enhancement events - second event requires additional 6-digit pin) 
    #REDUNDANT - Tested in A.2.19.1000
  Scenario: A.3.28.1100.0300 Disabled 6-digit pin does not allow file upload to external storage.
    #REDUNDANT - Tested in A.2.19.1000
#END
