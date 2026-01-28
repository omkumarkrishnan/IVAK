/*
  # Create Health and Family Welfare Department and DLIs

  ## Overview
  This migration creates the Health and Family Welfare Department and its associated DLIs 
  for Periods 0, 2, 3, 4, and 5 focused on mental health programs.

  ## New Data
  
  ### Department
  - Health and Family Welfare Department
  
  ### DLIs (7 total)
  - DLR 7.0.1 - Mobile App on mental health launched (Period 0)
  - DLR 7.2.1 - 850 schoolteachers trained (Period 2)
  - DLR 7.3.1 - 665 health workers upskilled (Period 3)
  - DLR 7.3.2 - Mobile app update launched (Period 3)
  - DLR 7.4.1 - 1,140 community-based activities (Period 4)
  - DLR 7.5.1 - 5% increase in footfall at PHCs/AFHCs (Period 5)
  - DLR 7.5.2 - 70% of youth screened (Period 5)

  ## Important Notes
  - Each DLI includes its verification_heading from the verification protocol (third column)
  - All DLIs are linked to appropriate periods
  - verification_heading contains the complete text without truncation
*/

DO $$
DECLARE
  dept_health_id uuid;
  period_0_id uuid;
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

  -- Create Health and Family Welfare Department
  INSERT INTO departments (name)
  VALUES ('Health and Family Welfare Department')
  ON CONFLICT (name) DO UPDATE SET name = EXCLUDED.name
  RETURNING id INTO dept_health_id;

  -- Insert DLIs with verification_heading from third column
  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 7.0.1',
    'Mobile App on mental health awareness and service delivery linkages launched by the H&FWD',
    period_0_id,
    dept_health_id,
    '• Review of the approval of the H&FWD for go-live of the mobile app and review of the Mobile App on mental health'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 7.2.1',
    '850 schoolteachers trained in life skills education and in undertaking preliminary screening for mental health related concerns',
    period_2_id,
    dept_health_id,
    '• Desk Review of Activity Reports/Evaluation Studies on Training of Teachers in Life Skills Education & in Undertaking Preliminary Screening for identifying Mental Health Related Concerns
• MIS Review
• Telephonic Review
• Field Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 7.3.1',
    '665 health workers and counsellors upskilled on mental health – including focus on suicide prevention, substance abuse management',
    period_3_id,
    dept_health_id,
    '• Desk Review of Activity Reports/Evaluation Studies on Upskilling on Mental Health
• Desk Review of MIS Data/ Official documents
• Telephonic Review
• Desk Review of Certification'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 7.3.2',
    'Update to mobile app on mental health launched by the H&FWD',
    period_3_id,
    dept_health_id,
    '• Desk Review of Approval Letter for Updated Mobile App
• System Review of App Updation'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 7.4.1',
    '1,140 community-based, mental health promotion, screening and outreach activities conducted',
    period_4_id,
    dept_health_id,
    '• Desk Review
• MIS Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 7.5.1',
    '5 percent increase over baseline in footfall of adolescents (10-18 years) and youth (18-35 years) at Primary Health Centers (PHCs) and/or Adolescent Friendly Health Clinics (AFHCs) for mental health management and/or de-addiction services',
    period_5_id,
    dept_health_id,
    '• Desk Review
• MIS Review
• Telephonic Review'
  )
  ON CONFLICT DO NOTHING;

  INSERT INTO dlis (code, description, period_id, department_id, verification_heading)
  VALUES (
    'DLR 7.5.2',
    '70 percent of adolescents and youth participating in life skills education in schools and in community-based outreach activities are screened for mental health related concerns',
    period_5_id,
    dept_health_id,
    '• Desk Review of Activity Reports/Evaluation Studies (Life Skills Education)
• Desk Review of Activity Reports/Evaluation Studies (Community-based Outreach Activities)
• Field Review (Adolescent and Youth participating in Life Skills Education & screened for mental health related concerns)
• Structured Interviews of School Teachers
• Field Review of adolescents and youths participating in community-based outreach activities
• Structured Interview of Health Professionals'
  )
  ON CONFLICT DO NOTHING;

  RAISE NOTICE 'Health and Family Welfare Department and DLIs created successfully';
END $$;
