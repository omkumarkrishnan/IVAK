/*
  # Create Skill Development Department and DLIs

  ## Overview
  This migration creates the Skill Development Department and its associated DLIs for Periods 1-5.

  ## New Data
  
  ### Department
  - Skill Development Department
  
  ### DLIs (5 total)
  - DLR 4.1.1 - 4 Training Providers/Partners empaneled (Period 1)
  - DLR 4.2.1 - Virtual and blended career counselling launched (Period 2)
  - DLR 4.3.1 - 3 new NSQF compliant training programs (Period 3)
  - DLR 4.4.1 - 6 new NSQF compliant training programs cumulative (Period 4)
  - DLR 4.5.1 - Placement rate reached 50 percent (Period 5)

  ## Important Notes
  - Each DLI includes its verification_heading from the verification protocol
  - All DLIs are linked to appropriate periods
  - verification_heading contains the full text from the third column of the protocol document
*/

DO $$
DECLARE
  dept_skill_dev_id uuid;
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

  -- Create Skill Development Department
  INSERT INTO departments (name)
  VALUES ('Skill Development Department')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO dept_skill_dev_id;

  -- Insert DLIs with verification_heading
  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 4.1.1',
    '4 Training Providers/Partners empaneled by SICB/ SDD to deliver both technical and non-cognitive skill training in priority sectors',
    period_1_id,
    dept_skill_dev_id,
    '• Desk Review of GO or Circular or Memorandum'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 4.2.1',
    'Virtual and blended career counselling and placement support services launched by SICB/ Niyukti Kendra/ SDD',
    period_2_id,
    dept_skill_dev_id,
    '• Desk Review of Approval Letter, Launch Letter and Activity Reports/ Evaluation Studies
• Desk Review of MIS Data/Official Documents
• Telephonic Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 4.3.1',
    '3 new NSQF compliant training programs conducted by SICB/ SDD in priority sectors',
    period_3_id,
    dept_skill_dev_id,
    '• Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification
• Telephonic Review of Trainees
• Telephonic Review of Certified Trainees'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 4.4.1',
    '6 new NSQF compliant training programs conducted by SICB/ SDD in priority sectors (cumulative)',
    period_4_id,
    dept_skill_dev_id,
    '• Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification
• Telephonic Review of Trainees
• Telephonic Review of Certified Trainees'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 4.5.1',
    'Placement rate for trainees in priority sectors has reached 50 percent',
    period_5_id,
    dept_skill_dev_id,
    '• Desk Review of Activity Reports/Evaluation Studies on Placement
• Telephonic Review of Trainees
• Telephonic Interviews of Employers'
  )
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Skill Development Department and DLIs created successfully';
END $$;
