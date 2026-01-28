/*
  # Add Verification Methodology for DLR 8.3.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 8.3.2 (Migration support services launched to enable migration for jobs in national and international locations)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Approval Letter of Migration Support Services guideline and its launch
    - B. Telephonic Review
    - C. Field Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 8.3.2
*/

-- Update methodology for DLR 8.3.2 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Approval Letter of Migration Support Services guideline and its launch

a. Verify the government letterhead and authorized signatures on approval letter.
b. Verify date of Approval letter
c. Verify the government letterhead and authorized signatures on Launch letter.
d. Verify date of Launch letter
e. Verify the Launch date of Migrations Support Services.

B. Telephonic Review

The IVA will verify the following aspect on 25 percent of the Skilled Care givers using a random sample drawn from the list of skilled caregivers using telephonic interviews.

a. Name of the Caregiver
b. Age of the Caregiver
c. Gender of the Caregiver
d. Support received for National Level Migration
e. Support received for international level Migration
f. Counselling Services received
g. Logistics assistance received

C. Field Review

The IVA will verify the following based on field review of 10 percent of the randomly selected Caregivers who have received support on Migration Services:

a. Name of the Caregiver
b. Age of the Caregiver
c. Gender of the Caregiver
d. Support received for National Level Migration
e. Support received for international level Migration
f. Counselling Services received
g. Logistics assistance received'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 8.3.2');
