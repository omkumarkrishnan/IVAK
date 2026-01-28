/*
  # Add Verification Methodology for DLR 5.1.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 5.1.1 (District-level IEIAPs that reflect investment priorities and financial allocations on economic inclusion in non-farm sectors, approved by PGC)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review (IEIAP documents and GO or Circular or Memorandum)
    - B. Desk review the GO or Circular or Memorandum
    - C. Structured interviews
    
  3. Changes
    - Update methodology field for all verifications under DLR 5.1.1
*/

-- Update methodology for DLR 5.1.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review (IEIAP documents and GO or Circular or Memorandum)

The IVA will desk review the IEIAP documents for checking the following aspects:

a. Verify the government letterhead and authorized signatures on each document.
b. Verify the inclusion of different non-farm priority sectors under IEIAP.
c. Confirm that the documents are dated appropriately.
d. Verify that IEIAP documents cover the following aspects:
   (i) Profile of the district
   (ii) Profile of priority rural non-farm sectors
   (iii) Situation Analysis of Employment and Entrepreneurship of women and youth
   (iv) Strategic four-year plan for employment and entrepreneurship Citizen engagement
   (v) Annual work plan
e. Verify that IEIAP documents include the details about the following intervention areas:
   (i) Comprehensive business support to SHG and youth enterprises
   (ii) Rural tourism
   (iii) Eco tourism
f. Confirm that the documents regarding Economic Inclusion Plan in Non-Farm Sector.
g. Verify the scope and objectives.
h. Verify the Roles and responsibilities at State and district levels in IEIAP.
i. Verify the Financial commitments, resource allocation details and deadlines.
j. Verify the non-financial commitments and deadlines.

B. Desk Review of GO or Circular or Memorandum

The IVA will desk review the GO or Circular or Memorandum for checking the following aspects:

a. Approval by Program Governing Committee (PGC)
b. Verify the government letterhead and authorized signatures on each document.

C. Structured Interviews

Structured interviews will be conducted with the district-level administrators and frontline officials from priority departments (and other stakeholders as relevant). A sample of two officials in each district related to IEIAP will be interviewed. The following details will be confirmed during the structured interview:

a. Verify the designation of the concerned official.
b. Verify the scope and objectives of IEIAPs.
c. Verify the roles and responsibilities of district-level administrators and frontline officials in IEIAP.
d. Verify whether views of district administrators and frontline officials from priority departments are included in execution of IEIAPs.
e. Verify the financial commitments, resource allocation details and deadlines.
f. Verify the non-financial commitments and deadlines.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 5.1.1');
