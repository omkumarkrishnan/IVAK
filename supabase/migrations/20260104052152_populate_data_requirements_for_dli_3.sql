/*
  # Populate Data Requirements for DLI 3 DLRs

  1. Purpose
    - Populate the data_requirements field for DLI 3 DLRs
    - Based on the data requirements document screenshots for DLI 3-a and DLI 3-b
  
  2. DLRs Updated
    - DLR 3.0.1: Official document from IMF on inspection completion
    - DLR 3.0.2: Official document from IMF on IHCAE recognition
    - DLR 3.2.1: Gender-disaggregated baseline data of homestays
    - DLR 3.2.2: Training data for 10% of women-led homestays
    - DLR 3.3.1: Training data for 20% of women-led homestays (cumulative)
    - DLR 3.5.1: Digital marketing and payment tools adoption data for 60% of trained homestays
*/

-- DLR 3.0.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Official document from IMF conveying completion of inspection of IHCAE from T&CAD.'
)
WHERE code = 'DLR 3.0.1';

-- DLR 3.0.2
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Official document from IMF conveying recognition of IHCAE from T&CAD.'
)
WHERE code = 'DLR 3.0.2';

-- DLR 3.2.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Activity Reports/Evaluation Studies on gender-disaggregated baseline data of homestay owners.',
  'Data on homestays from the digital database on gender-disaggregated baseline data of homestay with the following details:',
  'Digital copies of Registration certificates of the Homestays from baseline data already registered with T& CAD or other departments.'
)
WHERE code = 'DLR 3.2.1';

-- DLR 3.2.2
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Data on number of women-led homestays that received training in business management and digital marketing skills from T&CAD.',
  'Percentage of women-led homestays and percentage of women-led homestay owners who received training on Business Management & Digital Marketing',
  'Digital database from Program MIS/ official documents on gender-disaggregated baseline data of homestay owners'
)
WHERE code = 'DLR 3.2.2';

-- DLR 3.3.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Data on number of women-led homestays that received training in business management and digital marketing skills',
  'Percentage of women-led homestays and percentage of women-led homestay owners who received training on Business Management & Digital Marketing',
  'Digital database from Program MIS/Official documents on gender-disaggregated baseline data of homestay owners'
)
WHERE code = 'DLR 3.3.1';

-- DLR 3.5.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Number of trained women-led homestays.',
  'Data on number of trained women-led homestays that adopted digital marketing.',
  'Database from Program MIS/ official documents on trained women-led homestays that adopted digital marketing with the following details:',
  'Data on number of trained women-led homestays that adopted digital payment tools.',
  'Database from Program MIS/ official documents on trained women-led homestays that adopted digital payment tools with the following details:'
)
WHERE code = 'DLR 3.5.1';