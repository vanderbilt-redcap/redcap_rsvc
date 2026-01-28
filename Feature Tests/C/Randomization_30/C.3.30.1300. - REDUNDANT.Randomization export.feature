Feature: User Interface: The system shall support inclusion of randomization values in data export.
  As a REDCap end user
  I want to see that Randomization is functioning as expected

Scenario: #REDUNDANT C.3.30.1300.0100. Export data with randomized values is accurate to allocation table

# The requirement C.3.30.1300.0100 - "Export data with randomized values is accurate to allocation table" - is already covered by previous testing efforts:

# C.3.30.1000.0200 verifies that allocation entries are assigned sequentially and correctly from the uploaded table.
# C.3.30.1100.0300 confirms that the randomized value saved to the record matches the allocation table.
# C.3.30.1100.0400 ensures that once assigned, randomized values cannot be modified by users, preserving data integrity.
# Since REDCap exports reflect the values stored in the underlying data table - and do not transform or recalculate them on export - confirming the correct value is saved is functionally equivalent to confirming the export value is correct.