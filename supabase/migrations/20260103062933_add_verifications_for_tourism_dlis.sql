/*
  # Add Verification Records for Tourism and Civil Aviation Department DLIs

  ## Overview
  This migration creates verification records for all Tourism and Civil Aviation Department DLIs.
  Each verification represents a specific verification requirement from the verification protocol.

  ## Verifications Added
  
  ### DLR 3.0.1 (1 verification)
  - Review of the official document from the IMF conveying the completion of the inspection of IHCAE
  
  ### DLR 3.0.2 (1 verification)
  - Review of the official document from the IMF conveying the completion of the inspection of IHCAE
  
  ### DLR 3.2.1 (3 verifications)
  - Desk Review of Activity Reports/Evaluation Studies
  - Desk Review of Certification by T & CAD and other Departments
  - Field Verification of Homestays
  
  ### DLR 3.2.2 (2 verifications)
  - Desk Review of Training on Business Management & Digital Marketing
  - Field Review
  
  ### DLR 3.3.1 (2 verifications)
  - Desk Review of Training on Business Management & Digital Marketing
  - Field Review
  
  ### DLR 3.5.1 (4 verifications)
  - Desk Review of adoption of Digital Marketing
  - Field Review of Digital Marketing Adoption
  - Desk Review of adoption of Digital Payment Tools
  - Desk Review of adoption of Digital Payment Tools
  
  ## Important Notes
  - All verifications are set to 'non-verified' state by default
  - Verifications are linked to their respective DLIs
*/

DO $$
DECLARE
  dli_3_0_1_id uuid;
  dli_3_0_2_id uuid;
  dli_3_2_1_id uuid;
  dli_3_2_2_id uuid;
  dli_3_3_1_id uuid;
  dli_3_5_1_id uuid;
BEGIN
  -- Get DLI IDs
  SELECT id INTO dli_3_0_1_id FROM dlis WHERE code = 'DLR 3.0.1';
  SELECT id INTO dli_3_0_2_id FROM dlis WHERE code = 'DLR 3.0.2';
  SELECT id INTO dli_3_2_1_id FROM dlis WHERE code = 'DLR 3.2.1';
  SELECT id INTO dli_3_2_2_id FROM dlis WHERE code = 'DLR 3.2.2';
  SELECT id INTO dli_3_3_1_id FROM dlis WHERE code = 'DLR 3.3.1';
  SELECT id INTO dli_3_5_1_id FROM dlis WHERE code = 'DLR 3.5.1';

  -- Insert verifications for DLR 3.0.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES (
    dli_3_0_1_id,
    'Review of the official document from the IMF conveying the completion of the inspection of IHCAE',
    'non-verified'
  )
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 3.0.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES (
    dli_3_0_2_id,
    'Review of the official document from the IMF conveying the completion of the inspection of IHCAE',
    'non-verified'
  )
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 3.2.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_3_2_1_id, 'Desk Review of Activity Reports/Evaluation Studies', 'non-verified'),
    (dli_3_2_1_id, 'Desk Review of Certification by T & CAD and other Departments', 'non-verified'),
    (dli_3_2_1_id, 'Field Verification of Homestays', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 3.2.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_3_2_2_id, 'Desk Review of Training on Business Management & Digital Marketing', 'non-verified'),
    (dli_3_2_2_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 3.3.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_3_3_1_id, 'Desk Review of Training on Business Management & Digital Marketing', 'non-verified'),
    (dli_3_3_1_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 3.5.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_3_5_1_id, 'Desk Review of adoption of Digital Marketing', 'non-verified'),
    (dli_3_5_1_id, 'Field Review of Digital Marketing Adoption', 'non-verified'),
    (dli_3_5_1_id, 'Desk Review of adoption of Digital Payment Tools', 'non-verified'),
    (dli_3_5_1_id, 'Desk Review of adoption of Digital Payment Tools', 'non-verified')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Verifications for Tourism DLIs created successfully';
END $$;
