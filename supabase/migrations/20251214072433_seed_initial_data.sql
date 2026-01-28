/*
  # Seed Initial Data for CESI Application

  ## Overview
  This migration seeds the database with initial data for periods, departments, DLIs, and verifications.

  ## Data Seeded
  
  ### Periods
  - Period 0, Period 3, Period 4, Period 5

  ### Departments
  - Planning and Development

  ### DLIs (7 total)
  - DLR 1.0.1 through DLR 1.5.3 with their descriptions

  ### Verifications
  - Multiple verification requirements for each DLI with default state 'non-verified'

  ## Important Notes
  
  - All IDs are generated and stored in variables for referencing
  - Verifications are linked to their respective DLIs
  - All records are inserted only if they don't already exist
*/

DO $$
DECLARE
  period_0_id uuid;
  period_3_id uuid;
  period_4_id uuid;
  period_5_id uuid;
  dept_planning_id uuid;
  dli_1_0_1_id uuid;
  dli_1_3_1_id uuid;
  dli_1_3_2_id uuid;
  dli_1_4_1_id uuid;
  dli_1_5_1_id uuid;
  dli_1_5_2_id uuid;
  dli_1_5_3_id uuid;
BEGIN
  -- Insert periods
  INSERT INTO periods (name) VALUES ('Period 0')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO period_0_id;

  INSERT INTO periods (name) VALUES ('Period 3')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO period_3_id;

  INSERT INTO periods (name) VALUES ('Period 4')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO period_4_id;

  INSERT INTO periods (name) VALUES ('Period 5')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO period_5_id;

  -- Insert department
  INSERT INTO departments (name) VALUES ('Planning and Development')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO dept_planning_id;

  -- Insert DLIs
  INSERT INTO dlis (code, description, period_id, department_id)
  VALUES (
    'DLR 1.0.1',
    'State Cabinet issues a GO establishing the Employment and Entrepreneurship Promotion Facility (prior result)',
    period_0_id,
    dept_planning_id
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO dli_1_0_1_id;

  IF dli_1_0_1_id IS NULL THEN
    SELECT id INTO dli_1_0_1_id FROM dlis WHERE code = 'DLR 1.0.1';
  END IF;

  INSERT INTO dlis (code, description, period_id, department_id)
  VALUES (
    'DLR 1.3.1',
    '2 partnerships formulated between the PDD and private sector, social enterprises and/or technical partners.',
    period_3_id,
    dept_planning_id
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO dli_1_3_1_id;

  IF dli_1_3_1_id IS NULL THEN
    SELECT id INTO dli_1_3_1_id FROM dlis WHERE code = 'DLR 1.3.1';
  END IF;

  INSERT INTO dlis (code, description, period_id, department_id)
  VALUES (
    'DLR 1.3.2',
    'PDD has created Centralized Beneficiary Platform (CBP) for planning and monitoring delivery of benefits and services for economic inclusion of women and youth.',
    period_3_id,
    dept_planning_id
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO dli_1_3_2_id;

  IF dli_1_3_2_id IS NULL THEN
    SELECT id INTO dli_1_3_2_id FROM dlis WHERE code = 'DLR 1.3.2';
  END IF;

  INSERT INTO dlis (code, description, period_id, department_id)
  VALUES (
    'DLR 1.4.1',
    'PDD has created Centralized Beneficiary Platform (CBP) for planning and monitoring delivery of benefits and services for economic inclusion of women and youth.',
    period_4_id,
    dept_planning_id
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO dli_1_4_1_id;

  IF dli_1_4_1_id IS NULL THEN
    SELECT id INTO dli_1_4_1_id FROM dlis WHERE code = 'DLR 1.4.1';
  END IF;

  INSERT INTO dlis (code, description, period_id, department_id)
  VALUES (
    'DLR 1.5.1',
    '5 partnerships formulated between the PDD and private sector, social enterprises and/or technical partners (cumulative)',
    period_5_id,
    dept_planning_id
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO dli_1_5_1_id;

  IF dli_1_5_1_id IS NULL THEN
    SELECT id INTO dli_1_5_1_id FROM dlis WHERE code = 'DLR 1.5.1';
  END IF;

  INSERT INTO dlis (code, description, period_id, department_id)
  VALUES (
    'DLR 1.5.2',
    '6 work-readiness programs/boot camps launched by PDD in priority sectors',
    period_5_id,
    dept_planning_id
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO dli_1_5_2_id;

  IF dli_1_5_2_id IS NULL THEN
    SELECT id INTO dli_1_5_2_id FROM dlis WHERE code = 'DLR 1.5.2';
  END IF;

  INSERT INTO dlis (code, description, period_id, department_id)
  VALUES (
    'DLR 1.5.3',
    '60 percent of youth who participated in work readiness programs are work ready in priority sectors.',
    period_5_id,
    dept_planning_id
  )
  ON CONFLICT DO NOTHING
  RETURNING id INTO dli_1_5_3_id;

  IF dli_1_5_3_id IS NULL THEN
    SELECT id INTO dli_1_5_3_id FROM dlis WHERE code = 'DLR 1.5.3';
  END IF;

  -- Insert verifications for DLR 1.0.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES (dli_1_0_1_id, 'Review of the GO on establishment of the Employment and Entrepreneurship Promotion Facility', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 1.3.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_1_3_1_id, 'Desk Review', 'non-verified'),
    (dli_1_3_1_id, 'Structured Interviews', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 1.3.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_1_3_2_id, 'Testing the functionality of CBP', 'non-verified'),
    (dli_1_3_2_id, 'Verification of Go Live Approval', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 1.4.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_1_4_1_id, 'Scheme Integration Verification', 'non-verified'),
    (dli_1_4_1_id, 'Verification of Scheme Functionalities (at least three schemes)', 'non-verified'),
    (dli_1_4_1_id, 'Telephonic Review', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 1.5.1
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_1_5_1_id, 'Desk Review', 'non-verified'),
    (dli_1_5_1_id, 'Structured Interviews', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 1.5.2
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_1_5_2_id, 'Desk Review', 'non-verified'),
    (dli_1_5_2_id, 'MIS Review', 'non-verified'),
    (dli_1_5_2_id, 'Spot Checks', 'non-verified'),
    (dli_1_5_2_id, 'Certifications', 'non-verified')
  ON CONFLICT DO NOTHING;

  -- Insert verifications for DLR 1.5.3
  INSERT INTO verifications (dli_id, description, state)
  VALUES 
    (dli_1_5_3_id, 'Spot Checks', 'non-verified'),
    (dli_1_5_3_id, 'Telephonic and Field Review', 'non-verified'),
    (dli_1_5_3_id, 'Proposed Deliverables', 'non-verified')
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Data seeded successfully';
END $$;