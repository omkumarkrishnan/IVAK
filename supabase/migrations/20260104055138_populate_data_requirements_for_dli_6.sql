/*
  # Populate Data Requirements for DLI 6 DLRs

  1. Purpose
    - Populate the data_requirements field for DLI 6 DLRs
    - Based on the data requirements document screenshot for DLI 6
  
  2. DLRs Updated
    - DLR 6.1.1: Feasibility study conducted by ITD for establishing connectivity
    - DLR 6.2.1: ITD has prepared the State Data Policy and compliance plan
    - DLR 6.2.2: Secretary IT and PGC have approved the State Data Policy
    - DLR 6.3.1: Internet connectivity pilot completed by ITD in one district
    - DLR 6.5.1: Study on linkages between digital connectivity and economic activity
*/

-- DLR 6.1.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Feasibility study report for connectivity across the state.'
)
WHERE code = 'DLR 6.1.1';

-- DLR 6.2.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Document on State Data Policy and compliance plan from ITD.'
)
WHERE code = 'DLR 6.2.1';

-- DLR 6.2.2
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Document on approval of State Data Policy by the Secretary, IT and PGC.'
)
WHERE code = 'DLR 6.2.2';

-- DLR 6.3.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Report on completion of internet connectivity pilot in one district other than Soreng based on the feasibility study.',
  'Internet connectivity details for the concerned districts',
  'Data on users accessing internet in the concerned district from the available reports'
)
WHERE code = 'DLR 6.3.1';

-- DLR 6.5.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Report of study on linkages between digital connectivity and economic activity.',
  'Report on dissemination workshops.'
)
WHERE code = 'DLR 6.5.1';