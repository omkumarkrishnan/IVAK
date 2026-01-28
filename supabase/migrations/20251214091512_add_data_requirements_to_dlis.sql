/*
  # Add Data Requirements Column to DLIs
  
  1. Changes
    - Add `data_requirements` column to the dlis table as JSONB array
    - Update existing DLIs with data requirements from the screenshot
    
  2. Data Requirements Added
    - DLR 1.0.1: GO on establishment of Employment and Entrepreneurship Promotion Facility
    - DLR 1.3.1: Contract/MOU/agreement with private sector partners
    - DLR 1.3.2: Demonstration of CBP
    - DLR 1.4.1: List of schemes in CBP portal, beneficiary details for three schemes
    - DLR 1.5.1: Official documents of partnerships
    - DLR 1.5.2: MIS data, reports, trainee lists, participation certificates
    - DLR 1.5.3: Program MIS details and reports on work readiness programs
    
  3. Notes
    - Data requirements stored as JSONB array for flexibility
    - Each requirement is a separate string in the array
*/

-- Add data_requirements column to dlis table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'dlis' AND column_name = 'data_requirements'
  ) THEN
    ALTER TABLE dlis ADD COLUMN data_requirements jsonb DEFAULT '[]'::jsonb;
  END IF;
END $$;

-- Update DLR 1.0.1 with data requirements
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'GO on the establishment of the Employment and Entrepreneurship Promotion Facility'
)
WHERE code = 'DLR 1.0.1';

-- Update DLR 1.3.1 with data requirements
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Contract, MOU, agreement, or equivalent of partnership with private sector agencies, social enterprises, and technical partners.'
)
WHERE code = 'DLR 1.3.1';

-- Update DLR 1.3.2 with data requirements
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Demonstration of the Centralized Beneficiary Platform (CBP)'
)
WHERE code = 'DLR 1.3.2';

-- Update DLR 1.4.1 with data requirements and correct description
UPDATE dlis
SET description = 'CBP is functional with the integration of at least three schemes.',
    data_requirements = jsonb_build_array(
      'Detailed list of schemes available in the CBP portal/ official documents',
      'Beneficiary details for each of the three schemes'
    )
WHERE code = 'DLR 1.4.1';

-- Update DLR 1.5.1 with data requirements
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Official document (contract or Memorandum of Understanding, i.e., MoU or agreement or equivalent) of the partnership. With private sector agencies, social enterprises, and/or technical partners.'
)
WHERE code = 'DLR 1.5.1';

-- Update DLR 1.5.2 with data requirements
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'MIS data and reports of all work readiness training programs & boot camps undertaken in the priority sector.',
  'Report all work readiness training programs & boot camps.',
  'List of trainees of Training Programs and Boot Camps and copies of participation certificates awarded to youth as part of these programs and boot camps.'
)
WHERE code = 'DLR 1.5.2';

-- Update DLR 1.5.3 with data requirements
UPDATE dlis
SET data_requirements = jsonb_build_array(
  'Details from the Program MIS/ official documents, and reports on work readiness programs/boot camps conducted for priority sectors under the Program.'
)
WHERE code = 'DLR 1.5.3';
