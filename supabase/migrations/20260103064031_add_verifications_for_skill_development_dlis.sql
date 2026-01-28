/*
  # Add Verifications for Skill Development Department DLIs

  ## Overview
  This migration creates verification records for all Skill Development Department DLIs.
  Each bullet point in the verification protocol becomes a separate verification record.

  ## Verifications Created
  
  ### DLR 4.1.1 (1 verification)
  - Desk Review of GO or Circular or Memorandum

  ### DLR 4.2.1 (3 verifications)
  - Desk Review of Approval Letter, Launch Letter and Activity Reports/ Evaluation Studies
  - Desk Review of MIS Data/Official Documents
  - Telephonic Review

  ### DLR 4.3.1 (3 verifications)
  - Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification
  - Telephonic Review of Trainees
  - Telephonic Review of Certified Trainees

  ### DLR 4.4.1 (3 verifications)
  - Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification
  - Telephonic Review of Trainees
  - Telephonic Review of Certified Trainees

  ### DLR 4.5.1 (3 verifications)
  - Desk Review of Activity Reports/Evaluation Studies on Placement
  - Telephonic Review of Trainees
  - Telephonic Interviews of Employers

  ## Total: 13 verification records
*/

DO $$
DECLARE
  dli_4_1_1_id uuid;
  dli_4_2_1_id uuid;
  dli_4_3_1_id uuid;
  dli_4_4_1_id uuid;
  dli_4_5_1_id uuid;
BEGIN
  -- Get DLI IDs
  SELECT id INTO dli_4_1_1_id FROM dlis WHERE code = 'DLR 4.1.1';
  SELECT id INTO dli_4_2_1_id FROM dlis WHERE code = 'DLR 4.2.1';
  SELECT id INTO dli_4_3_1_id FROM dlis WHERE code = 'DLR 4.3.1';
  SELECT id INTO dli_4_4_1_id FROM dlis WHERE code = 'DLR 4.4.1';
  SELECT id INTO dli_4_5_1_id FROM dlis WHERE code = 'DLR 4.5.1';

  -- DLR 4.1.1 Verifications
  INSERT INTO verifications (dli_id, description)
  VALUES (dli_4_1_1_id, 'Desk Review of GO or Circular or Memorandum')
  ON CONFLICT DO NOTHING;

  -- DLR 4.2.1 Verifications
  INSERT INTO verifications (dli_id, description)
  VALUES 
    (dli_4_2_1_id, 'Desk Review of Approval Letter, Launch Letter and Activity Reports/ Evaluation Studies'),
    (dli_4_2_1_id, 'Desk Review of MIS Data/Official Documents'),
    (dli_4_2_1_id, 'Telephonic Review')
  ON CONFLICT DO NOTHING;

  -- DLR 4.3.1 Verifications
  INSERT INTO verifications (dli_id, description)
  VALUES 
    (dli_4_3_1_id, 'Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification'),
    (dli_4_3_1_id, 'Telephonic Review of Trainees'),
    (dli_4_3_1_id, 'Telephonic Review of Certified Trainees')
  ON CONFLICT DO NOTHING;

  -- DLR 4.4.1 Verifications
  INSERT INTO verifications (dli_id, description)
  VALUES 
    (dli_4_4_1_id, 'Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification'),
    (dli_4_4_1_id, 'Telephonic Review of Trainees'),
    (dli_4_4_1_id, 'Telephonic Review of Certified Trainees')
  ON CONFLICT DO NOTHING;

  -- DLR 4.5.1 Verifications
  INSERT INTO verifications (dli_id, description)
  VALUES 
    (dli_4_5_1_id, 'Desk Review of Activity Reports/Evaluation Studies on Placement'),
    (dli_4_5_1_id, 'Telephonic Review of Trainees'),
    (dli_4_5_1_id, 'Telephonic Interviews of Employers')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Successfully created 13 verification records for Skill Development Department DLIs';
END $$;
