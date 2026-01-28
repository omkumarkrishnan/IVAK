/*
  # Add Verification Methodology for DLR 8.3.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 8.3.1 (200 trainees receive training and certification in childcare/geriatric care, or reproductive health, or early childhood development by PDD in coordination with SDD, H&FWD, and WCDD)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review
    - B. Telephonic Review
    - C. Field Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 8.3.1
*/

-- Update methodology for DLR 8.3.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review

The IVA will verify the following aspects from the available Activity Reports/Evaluation Studies on Orientation programs for Quality Caregiving:

a. Program Calendar of Orientation Modules for Child Care, Geriatric Care, Reproductive Health and Early Childhood Development.
b. Location of the Training Program
c. Number of Participants
d. Number of Women Participants

B. Telephonic Review

The IVA will verify the following aspects based on telephonic interviews of 20 percent of the randomly selected participants who have participated in the orientation programs on Caregiving:

a. Name of participant
b. Gender of Participant
c. Name of the Orientation Program attended
d. Type of training program (Child Care, Geriatric Care, Reproductive Health, Early Childhood Development)
e. Date of certification
f. Certificate No

C. Field Review

The IVA will verify the following based on a field review of 10 percent of the randomly selected participants who have participated in the orientation programs on Caregiving:

a. Name of participant
b. Gender of Participant
c. Name of the Orientation Program attended
d. Type of training program (Child Care, Geriatric Care, Reproductive Health, Early Childhood Development)
e. Date of certification
f. Certificate No'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 8.3.1');
