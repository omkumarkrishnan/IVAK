/*
  # Add Verification Methodology for DLR 4.4.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 4.4.1 (Six new NSQF compliant training programs conducted by SICB/SDD in priority sectors - cumulative)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification
    - B. Telephonic Review of Trainees
    - C. Telephonic Review of Certified Trainees
    
  3. Changes
    - Update methodology field for all verifications under DLR 4.4.1
*/

-- Update methodology for DLR 4.4.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification

The IVA will confirm the following aspects on the skill development training programs available from the Activity Reports/Evaluation Studies provided by SDD:

a. Title of training program
b. Sector
c. Name of Training Providers/Partners
d. Compliance with NSQF (Yes/No)
e. Assessment done (Yes/No)
f. Start Date of Training Program
g. End Date of Training Program
h. Number of Beneficiaries
i. Number of Women Beneficiaries
j. Number of Youth (18-35) Beneficiaries

B. Telephonic Review of Trainees

The IVA will confirm the following details based on a 25 percent random sample of trainees who have participated in the skill development training program.

a. Name Registered
b. Gender
c. Age
d. Mob No.
e. Sector
f. Assessment done
g. Type of Assessment
h. Successful Program Completion
i. Start Date of Training Program
j. Education level
k. District
l. Title of training program completed
m. Name of training provider where training was taken
n. Prior occupation/employment (prior to training program participation)
o. Current occupation/employment

C. Telephonic Review of Certified Trainees

The IVA will verify the following aspects for 25 percent randomly selected Certified trainees through Telephonic interviews.

a. Name of Trainee
b. Gender
c. Age
d. Name of training program attended
e. Name of training provider
f. Dates of training program
g. Sector
h. Type of Assessment'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 4.4.1');
