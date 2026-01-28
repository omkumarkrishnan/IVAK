/*
  # Add Verifications for PDD/SDD/HFWD/WCDD (DLI 8) Department DLIs

  ## Overview
  This migration creates verification records for all PDD/SDD/HFWD/WCDD (DLI 8) Department DLIs 
  based on the verification protocol (third column from the screenshot).

  ## New Verifications
  
  ### DLR 8.0.1 (1 verification)
  - Review of the notification for setting up the Expert Group and report of the expert group
  
  ### DLR 8.1.1 (2 verifications)
  - Desk Review of Contract, MOU, Agreement or Equivalent
  - Structured interviews
  
  ### DLR 8.2.1 (2 verifications)
  - Testing the functionality of ICMS
  - Verification of Go Live Approval
  
  ### DLR 8.2.2 (2 verifications)
  - Desk Review of the Approval Letter & Launch Letter of Violence Prevention and Safety at Workplace orientation module
  - Desk Review of the Activity Reports/Evaluation Studies on orientation programs of Violence Prevention and Safety at Workplace
  
  ### DLR 8.3.1 (3 verifications)
  - Desk Review
  - Telephonic Review
  - Field Review
  
  ### DLR 8.3.2 (3 verifications)
  - Desk Review of Approval Letter of Migration Support Services guideline and its launch
  - Telephonic Review
  - Field Review
  
  ### DLR 8.4.1 (3 verifications)
  - Desk Review
  - Telephonic Review
  - Field Review
  
  ### DLR 8.5.1 (5 verifications)
  - Desk Review of Activity Reports/Evaluation Studies
  - MIS Review
  - Spot Checks
  - Telephonic Review
  - Field Review

  ## Important Notes
  - Each verification is linked to its respective DLI
  - Verification descriptions are extracted from the third column of the verification protocol
  - All text is preserved without truncation
  - Initial state is set to 'non-verified'
*/

DO $$
DECLARE
  dli_801_id uuid;
  dli_811_id uuid;
  dli_821_id uuid;
  dli_822_id uuid;
  dli_831_id uuid;
  dli_832_id uuid;
  dli_841_id uuid;
  dli_851_id uuid;
BEGIN
  -- Get DLI IDs
  SELECT id INTO dli_801_id FROM dlis WHERE code = 'DLR 8.0.1';
  SELECT id INTO dli_811_id FROM dlis WHERE code = 'DLR 8.1.1';
  SELECT id INTO dli_821_id FROM dlis WHERE code = 'DLR 8.2.1';
  SELECT id INTO dli_822_id FROM dlis WHERE code = 'DLR 8.2.2';
  SELECT id INTO dli_831_id FROM dlis WHERE code = 'DLR 8.3.1';
  SELECT id INTO dli_832_id FROM dlis WHERE code = 'DLR 8.3.2';
  SELECT id INTO dli_841_id FROM dlis WHERE code = 'DLR 8.4.1';
  SELECT id INTO dli_851_id FROM dlis WHERE code = 'DLR 8.5.1';

  -- Verifications for DLR 8.0.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES (
    dli_801_id,
    'Review of the notification for setting up the Expert Group and report of the expert group',
    'non-verified'
  )
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 8.1.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_811_id, 'Desk Review of Contract, MOU, Agreement or Equivalent', 'non-verified'),
    (dli_811_id, 'Structured interviews', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 8.2.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_821_id, 'Testing the functionality of ICMS', 'non-verified'),
    (dli_821_id, 'Verification of Go Live Approval', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 8.2.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_822_id, 'Desk Review of the Approval Letter & Launch Letter of Violence Prevention and Safety at Workplace orientation module', 'non-verified'),
    (dli_822_id, 'Desk Review of the Activity Reports/Evaluation Studies on orientation programs of Violence Prevention and Safety at Workplace', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 8.3.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_831_id, 'Desk Review', 'non-verified'),
    (dli_831_id, 'Telephonic Review', 'non-verified'),
    (dli_831_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 8.3.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_832_id, 'Desk Review of Approval Letter of Migration Support Services guideline and its launch', 'non-verified'),
    (dli_832_id, 'Telephonic Review', 'non-verified'),
    (dli_832_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 8.4.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_841_id, 'Desk Review', 'non-verified'),
    (dli_841_id, 'Telephonic Review', 'non-verified'),
    (dli_841_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 8.5.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_851_id, 'Desk Review of Activity Reports/Evaluation Studies', 'non-verified'),
    (dli_851_id, 'MIS Review', 'non-verified'),
    (dli_851_id, 'Spot Checks', 'non-verified'),
    (dli_851_id, 'Telephonic Review', 'non-verified'),
    (dli_851_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Verifications for PDD/SDD/HFWD/WCDD (DLI 8) Department DLIs created successfully';
END $$;
