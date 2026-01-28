/*
  # Add Verification Methodology for DLR 7.5.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 7.5.2 (70 percent of adolescents and youth participating in life skills education in schools and in community-based outreach activities are screened for mental health-related concerns)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Activity Reports/Evaluation Studies (Life Skills Education)
    - B. Desk Review of Activity Reports/Evaluation Studies (Community-based Outreach Activities)
    - C. Field Review (Adolescent and Youth participating in Life Skills Education & screened for mental health related concerns)
    - D. Structured Interviews of School Teachers
    - E. Field Review of adolescents and youths participating in community-based outreach activities
    - F. Structured Interview of Health Professionals
    
  3. Changes
    - Update methodology field for all verifications under DLR 7.5.2
*/

-- Update methodology for DLR 7.5.2 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Activity Reports/Evaluation Studies (Life Skills Education)

The IVA will verify the following aspects based on the Activity Reports/Evaluation Studies on adolescents and youths participating in life skills education in schools and screened for mental health related concerns:

a. Number of adolescents (10-17 years) participating in life skills education in schools (gender disaggregated)
b. Number of adolescents (10-17 years) screened for mental health related concerns among the adolescent participants in life skills education in schools (gender disaggregated)
c. Number of youths (18-35 years) participating in life skills education in schools (gender disaggregated)
d. Number of youths (18-35 years) screened for mental health related concerns among the youth participants in life skills education in schools (gender disaggregated)
e. District-wise percent of adolescents (10-17 years) participating in life skills education in schools screened for mental health related concerns (gender disaggregated)
f. District-wise Percent of youth (18-35 years) participating in life skills education in schools screened for mental health related concerns (gender disaggregated)

B. Desk Review of Activity Reports/Evaluation Studies (Community-based Outreach Activities)

The IVA will verify the following aspects based on the Activity Reports/Evaluation Studies on adolescents and youths participating in community-based outreach activities and screened for mental health related concerns:

a. District-wise number of adolescents (10-17 years) participating in community-based outreach activities (gender disaggregated)
b. District-wise number of adolescents (10-17 years) screened for mental health related concerns among the adolescent participants in community-based outreach activities (gender disaggregated)
c. District-wise number of youths (18-35 years) participating in community-based outreach activities in schools (gender disaggregated)
d. District-wise number of youths (18-35 years) screened for mental health related concerns among the youth participants in community-based outreach activities (gender disaggregated)
e. Percent of youth (18-35 years) participating in community-based outreach activities screened for mental health related concerns (gender disaggregated)
f. District-wise percent of adolescents (10-17 years) participating in community-based outreach activities screened for mental health related concerns (gender disaggregated)
g. District-wise Percent of youth (18-35 years) participating in community-based outreach activities screened for mental health related concerns (gender disaggregated)

C. Field Review (Adolescent and Youth participating in Life Skills Education & screened for mental health related concerns)

The IVA will verify the following aspects based on field review of 20 percent beneficiaries selected through an appropriately designed stratified random sampling from the list of beneficiaries participating in life skills education in schools and screened for mental health related concerns:

a. Name of Beneficiary
b. Age
c. Gender
d. District
e. Location of School (Rural/Urban)
f. Screened for Mental Health Related Concerns
g. Feedback on the service received (Satisfied/Neutral/Dissatisfied)
h. Number of Teachers in School
i. Number of Referrals Made

Note: For minors related to mental health concerns, parents will be interviewed.

D. Structured Interviews of School Teachers

The IVA will further verify the following aspects from teachers of the selected beneficiaries'' schools:

a. Number of Screenings for Mental Health Related Concerns
b. Details of trainings provided for teachers
c. Feedback for the trainings provided (Satisfied/Neutral/Dissatisfied)
d. Number of Sessions Conducted for Mental Health Related Concerns

E. Field Review of adolescents and youths participating in community-based outreach activities

The IVA will verify the following aspects based on a field review of 20 percent randomly selected beneficiaries participating in community-based outreach activities and screened for mental health-related concerns:

a. Name of Beneficiary
b. Age
c. Gender
d. District
e. Location of Activity (Rural/Urban)
f. Screened for Mental Health Related Concerns
g. Feedback on the service received (Satisfied/Neutral/Dissatisfied)
h. Number of Health Professional Available
i. Number of Referrals Made

F. Structured Interview of Health Professionals

The IVA will further verify the following aspects from health professionals of the selected beneficiaries'' schools:

a. Number of Screenings for Mental Health Related Concerns
b. Details of Training provided for health professionals
c. Feedback for the trainings provided (Satisfied/Neutral/Dissatisfied)
d. Number of Sessions Conducted'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 7.5.2');
