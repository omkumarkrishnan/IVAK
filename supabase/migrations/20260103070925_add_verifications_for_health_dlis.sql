/*
  # Add Verifications for Health and Family Welfare Department DLIs

  ## Overview
  This migration creates verification records for all Health and Family Welfare Department DLIs 
  based on the verification protocol (third column from the screenshot).

  ## New Verifications
  
  ### DLR 7.0.1 (1 verification)
  - Review of the approval of the H&FWD for go-live of the mobile app and review of the Mobile App on mental health
  
  ### DLR 7.2.1 (4 verifications)
  - Desk Review of Activity Reports/Evaluation Studies on Training of Teachers
  - MIS Review
  - Telephonic Review
  - Field Review
  
  ### DLR 7.3.1 (4 verifications)
  - Desk Review of Activity Reports/Evaluation Studies on Upskilling on Mental Health
  - Desk Review of MIS Data/ Official documents
  - Telephonic Review
  - Desk Review of Certification
  
  ### DLR 7.3.2 (2 verifications)
  - Desk Review of Approval Letter for Updated Mobile App
  - System Review of App Updation
  
  ### DLR 7.4.1 (2 verifications)
  - Desk Review
  - MIS Review
  
  ### DLR 7.5.1 (3 verifications)
  - Desk Review
  - MIS Review
  - Telephonic Review
  
  ### DLR 7.5.2 (6 verifications)
  - Multiple desk reviews, field reviews, and structured interviews

  ## Important Notes
  - Each verification is linked to its respective DLI
  - Verification descriptions are extracted from the third column of the verification protocol
  - All text is preserved without truncation
  - Initial state is set to 'non-verified'
*/

DO $$
DECLARE
  dli_701_id uuid;
  dli_721_id uuid;
  dli_731_id uuid;
  dli_732_id uuid;
  dli_741_id uuid;
  dli_751_id uuid;
  dli_752_id uuid;
BEGIN
  -- Get DLI IDs
  SELECT id INTO dli_701_id FROM dlis WHERE code = 'DLR 7.0.1';
  SELECT id INTO dli_721_id FROM dlis WHERE code = 'DLR 7.2.1';
  SELECT id INTO dli_731_id FROM dlis WHERE code = 'DLR 7.3.1';
  SELECT id INTO dli_732_id FROM dlis WHERE code = 'DLR 7.3.2';
  SELECT id INTO dli_741_id FROM dlis WHERE code = 'DLR 7.4.1';
  SELECT id INTO dli_751_id FROM dlis WHERE code = 'DLR 7.5.1';
  SELECT id INTO dli_752_id FROM dlis WHERE code = 'DLR 7.5.2';

  -- Verifications for DLR 7.0.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES (
    dli_701_id,
    'Review of the approval of the H&FWD for go-live of the mobile app and review of the Mobile App on mental health',
    'non-verified'
  )
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 7.2.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_721_id, 'Desk Review of Activity Reports/Evaluation Studies on Training of Teachers in Life Skills Education & in Undertaking Preliminary Screening for identifying Mental Health Related Concerns', 'non-verified'),
    (dli_721_id, 'MIS Review', 'non-verified'),
    (dli_721_id, 'Telephonic Review', 'non-verified'),
    (dli_721_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 7.3.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_731_id, 'Desk Review of Activity Reports/Evaluation Studies on Upskilling on Mental Health', 'non-verified'),
    (dli_731_id, 'Desk Review of MIS Data/ Official documents', 'non-verified'),
    (dli_731_id, 'Telephonic Review', 'non-verified'),
    (dli_731_id, 'Desk Review of Certification', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 7.3.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_732_id, 'Desk Review of Approval Letter for Updated Mobile App', 'non-verified'),
    (dli_732_id, 'System Review of App Updation', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 7.4.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_741_id, 'Desk Review', 'non-verified'),
    (dli_741_id, 'MIS Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 7.5.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_751_id, 'Desk Review', 'non-verified'),
    (dli_751_id, 'MIS Review', 'non-verified'),
    (dli_751_id, 'Telephonic Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 7.5.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_752_id, 'Desk Review of Activity Reports/Evaluation Studies (Life Skills Education)', 'non-verified'),
    (dli_752_id, 'Desk Review of Activity Reports/Evaluation Studies (Community-based Outreach Activities)', 'non-verified'),
    (dli_752_id, 'Field Review (Adolescent and Youth participating in Life Skills Education & screened for mental health related concerns)', 'non-verified'),
    (dli_752_id, 'Structured Interviews of School Teachers', 'non-verified'),
    (dli_752_id, 'Field Review of adolescents and youths participating in community-based outreach activities', 'non-verified'),
    (dli_752_id, 'Structured Interview of Health Professionals', 'non-verified')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Verifications for Health and Family Welfare Department DLIs created successfully';
END $$;
