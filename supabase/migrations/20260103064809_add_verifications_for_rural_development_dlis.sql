/*
  # Add Verifications for Rural Development Department DLIs

  ## Overview
  This migration creates verification methods for all Rural Development Department DLIs,
  extracted from the third column of the verification protocol.

  ## New Data
  
  ### Verifications for DLR 5.1.1 (3 methods)
  - Desk Review (IEIAP documents and GO or Circular or Memorandum)
  - Desk review the GO or Circular or Memorandum
  - Structured interviews

  ### Verifications for DLR 5.1.2 (1 method)
  - Online Review of IEIAP from Website

  ### Verifications for DLR 5.2.1, 5.3.1, 5.4.1, 5.5.1 (3 methods each)
  - Desk Review of Activity Reports/ Evaluation Studies
  - Desk Review of Intervention areas/Areas
  - Field Review

  ## Important Notes
  - Each verification method is stored as a separate record
  - Methods are linked to their respective DLIs
  - Text is preserved exactly as shown in the verification protocol
  - All verifications start with 'non-verified' state
*/

DO $$
DECLARE
  dli_5_1_1_id uuid;
  dli_5_1_2_id uuid;
  dli_5_2_1_id uuid;
  dli_5_3_1_id uuid;
  dli_5_4_1_id uuid;
  dli_5_5_1_id uuid;
BEGIN
  -- Get DLI IDs for Rural Development Department
  SELECT id INTO dli_5_1_1_id FROM dlis WHERE code = 'DLR 5.1.1';
  SELECT id INTO dli_5_1_2_id FROM dlis WHERE code = 'DLR 5.1.2';
  SELECT id INTO dli_5_2_1_id FROM dlis WHERE code = 'DLR 5.2.1';
  SELECT id INTO dli_5_3_1_id FROM dlis WHERE code = 'DLR 5.3.1';
  SELECT id INTO dli_5_4_1_id FROM dlis WHERE code = 'DLR 5.4.1';
  SELECT id INTO dli_5_5_1_id FROM dlis WHERE code = 'DLR 5.5.1';

  -- Verifications for DLR 5.1.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_5_1_1_id, 'Desk Review (IEIAP documents and GO or Circular or Memorandum)', 'non-verified'),
    (dli_5_1_1_id, 'Desk review the GO or Circular or Memorandum', 'non-verified'),
    (dli_5_1_1_id, 'Structured interviews', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 5.1.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_5_1_2_id, 'Online Review of IEIAP from Website', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 5.2.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_5_2_1_id, 'Desk Review of Activity Reports/ Evaluation Studies', 'non-verified'),
    (dli_5_2_1_id, 'Desk Review of Intervention areas', 'non-verified'),
    (dli_5_2_1_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 5.3.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_5_3_1_id, 'Desk Review of Activity Reports/ Evaluation Studies', 'non-verified'),
    (dli_5_3_1_id, 'Desk Review of Intervention Areas', 'non-verified'),
    (dli_5_3_1_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 5.4.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_5_4_1_id, 'Desk Review of Activity Reports/ Evaluation Studies', 'non-verified'),
    (dli_5_4_1_id, 'Desk Review of Intervention Areas', 'non-verified'),
    (dli_5_4_1_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 5.5.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_5_5_1_id, 'Desk Review of Activity Reports/ Evaluation Studies', 'non-verified'),
    (dli_5_5_1_id, 'Desk Review of Intervention Areas', 'non-verified'),
    (dli_5_5_1_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Verifications for Rural Development Department DLIs created successfully';
END $$;
