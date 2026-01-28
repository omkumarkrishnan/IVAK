/*
  # Populate Data Requirements for DLI 7 DLRs

  1. Purpose
    - Populate the data_requirements field for DLI 7 DLRs
    - Based on the data requirements document screenshots for DLI 7
  
  2. DLRs Updated
    - DLR 7.0.1: Mobile App on mental health awareness and service delivery linkages
    - DLR 7.2.1: 850 schoolteachers trained in life skills education
    - DLR 7.3.1: 665 health workers and counsellors upskilled on mental health
    - DLR 7.3.2: Update to mobile app on mental health
    - DLR 7.4.1: 1,140 community-based mental health activities conducted
    - DLR 7.5.1: 5 percent increase in adolescent footfall at PHCs/AFHCs
    - DLR 7.5.2: 70 percent of adolescents screened for mental health
*/

-- DLR 7.0.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Details from H&FWD on the Mobile App on mental health',
  'Approval from H&FWD on go-live of mobile app on mental health.'
)
WHERE code = 'DLR 7.0.1';

-- DLR 7.2.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Data on number of teachers trained in life skills education and in undertaking preliminary screening for identifying mental health related concerns.',
  'Evaluation studies/reports on teachers trained in life skill education and in undertaking Preliminary Screening for identifying Mental Health Related Concerns.',
  'MIS data on training programs for teachers trained in life skill education and in undertaking preliminary screening for identifying mental health related concerns',
  'Data on teachers trained in life skill education and in undertaking preliminary screening for identifying mental health related concerns based on MIS data',
  'Digital copies of the certificates received by teachers who have successfully completed training in life skill education and in undertaking preliminary screening for identifying mental health related concerns.'
)
WHERE code = 'DLR 7.2.1';

-- DLR 7.3.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Evaluation studies/ reports on health workers and counsellors upskilled on mental health.',
  'Data from program MIS on training programs for health workers and counsellors upskilled on mental health',
  'Data on health workers and counsellors upskilled on mental health',
  'Digital copies of the certificates received by health workers and counsellors upskilled on mental health'
)
WHERE code = 'DLR 7.3.1';

-- DLR 7.3.2
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Approval letter on updating of Mobile App containing the list of updated features.',
  'Data on number of app users using self-screening services.'
)
WHERE code = 'DLR 7.3.2';

-- DLR 7.4.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Activity Reports/Evaluation Studies on community based health camps.',
  'Data from MIS data on community based health camps'
)
WHERE code = 'DLR 7.4.1';

-- DLR 7.5.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Activity Reports/Evaluation Studies evaluation studies/reports on footfalls at PHCs and/or AFHCs for mental health management and/or de-addiction services.',
  'MIS data on footfalls at PHCs and/or AFHCs for mental health management and/or de-addiction services',
  'Beneficiary details from MIS data on footfalls at PHCs and/or AFHCs for mental health management and/or de-addiction services'
)
WHERE code = 'DLR 7.5.1';

-- DLR 7.5.2
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Evaluation studies/reports on adolescents and youths participating in life skills education in schools and screened for mental health related concerns (age and gender disaggregated data)',
  'Evaluation studies/reports on adolescents and youths participating in community-based outreach activities and screened for mental health related concerns (age and gender disaggregated data).',
  'Beneficiary details from data on adolescents and youths participating in life skills education in schools and screened for mental health related concerns',
  'Beneficiary details from data on adolescents and youths participating in community-based outreach activities and screened for mental health related concerns'
)
WHERE code = 'DLR 7.5.2';