/*
  # Create PDD/SDD/HFWD/WCDD (DLI 8) Department and DLIs

  ## Overview
  This migration creates the PDD/SDD/HFWD/WCDD (DLI 8) Department and its associated DLIs 
  for Periods 0, 1, 2, 3, 4, and 5 focused on partnerships, childcare, reproductive health,
  geriatric care, and women's safety programs.

  ## New Data
  
  ### Department
  - PDD/SDD/HFWD/WCDD (DLI 8)
  
  ### DLIs (8 total)
  - DLR 8.0.1 - Expert Group meeting organized (Period 0)
  - DLR 8.1.1 - 3 Partnerships established (Period 1)
  - DLR 8.2.1 - Integrated case management system established (Period 2)
  - DLR 8.2.2 - Violence prevention and safety orientation launched (Period 2)
  - DLR 8.3.1 - 200 trainees receive training (Period 3)
  - DLR 8.3.2 - Migration support services launched (Period 3)
  - DLR 8.4.1 - 400 trainees (cumulative) receive training (Period 4)
  - DLR 8.5.1 - 20% of trainees placed (Period 5)

  ## Important Notes
  - Each DLI includes its verification_heading from the verification protocol (third column)
  - All DLIs are linked to appropriate periods
  - verification_heading contains the complete text without truncation
*/

DO $$
DECLARE
  dept_pdd_id uuid;
  period_0_id uuid;
  period_1_id uuid;
  period_2_id uuid;
  period_3_id uuid;
  period_4_id uuid;
  period_5_id uuid;
BEGIN
  -- Get or create periods
  SELECT id INTO period_0_id FROM periods WHERE name = 'Period 0';
  IF period_0_id IS NULL THEN
    INSERT INTO periods (name) VALUES ('Period 0') RETURNING id INTO period_0_id;
  END IF;

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

  -- Create PDD/SDD/HFWD/WCDD (DLI 8) Department
  INSERT INTO departments (name)
  VALUES ('PDD/SDD/HFWD/WCDD (DLI 8)')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO dept_pdd_id;

  -- Insert DLIs with verification_heading from third column
  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 8.0.1',
    'Expert Group meeting organized by PDD in collaboration with H&FWD, on identifying research priorities and roadmap for understanding socio-economic aspects of declining fertility rates in Sikkim',
    period_0_id,
    dept_pdd_id,
    '• Review of the notification for setting up the Expert Group and report of the expert group'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 8.1.1',
    '3 Partnerships established on childcare, reproductive health, and geriatric care, by PDD in coordination with SDD, H&FWD and WCDD',
    period_1_id,
    dept_pdd_id,
    '• Desk Review of Contract, MOU, Agreement or Equivalent
• Structured interviews'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 8.2.1',
    'Integrated case management system established for vulnerable women beneficiaries of WCDD',
    period_2_id,
    dept_pdd_id,
    '• Testing the functionality of ICMS
• Verification of Go Live Approval'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 8.2.2',
    'Violence prevention and safety at workplace orientation launched for women entrepreneurs and women-led homestays by WCDD',
    period_2_id,
    dept_pdd_id,
    '• Desk Review of the Approval Letter & Launch Letter of Violence Prevention and Safety at Workplace orientation module
• Desk Review of the Activity Reports/Evaluation Studies on orientation programs of Violence Prevention and Safety at Workplace'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 8.3.1',
    '200 trainees receive training and certification in childcare/geriatric care, or reproductive health, or early childhood development by PDD in coordination with SDD, H&FWD and WCDD',
    period_3_id,
    dept_pdd_id,
    '• Desk Review
• Telephonic Review
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 8.3.2',
    'Migration support services launched to enable migration for jobs in national and international locations',
    period_3_id,
    dept_pdd_id,
    '• Desk Review of Approval Letter of Migration Support Services guideline and its launch
• Telephonic Review
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 8.4.1',
    '400 trainees (cumulative) receive training and certification in childcare/geriatric care, or reproductive health, or early childhood development by PDD in coordination with SDD, H&FWD and WCDD',
    period_4_id,
    dept_pdd_id,
    '• Desk Review
• Telephonic Review
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 8.5.1',
    '20 percent of trainees trained and certified in childcare/geriatric care, or reproductive health, or early childhood development placed in national or international locations',
    period_5_id,
    dept_pdd_id,
    '• Desk Review of Activity Reports/Evaluation Studies
• MIS Review
• Spot Checks
• Telephonic Review
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'PDD/SDD/HFWD/WCDD (DLI 8) Department and DLIs created successfully';
END $$;
