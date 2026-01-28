/*
  # Add Verification Methodology for DLR 5.1.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 5.1.2 (District-level IEIAPs are available in the public domain for 6 districts)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Online Review of IEIAP from Website
    
  3. Changes
    - Update methodology field for all verifications under DLR 5.1.2
*/

-- Update methodology for DLR 5.1.2 verifications
UPDATE verifications
SET methodology = 'A. Online Review of IEIAP from Website

a. Verify the public accessibility of the Website address provided for IEIAP.
b. Check the listing of all details of IEIAP, including key intervention areas, feasibility analysis, and impact potential.
c. Check of adequacy the number of GoS officials trained at State, district and village levels to maintain the IEIAP website, including upkeep of static details and updation of dynamic details.
d. Verify the designations of the GoS officials associated with Website maintenance.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 5.1.2');
