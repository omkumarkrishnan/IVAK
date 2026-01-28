/*
  # Add Verification Methodology for DLR 7.4.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 7.4.1 (1,140 community-based, mental health promotion, screening and outreach activities conducted)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review
    - B. MIS Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 7.4.1
*/

-- Update methodology for DLR 7.4.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review

The IVA will verify the following aspects based on the available Activity Reports/Evaluation Studies on community-based health camps:

a. Total Number of Health Camps
b. Number of Health Camps for Mental Health Promotion
c. Number of Mental Health Screenings
d. Number of Outreach activities
b. Dates of Health Camps
c. Number of Health Camps in each District
d. Number of Health Camps in Rural and Urban Areas
e. Number of Health Camps conducted for Mental Health Promotion
f. Number of Health Camps conducted for Mental Health Screenings
e. Number of Participants in Health Camps (gender and age disaggregated data)
f. Number of Participants who are part of Mental Health Screenings (gender and age disaggregated data)
g. Number of Referrals Made
h. List of Activities organized at Health Camps
i. List of Activities for Mental Health Promotion
j. List of Activities for Mental Health Screenings
k. Feedback Forms

B. MIS Review

The IVA will verify the following aspects available from the MIS Data on community based health camps with the existing reports:

a. Number of Health Camps
b. Dates of Health Camps
c. Number of Health Camps in each District
d. Number of Health Camps in Rural and Urban Areas
e. Number of Health Camps including Mental Health Promotion and Outreach Activities
f. Number of Health Camps conducted for Mental Health Screenings
e. Number of Participants in Health Camps (age and gender disaggregated data)
f. Number of Participants who are part of Mental Health Screenings (age and gender disaggregated data)
g. Number of Referrals Made'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 7.4.1');
