/*
  # Add Verification Methodology for DLR 7.2.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 7.2.1 (850 schoolteachers trained in life skills education and in undertaking preliminary screening for mental health related concerns)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Activity Reports/Evaluation Studies on Training of Teachers
    - B. MIS Review
    - C. Telephonic Review
    - D. Field Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 7.2.1
*/

-- Update methodology for DLR 7.2.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Activity Reports/Evaluation Studies on Training of Teachers in Life Skills Education & in Undertaking Preliminary Screening for identifying Mental Health Related Concerns

The IVA will verify the following aspects based on the activity reports/evaluation studies on teachers trained in life skill education and in Undertaking Preliminary Screening for identifying Mental Health Related Concerns:

a. Number of Training Programs
b. Number of Teachers Trained (Gender Disaggregated Data)
c. Dates and schedule of each training Program
d. Number of Training Programs in Each District
e. Training Objective
f. Training Content
g. Training Materials Used
h. Duration of Training Programs
i. Details of the Training Partner
j. Trainer profiles
k. Review of feedback forms

B. MIS Review

The IVA will verify the following aspects available from the MIS Data with the existing evaluation studies/reports on teachers trained in life skill education and in undertaking preliminary screening for identifying mental health related concerns:

a. Number of Training Programs organized
b. Number of Teachers Trained (gender disaggregated data)
c. Dates and schedule of conduct of each training Program
d. Location of training
e. District
f. Duration of Training Programs
g. Details of the Training Partner

C. Telephonic Review

The IVA will verify the following aspects based on telephonic interviews of 20 percent random sample drawn from the list of teachers trained in life skill education and in undertaking preliminary screening for identifying mental health related concerns:

a. Name of Trainee
b. Gender
c. Age
d. Name of the training programme
e. Date of Training Programme
f. Location of Training Programme (Rural/Urban)
g. Address of Training School
h. Number of Sessions attended on Life Skills Education
i. Number of Sessions attended on Mental Health Related Concerns
j. Successful Completion
k. Certification Details
l. Feedback about the training Program (Satisfied/Neutral/Not Satisfied)
m. Interesting topics for future trainings
n. Number of Referrals from School (mental health screening)
o. Number of student referred to mental health centre
p. Number of session conducted for life skill education in schools by Trained Teachers

D. Field Review

The IVA will verify the following aspects based on a field review of a 20 percent random sample drawn from the list of teachers trained in life skill education and in undertaking preliminary screening for identifying mental health-related concerns:

a. Name of Trainee
b. Gender
c. Age
d. Name of the training program
e. Date of Training Program
f. Location of Training Program (Rural/Urban)
g. Address of Training School
h. Number of Sessions attended on Life Skills Education
i. Number of Sessions attended on Mental Health Related Concerns
j. Successful Completion
k. Certification Details
l. Feedback about the training Program (Satisfied/Neutral/Not Satisfied)
m. Interesting topics for future training
n. Number of Referrals from School (mental health screening)
o. Number of students referred to the mental health center
p. Number of sessions conducted for life skill education in schools by Trained Teachers'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 7.2.1');
