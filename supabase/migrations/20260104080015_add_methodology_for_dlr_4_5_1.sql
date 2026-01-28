/*
  # Add Verification Methodology for DLR 4.5.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 4.5.1 (Placement rate for trainees in priority sectors has reached 50 percent)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Activity Reports/Evaluation Studies on Placement
    - B. Telephonic Review of Trainees
    - C. Telephonic Interviews of Employers
    
  3. Changes
    - Update methodology field for all verifications under DLR 4.5.1
*/

-- Update methodology for DLR 4.5.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Activity Reports/Evaluation Studies on Placement

The IVA will confirm the following aspects based on the available Activity Reports/Evaluation Studies on placement details provided by SDD:

a. Name of Training Program
b. Sector
c. Start Date of Training Program
d. End Date of Training Program
e. Compliance with NSQF (Yes/No)
f. Assessment done (Yes/No)
g. Number of Trainees
h. Number of Women Trainees
i. Number of Youth (18-35) Trainees
j. Number of Employed
k. Number of Women Employed
l. Number of Youth (18-35) Employed

B. Telephonic Review of Trainees

The IVA will select 20 percent Male and Female Trainees reported to have been placed using a stratified random sample selected from the list of trainees. Using Telephonic Interviews, the IVA verify the following aspects:

a. Nature of Employment
b. Field of Employment
c. Joining Date of Employment
d. Location
e. Name of Employer
f. Level of Satisfaction (Quality of learning, Quality of peer group and Employment outcome)
g. Present Address
h. Training Completion Date
i. Remuneration
j. Ease of Recruitment

C. Telephonic Interviews of Employers

The IVA will verify with employers who have recruited the trainees from the selected sample of Trainees using Telephonic Interviews. Verification will include the following aspects:

a. Name of the Trainee-Employee
b. Ease of Recruitment
c. Satisfaction with Trainee-Employee Performance'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 4.5.1');
