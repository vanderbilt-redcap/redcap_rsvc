Feature: C.2.19.1300. User Interface: The system shall allow a user to provide their 6-digit PIN once per session for Record-locking processes
    I want to ensure one 6-digit per one session (trigger more than one record lock to test)

    Scenario: C.2.19.1300.0100. One 6-digit per one session (trigger more than one record lock to test) 
#Redundant; verified in A.3.28.1200.        
    Scenario: C.2.19.1300.0200. New session requires 6-digit again (log out between two new record locking events - second event requires additional 6-digit pin)   
    #Redundant; verified in A.3.28.1200.
#END
