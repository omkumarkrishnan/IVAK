/*
  # Add Verification Methodology for DLR 6.2.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 6.2.2 (Secretary IT and PGC have approved the State Data Policy)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Approval Letter
    
  3. Changes
    - Update methodology field for all verifications under DLR 6.2.2
*/

-- Update methodology for DLR 6.2.2 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Approval Letter

The IVA will verify the approval letter for SDP on the following aspects:

a. Request ITD to provide approval letter for SDP
b. Verify the approval letter is in government letterhead
c. Verify the date of the approval letter
d. Verify the authorized signature of Secretary IT on Approval Letter
e. Verify the authorized signature of Program Governing Council (PGC) on the approval letter'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 6.2.2');
