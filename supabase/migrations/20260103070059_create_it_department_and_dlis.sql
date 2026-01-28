/*
  # Create Information Technology Department and DLIs

  ## Overview
  This migration creates the Information Technology Department and its associated DLIs 
  for Periods 1, 2, 3, and 5.

  ## New Data
  
  ### Department
  - Information Technology Department
  
  ### DLIs (5 total)
  - DLR 6.1.1 - Feasibility study conducted by ITD (Period 1)
  - DLR 6.2.1 - ITD has prepared State Data Policy and compliance plan (Period 2)
  - DLR 6.2.2 - Secretary IT and PGC have approved the State Data Policy (Period 2)
  - DLR 6.3.1 - Internet connectivity pilot completed by ITD (Period 3)
  - DLR 6.5.1 - Study on linkages completed and dissemination workshop organized (Period 5)

  ## Important Notes
  - Each DLI includes its verification_heading from the verification protocol (third column)
  - All DLIs are linked to appropriate periods
  - verification_heading contains the complete text without truncation
*/

DO $$
DECLARE
  dept_it_id uuid;
  period_1_id uuid;
  period_2_id uuid;
  period_3_id uuid;
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

  SELECT id INTO period_5_id FROM periods WHERE name = 'Period 5';
  IF period_5_id IS NULL THEN
    INSERT INTO periods (name) VALUES ('Period 5') RETURNING id INTO period_5_id;
  END IF;

  -- Create Information Technology Department
  INSERT INTO departments (name)
  VALUES ('Information Technology Department')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO dept_it_id;

  -- Insert DLIs with verification_heading from third column
  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 6.1.1',
    'DLR: Feasibility study conducted by the Information Technology Department (ITD) for establishing connectivity across the State.',
    period_1_id,
    dept_it_id,
    '• Desk Review of Feasibility Study Report'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 6.2.1',
    'ITD has prepared the State Data Policy and compliance plan',
    period_2_id,
    dept_it_id,
    '• Desk Review of State Data Policy
• Desk Review of the Compliance Plan'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 6.2.2',
    'Secretary IT and PGC have approved the State Data Policy',
    period_2_id,
    dept_it_id,
    '• Desk Review of Approval Letter'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 6.3.1',
    'Internet connectivity pilot completed by ITD in one district based on feasibility study findings',
    period_3_id,
    dept_it_id,
    '• Desk Review of Report on Pilot Study
• Desk Review of Report on internet connectivity
• Desk Review of Report on Users Accessing Internet Connectivity
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 6.5.1',
    'Study on linkages between digital connectivity and economic activity completed and dissemination workshop organized by ITD.',
    period_5_id,
    dept_it_id,
    '• Desk Review of report on linkages between digital connectivity and economic activity
• Desk review Report on Dissemination Workshops'
  )
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Information Technology Department and DLIs created successfully';
END $$;
