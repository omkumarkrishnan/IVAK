/*
  # Populate Data Requirements for DLI 5 DLRs

  1. Purpose
    - Populate the data_requirements field for DLI 5 DLRs
    - Based on the data requirements document screenshot for DLI 5
  
  2. DLRs Updated
    - DLR 5.1.1: District-level IEIAPs approved by PGC
    - DLR 5.1.2: District-level IEIAPs available in public domain for 6 districts
    - DLR 5.2.1: 20 percent financing disbursed in each district
    - DLR 5.3.1: 40 percent financing disbursed in each district (cumulative)
    - DLR 5.4.1: 50 percent financing disbursed in each district (cumulative)
    - DLR 5.5.1: 60 percent financing disbursed in each district (cumulative)
*/

-- DLR 5.1.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'IEIAP documents, along with the GO / Circular / Memorandum on approval by the PGC, from the RDD.'
)
WHERE code = 'DLR 5.1.1';

-- DLR 5.1.2
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'IEIAP documents, along with the GO / Circular / Memorandum on approval by the PGC, to be accessible online on a GoS website. Website address needs to be provided by the RDD.'
)
WHERE code = 'DLR 5.1.2';

-- DLR 5.2.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Details on disbursements from Program MIS and SIFMS report for each district',
  'District-wise list of activities under IEIAP Scheme on the following intervention areas',
  'District wise number of activities under IEIAP Scheme on the following intervention areas',
  'List of activities and contact details of the scheme beneficiaries for each district. Further, RDD to provide list of scheme beneficiaries for each of the selected activity'
)
WHERE code = 'DLR 5.2.1';

-- DLR 5.3.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Details of disbursement from the Program MIS and SIFMS report on disbursements in each district',
  'District wise list of activities under IEIAP Scheme on the following intervention areas',
  'District wise number of activities under IEIAP Scheme on the following intervention areas list of activities and contact details of the scheme beneficiaries for each district. Further, the RDD is to provide the list of scheme beneficiaries for each of the selected activity.'
)
WHERE code = 'DLR 5.3.1';

-- DLR 5.4.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Details of disbursement from the program MIS and SIFMS report on disbursements in each district',
  'District-wise list of activities under IEIAP scheme on the following intervention areas',
  'District-wise number of activities under IEIAP scheme on the following intervention areas'
)
WHERE code = 'DLR 5.4.1';

-- DLR 5.5.1
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Details of disbursement from the program MIS and SIFMS report on disbursements in each district',
  'District wise list of activities under IEIAP Scheme on the following intervention areas',
  'District-wise number of activities under IEIAP scheme on the following intervention areas',
  'List of activities and contact details of the scheme beneficiaries for each district. Further, the RDD to provide list of scheme beneficiaries for each of the selected activities.'
)
WHERE code = 'DLR 5.5.1';