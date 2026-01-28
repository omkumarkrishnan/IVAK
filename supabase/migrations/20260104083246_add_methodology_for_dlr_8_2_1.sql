/*
  # Add Verification Methodology for DLR 8.2.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 8.2.1 (Integrated case management system established for vulnerable women beneficiaries of WCDD)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Testing the functionality of ICMS
    - B. Verification of Go Live Approval
    
  3. Changes
    - Update methodology field for all verifications under DLR 8.2.1
*/

-- Update methodology for DLR 8.2.1 verifications
UPDATE verifications
SET methodology = 'A. Testing the functionality of ICMS:

a. Verify the Website address provided for ICMS portal
b. Validate the authentication procedures for accessing the ICMS

B. Verification of Go Live Approval:

a. Check the listing of ICMS portal address in STQC of GoI website
b. Confirm specifications required for compliance of FRS & SRS with ICMS using Contract Document
c. Verify the Security Audit Certificate
d. Verify report on training of GoS staff on ICMS operations
e. Verify for adequacy the number of GoS officials trained to operate the ICMS

Reference: https://www.stqc.gov.in/'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 8.2.1');
