/*
  # Populate Data Requirements for DLI 8 DLRs

  1. Purpose
    - Populate the data_requirements field for DLI 8 DLRs
    - Based on the data requirements document screenshots for DLI 8
  
  2. DLRs Updated
    - DLR 8.0.1: Expert Group meeting organized by PDD
    - DLR 8.1.1: 3 Partnerships established on childcare, reproductive health, and geriatric care
    - DLR 8.2.1: Integrated case management system established for vulnerable women
    - DLR 8.2.2: Violence prevention and safety at workplace orientation launched
    - DLR 8.3.1: 200 trainees receive training and certification
    - DLR 8.3.2: Migration support services launched
    - DLR 8.4.1: 400 trainees (cumulative) receive training and certification
    - DLR 8.5.1: 20 percent of trainees placed in national or international locations
*/

-- DLR 8.0.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Notification for setting up the Expert Group.',
  'Expert Group meeting report'
)
WHERE code = 'DLR 8.0.1';

-- DLR 8.1.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Official documents (contract or MOU or partnership agreement or equivalent) of partnerships with at least three agencies (sector skills councils, specialized training institutions, etc.) on quality caregiving for childcare'
)
WHERE code = 'DLR 8.1.1';

-- DLR 8.2.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Demonstration of the integrated case management system (ICMS) including (i) online access, (ii) coverage of ICMS, and (iii) systems for ensuring compliance with data privacy and security regulations.',
  'Approval letter received for the go-live of ICMS',
  'Contract document with FRS & SRS prepared for ICMS',
  'Security Audit Certificate for ICMS',
  'Report on Training of GoS Staff on ICMS operations.'
)
WHERE code = 'DLR 8.2.1';

-- DLR 8.2.2
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Approval letter and Launch Letter of the orientation programs on of Violence Prevention and Safety at Workplace orientation module',
  'Details on Orientation programs modules of for Violence Prevention and Safety at Workplace from the available reports'
)
WHERE code = 'DLR 8.2.2';

-- DLR 8.3.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Activity Reports/Evaluation Studies',
  'Details of participants of Orientation programs in Quality Care Giving',
  'Digital copies of the training completion certificates for participants who attended the training programs on Quality Care Giving.'
)
WHERE code = 'DLR 8.3.1';

-- DLR 8.3.2
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Approval letter and Launch Letter of Migration Support Services guideline',
  'Data from Program MIS/Official documents on migration support services for skilled caregivers'
)
WHERE code = 'DLR 8.3.2';

-- DLR 8.4.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Activity Reports/Evaluation Studies',
  'Details of participants of orientation programs in Quality Care Giving',
  'Digital copies of the training completion certificates of participants who attended the training programs on Quality Care Giving'
)
WHERE code = 'DLR 8.4.1';

-- DLR 8.5.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Details of the trained and certified individuals who secured employment (wage employment or self-employment) in national or international locations from the Activity Reports/ Evaluation Studies.',
  'MIS Data on trained and certified individuals'
)
WHERE code = 'DLR 8.5.1';