/*
  # Add Verification Methodology for DLR 8.2.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 8.2.2 (Violence prevention and safety at workplace orientation launched for women entrepreneurs and women-led homestays by WCDD)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of the Approval Letter & Launch Letter of Violence Prevention and Safety at Workplace orientation module
    - B. Desk Review of the Activity Reports/Evaluation Studies on orientation programs of Violence Prevention and Safety at the Workplace
    
  3. Changes
    - Update methodology field for all verifications under DLR 8.2.2
*/

-- Update methodology for DLR 8.2.2 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of the Approval Letter & Launch Letter of Violence Prevention and Safety at Workplace orientation module

The IVA will verify the following aspects from the Approval Letter & Launch Letter:

a. Verify the government letterhead and authorized signatures on the approval letter.
b. Verify date of the Approval letter
c. Verify the government letterhead and authorized signatures on the Launch letter.
d. Verify date of the Launch letter
e. Verify the Launch date of the Workshop Orientation program modules.
f. Verify the contents of the Violence Prevention and Safety at Workplace orientation module.
g. Confirm the details on topics, methodology, etc.

B. Desk Review of the Activity Reports/Evaluation Studies on orientation programs of Violence Prevention and Safety at the Workplace

The IVA will verify the following aspects from the available Activity Reports/Evaluation Studies on Orientation programs modules for Violence Prevention and Safety at the Workplace:

a. Calendar of Orientation Program Modules of Violence Prevention and Safety at Workplace
b. Location of Program
c. Number of Participants
d. Number of Women participants'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 8.2.2');
