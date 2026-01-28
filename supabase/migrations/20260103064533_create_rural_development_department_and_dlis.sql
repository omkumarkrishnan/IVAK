/*
  # Create Rural Development Department and DLIs

  ## Overview
  This migration creates the Rural Development Department/Directorate of Eco-Tourism –Forest Department 
  and its associated DLIs for Periods 1-5.

  ## New Data
  
  ### Department
  - Rural Development Department/Directorate of Eco-Tourism –Forest Department
  
  ### DLIs (6 total)
  - DLR 5.1.1 - District-level IEIAPs approved by PGC (Period 1)
  - DLR 5.1.2 - IEIAPs available in public domain for 6 districts (Period 1)
  - DLR 5.2.1 - 20 percent financing disbursed (Period 2)
  - DLR 5.3.1 - 40 percent financing disbursed cumulative (Period 3)
  - DLR 5.4.1 - 50 percent financing disbursed cumulative (Period 4)
  - DLR 5.5.1 - 60 percent financing disbursed cumulative (Period 5)

  ## Important Notes
  - Each DLI includes its verification_heading from the verification protocol (third column)
  - All DLIs are linked to appropriate periods
  - verification_heading contains the complete text without truncation
*/

DO $$
DECLARE
  dept_rural_dev_id uuid;
  period_1_id uuid;
  period_2_id uuid;
  period_3_id uuid;
  period_4_id uuid;
  period_5_id uuid;
BEGIN
  -- Get or create periods
  SELECT id INTO period_1_id FROM periods WHERE name = 'Period 1';
  IF period_1_id IS NULL THEN
    INSERT INTO periods (name) VALUES ('Period 1') RETURNING id INTO period_1_id;
  END IF;

  SELECT id INTO period_2_id FROM periods WHERE name = 'Period 2';
  IF period_2_id IS NULL THEN
    INSERT INTO periods (name) VALUES ('Period 2') RETURNING id INTO period_2_id;
  END IF;

  SELECT id INTO period_3_id FROM periods WHERE name = 'Period 3';
  IF period_3_id IS NULL THEN
    INSERT INTO periods (name) VALUES ('Period 3') RETURNING id INTO period_3_id;
  END IF;

  SELECT id INTO period_4_id FROM periods WHERE name = 'Period 4';
  IF period_4_id IS NULL THEN
    INSERT INTO periods (name) VALUES ('Period 4') RETURNING id INTO period_4_id;
  END IF;

  SELECT id INTO period_5_id FROM periods WHERE name = 'Period 5';
  IF period_5_id IS NULL THEN
    INSERT INTO periods (name) VALUES ('Period 5') RETURNING id INTO period_5_id;
  END IF;

  -- Create Rural Development Department
  INSERT INTO departments (name)
  VALUES ('Rural Development Department/Directorate of Eco-Tourism –Forest Department')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO dept_rural_dev_id;

  -- Insert DLIs with verification_heading from third column
  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 5.1.1',
    'District-level IEIAPs that reflect investment priorities and financial allocations on economic inclusion in non-farm sectors, approved by PGC',
    period_1_id,
    dept_rural_dev_id,
    '• Desk Review (IEIAP documents and GO or Circular or Memorandum)
• Desk review the GO or Circular or Memorandum
• Structured interviews'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 5.1.2',
    'District-level IEIAPs are available in the public domain for 6 districts',
    period_1_id,
    dept_rural_dev_id,
    '• Online Review of IEIAP from Website'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 5.2.1',
    '20 percent financing disbursed in each district as per the district-level IEIAPs',
    period_2_id,
    dept_rural_dev_id,
    '• Desk Review of Activity Reports/ Evaluation Studies
• Desk Review of Intervention areas
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 5.3.1',
    '40 percent financing disbursed in each district as per the district-level IEIAPs (cumulative)',
    period_3_id,
    dept_rural_dev_id,
    '• Desk Review of Activity Reports/ Evaluation Studies
• Desk Review of Intervention Areas
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 5.4.1',
    '50 percent financing disbursed in each district as per the district-level IEIAPs (cumulative)',
    period_4_id,
    dept_rural_dev_id,
    '• Desk Review of Activity Reports/ Evaluation Studies
• Desk Review of Intervention Areas
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 5.5.1',
    '60 percent financing disbursed in each district as per the district-level IEIAPs (cumulative)',
    period_5_id,
    dept_rural_dev_id,
    '• Desk Review of Activity Reports/ Evaluation Studies
• Desk Review of Intervention Areas
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Rural Development Department and DLIs created successfully';
END $$;
