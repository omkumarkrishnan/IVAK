/*
  # Add Verification Methodology for DLR 7.3.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 7.3.1 (665 health workers and counsellors upskilled on mental health – including focus on suicide prevention, substance abuse management)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Activity Reports/Evaluation Studies on Upskilling on Mental Health
    - B. Desk Review of MIS Data/Official documents
    - C. Telephonic Review
    - D. Desk Review of Certification
    
  3. Changes
    - Update methodology field for all verifications under DLR 7.3.1
*/

-- Update methodology for DLR 7.3.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Activity Reports/Evaluation Studies on Upskilling on Mental Health

The IVA will verify the following aspects based on the Activity Reports/Evaluation Studies on health workers and counsellors upskilled on mental health:

a. Number of Counselors trained
b. Number of Health workers trained
c. Number of Training Programs organized
d. Dates and schedule of conduct of each training Program
e. Training content and objective
f. Training materials used
g. Duration of Training Programs
h. Details of the Training Partner
i. Review of feedback forms

B. Desk Review of MIS Data/Official documents

The IVA will verify the following aspects available from the MIS Data on training programs with the existing Activity Reports/Evaluation Studies on training programs for health workers and counsellors upskilled on mental health:

a. Number of Training Programs organized
b. Number of Health Workers Trained (gender disaggregated data)
c. Number of Counsellors Trained (gender disaggregated data)
d. Dates and schedule of conduct of each training Program
e. Location of training
f. District
g. Duration of Training Programs
h. Details of the Training Partner

C. Telephonic Review

The IVA will verify the following aspects based telephonic interviews of 20 percent random sample drawn from the list of health workers and counsellors upskilled on mental health:

a. Name of Trainee
b. Gender
c. Age
d. Name of the training program
e. Number of Sessions conducted
f. Date of Training Program
g. Location of Training Program (Rural/Urban)
h. Address of Training School
i. Number of Sessions attended on Suicide Prevention
j. Number of Sessions attended on Substance Abuse Management
k. Number of Sessions attended on Other Topics
l. Details of Other Topics
m. Feedback about the training Program (Satisfied/Neutral/Not Satisfied)
n. Interesting topics for future trainings

D. Desk Review of Certification

The IVA will verify the following aspects from the Digital Certificates of Health Workers & Counsellors:

a. Name of the Trainee
b. Certificate Number
c. Successful Completion
d. Certification Details'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 7.3.1');
