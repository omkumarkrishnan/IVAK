/*
  # Add Verification Methodology for DLR 4.2.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 4.2.1 (Virtual and blended career counselling and placement support services launched by SICB/Niyukti Kendra/SDD)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Approval Letter, Launch Letter and Activity Reports/Evaluation Studies
    - B. Desk Review of MIS Data/Official Documents
    - C. Telephonic Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 4.2.1
*/

-- Update methodology for DLR 4.2.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Approval Letter, Launch Letter and Activity Reports/Evaluation Studies

a. Verify the government letterhead, date and authorized signatures of Approval Letter.
b. Verify the guidelines for virtual and blended Career Counselling and Placement Support Services
c. Verify the government letterhead, date and authorized signatures of launch letter.
d. Confirm the Launch date of Virtual and blended Career Counselling and Placement Support Services
e. Verify the Activity Reports/Evaluation Studies on career counselling and placement support service in priority sectors on the following aspects:
   - Names of Service Providers/Partners
   - Modality of support (virtual, offline, blended)
   - Dates of support program
   - Number of woman beneficiaries covered
   - Number of Youth (18-35) beneficiaries covered

B. Desk Review of MIS Data/Official Documents

a. Mode of Counselling: Virtual/Offline/Blended
b. Mode of Placement Support: Virtual/Offline/Blended
c. Number of Beneficiaries:
d. Number of Women Beneficiaries:
e. Number of Youth (18-35) Beneficiaries

C. Telephonic Review

The IVA will verify 25 percent of the Beneficiaries using a random sample drawn from the data received from SDD using Telephonic interviews. Further, the IVA will verify the following points:

a. Sector
b. Mode of Counselling
c. Mode of Placement Support Services
d. Age (18-35)
e. Name of service provider
f. Name of agency placed with
g. Date of counselling service registration
h. Date of placement service registration
i. Date of placement
j. District of native residence
k. Location of placement
l. Fields of placement provided
m. Feedback about services'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 4.2.1');
