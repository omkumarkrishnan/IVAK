/*
  # Add Verifications for Information Technology Department DLIs

  ## Overview
  This migration creates verification records for all IT Department DLIs based on the 
  verification protocol (third column from the screenshot).

  ## New Verifications
  
  ### DLR 6.1.1 (1 verification)
  - Desk Review of Feasibility Study Report
  
  ### DLR 6.2.1 (2 verifications)
  - Desk Review of State Data Policy
  - Desk Review of the Compliance Plan
  
  ### DLR 6.2.2 (1 verification)
  - Desk Review of Approval Letter
  
  ### DLR 6.3.1 (4 verifications)
  - Desk Review of Report on Pilot Study
  - Desk Review of Report on internet connectivity
  - Desk Review of Report on Users Accessing Internet Connectivity
  - Field Review
  
  ### DLR 6.5.1 (2 verifications)
  - Desk Review of report on linkages between digital connectivity and economic activity
  - Desk review Report on Dissemination Workshops

  ## Important Notes
  - Each verification is linked to its respective DLI
  - Verification descriptions are extracted from the third column of the verification protocol
  - All text is preserved without truncation
  - Initial state is set to 'non-verified'
*/

DO $$
DECLARE
  dli_611_id uuid;
  dli_621_id uuid;
  dli_622_id uuid;
  dli_631_id uuid;
  dli_651_id uuid;
BEGIN
  -- Get DLI IDs
  SELECT id INTO dli_611_id FROM dlis WHERE code = 'DLR 6.1.1';
  SELECT id INTO dli_621_id FROM dlis WHERE code = 'DLR 6.2.1';
  SELECT id INTO dli_622_id FROM dlis WHERE code = 'DLR 6.2.2';
  SELECT id INTO dli_631_id FROM dlis WHERE code = 'DLR 6.3.1';
  SELECT id INTO dli_651_id FROM dlis WHERE code = 'DLR 6.5.1';

  -- Verifications for DLR 6.1.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES (
    dli_611_id,
    'Desk Review of Feasibility Study Report',
    'non-verified'
  )
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 6.2.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_621_id, 'Desk Review of State Data Policy', 'non-verified'),
    (dli_621_id, 'Desk Review of the Compliance Plan', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 6.2.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES (
    dli_622_id,
    'Desk Review of Approval Letter',
    'non-verified'
  )
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 6.3.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_631_id, 'Desk Review of Report on Pilot Study', 'non-verified'),
    (dli_631_id, 'Desk Review of Report on internet connectivity', 'non-verified'),
    (dli_631_id, 'Desk Review of Report on Users Accessing Internet Connectivity', 'non-verified'),
    (dli_631_id, 'Field Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Verifications for DLR 6.5.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_651_id, 'Desk Review of report on linkages between digital connectivity and economic activity', 'non-verified'),
    (dli_651_id, 'Desk review Report on Dissemination Workshops', 'non-verified')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Verifications for IT Department DLIs created successfully';
END $$;
