/*
  # Populate Data Requirements for DLI 4 DLRs

  1. Purpose
    - Populate the data_requirements field for DLI 4 DLRs
    - Based on the data requirements document screenshot for DLI 4
  
  2. DLRs Updated
    - DLR 4.1.1: Training Providers/Partners empaneled by SICB/SDD
    - DLR 4.2.1: Career counselling and placement support services launched
    - DLR 4.3.1: 3 new NSQF compliant training programs conducted
    - DLR 4.4.1: 6 new NSQF compliant training programs (cumulative)
    - DLR 4.5.1: Placement rate for trainees at 50 percent
*/

-- DLR 4.1.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'GO or Circular or Memorandum containing sector-wise lists of empaneled Training Providers/Partners and the respective accreditation certificates issued based on NSQF.'
)
WHERE code = 'DLR 4.1.1';

-- DLR 4.2.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Details of Approval Letter, Launch Letter and Activity Reports/Evaluation Studies',
  'Details of Career Counselling and Placement Support Services',
  'Beneficiary Details for Career Counselling and Placement Support Services'
)
WHERE code = 'DLR 4.2.1';

-- DLR 4.3.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Activity Reports/Evaluation Studies on Skill Development Training and Assessment',
  'Details from the MIS Data/ official documents on skill development training program',
  'Digital copies of the certificates for all the trainees.'
)
WHERE code = 'DLR 4.3.1';

-- DLR 4.4.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Activity Reports/Evaluation Studies including the specified data on Skill Development Training and Assessment',
  'MIS Data/ official documents on skill development training program',
  'Digital copies of the certificates for all the trainees.'
)
WHERE code = 'DLR 4.4.1';

-- DLR 4.5.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Activity Reports/Evaluation Studies',
  'MIS Data/Official documents on placement'
)
WHERE code = 'DLR 4.5.1';