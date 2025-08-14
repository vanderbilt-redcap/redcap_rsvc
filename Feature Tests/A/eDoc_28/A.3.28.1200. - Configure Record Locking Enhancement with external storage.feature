Feature: A.3.28.1200. Control Center: The system shall support Record-level Locking Enhancement with Password verification to external storage solutions (i.e., Amazon S3, Google Cloud Storage, and Microsoft Azure Blob Storage).
  As a REDCap administrator
  I want to ensure one 6-digit per one session (trigger more than one record lock to test)
 
    Scenario: A.3.28.1200.0100. One 6-digit per one session (trigger more than one record lock to test) 
        #REDUNDANT - Tested in A.2.19.1000
    Scenario: A.3.28.1200.0200. New session requires 6-digit again (log out between two new record locking events - second event requires additional 6-digit pin) 
        #REDUNDANT - Tested in A.2.19.1000
    Scenario: A.3.28.1200.0300 Disabled 6-digit pin does not allow file upload to external storage.
        #REDUNDANT - Tested in A.2.19.1000

#END
