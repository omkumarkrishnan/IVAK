/*
  # Add Verification Methodology for DLR 7.5.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 7.5.1 (5 percent increase over baseline in footfall of adolescents and youth at PHCs and/or AFHCs for mental health management and/or de-addiction services)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review
    - B. MIS Review
    - C. Telephonic Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 7.5.1
*/

-- Update methodology for DLR 7.5.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review

The IVA will verify the following aspects based on the Activity Reports/Evaluation Studies on footfalls at PHCs and/or AFHCs for mental health management and/or de-addiction services:

a. Number of PHCs and/or AFHCs for mental health management in each district
b. Number of PHCs and/or AFHCs for de-addiction Services in each district
c. Number of PHCs and/or AFHCs for mental health management in rural and urban locations
d. Number of PHCs and/or AFHCs for de-addiction services in rural and urban Locations
e. Number of registrations in PHCs and/or AFHCs for mental health management in baseline period (gender disaggregated)
f. Number of registrations in PHCs and/or AFHCs for de-addiction services in baseline period (gender disaggregated)
g. Number of registrations in PHCs and/or AFHCs for mental health management in current period (gender disaggregated)
h. Number of registrations in PHCs and/or AFHCs for de-addiction services in current period (gender disaggregated)
i. Number of adolescents (10-18 yrs.) registrations in PHCs and/or AFHCs for mental health management in baseline period (gender disaggregated)
j. Number of adolescents (10-18 yrs.) registrations in PHCs and/or AFHCs for de-addiction services in baseline period
k. Number of adolescents (10-18 yrs.) registrations in PHCs and/or AFHCs for mental health management in current period
l. Number of adolescents (10-18 yrs.) registrations in PHCs and/or AFHCs for de-addiction services in current period
m. Number of youth (18-35 yrs.) registrations in PHCs and/or AFHCs for mental health management in baseline period
n. Number of youth (18-35 yrs.) registrations in PHCs and/or AFHCs for de-addiction services in baseline period
o. Number of youth (18-35 yrs.) registrations in PHCs and/or AFHCs for mental health management in current period
p. Number of youth (18-35 yrs.) registrations in PHCs and/or AFHCs for de-addiction services in current period
q. Type of Mental Health Problem Identified
r. Category of de-addictions prevalent

B. MIS Review

The IVA will verify the following aspects from the MIS data with the existing Activity Reports/Evaluation Studies on footfalls at PHCs and/or AFHCs for mental health management and/or de-addiction services:

a. Number of PHCs and/or AFHCs for mental health management services in each district
b. Number of PHCs and/or AFHCs for de-addiction Services in each district
c. Number of PHCs and/or AFHCs for mental health management services in rural and urban locations
d. Number of PHCs and/or AFHCs for de-addiction services in rural and urban Locations
e. Number of registrations in PHCs and/or AFHCs for mental health management services in baseline period (gender disaggregated)
f. Number of registrations in PHCs and/or AFHCs for de-addiction services in baseline period (gender disaggregated)
g. Number of registrations in PHCs and/or AFHCs for mental health management services in current period (gender disaggregated)
h. Number of registrations in PHCs and/or AFHCs for de-addiction services in current period (gender disaggregated)
i. Number of adolescents (10-18 yrs.) registrations in PHCs and/or AFHCs for mental health management in baseline period
j. Number of adolescents (10-18 yrs.) registrations in PHCs and/or AFHCs for de-addiction services in baseline period
k. Number of adolescents (10-18 yrs.) registrations in PHCs and/or AFHCs for mental health management in current period
l. Number of adolescents (10-18 yrs.) registrations in PHCs and/or AFHCs for de-addiction services in current period
m. Number of youth (18-35 yrs.) registrations in PHCs and/or AFHCs for mental health management in baseline period
n. Number of youth (18-35 yrs.) registrations in PHCs and/or AFHCs for de-addiction services in baseline period
o. Number of youth (18-35 yrs.) registrations in PHCs and/or AFHCs for mental health management in current period
p. Number of youth (18-35 yrs.) registrations in PHCs and/or AFHCs for de-addiction services in current period

Note: Guardians will be interviewed for Adolescent patients (10-17 years)

C. Telephonic Review

The IVA will verify 20 percent of the randomly selected beneficiaries for mental health management services and/or de-addiction services for mental health management and/or de-addiction services on the following aspects:

a. Name of Beneficiary
b. Age of Beneficiary
c. Gender of Beneficiary
d. Type of Service (Mental Health Management/De-addiction Services)
e. District
f. Location
g. Date of Registration
h. How did the beneficiary come to know of the service?
i. Number of Counselling Sessions Attended
j. Feedback about the services received (Satisfied/Neutral/Dissatisfied)
k. Number of Referrals Made
l. Availability of Staffs of Health Centre (Yes/No)
m. Was the visit beneficial? (Yes/No)

Note: 20 percent will comprise of both patients availing mental health and de-addiction services'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 7.5.1');
