/*
  # Create Tourism and Civil Aviation Department and DLI Records

  1. New Department
    - Tourism and Civil Aviation Department
  
  2. New DLI Records
    - DLR 3.0.1: IMF completes inspection of IHCAE for granting recognition (Period 0)
    - DLR 3.0.2: IHCAE receives recognition from IMF (Period 0)
    - DLR 3.2.1: T&CAD has established the gender disaggregated baseline of homestay (Period 2)
    - DLR 3.2.2: 10 percent of women-led homestays received training in business management and digital marketing skills by T&CAD (Period 2)
    - DLR 3.3.1: 20 percent of women-led homestays received training in business management and digital marketing skills by T&CAD (cumulative) (Period 3)
    - DLR 3.5.1: 60 percent of trained women-led homestays have adopted digital marketing and/or digital payment tools (Period 5)
  
  3. Verification Headings
    - All verification headings populated from the screenshot data (third column)
*/

-- Create Tourism and Civil Aviation Department
INSERT INTO departments (name)
VALUES ('Tourism and Civil Aviation Department')
ON CONFLICT DO NOTHING;

-- Get the department ID and period IDs for use in DLI insertions
DO $$
DECLARE
  tourism_dept_id uuid;
  period_0_id uuid;
  period_2_id uuid;
  period_3_id uuid;
  period_5_id uuid;
BEGIN
  -- Get the department ID
  SELECT id INTO tourism_dept_id FROM departments WHERE name = 'Tourism and Civil Aviation Department';
  
  -- Get period IDs
  SELECT id INTO period_0_id FROM periods WHERE name = 'Period 0';
  SELECT id INTO period_2_id FROM periods WHERE name = 'Period 2';
  SELECT id INTO period_3_id FROM periods WHERE name = 'Period 3';
  SELECT id INTO period_5_id FROM periods WHERE name = 'Period 5';
  
  -- Insert DLR 3.0.1 (Period 0)
  INSERT INTO dlis (department_id, period_id, code, description, verification_heading)
  VALUES (
    tourism_dept_id,
    period_0_id,
    'DLR 3.0.1',
    'IMF completes inspection of IHCAE for granting recognition',
    '• Review of the official document from the IMF conveying the completion of the inspection of IHCAE'
  )
  ON CONFLICT DO NOTHING;
  
  -- Insert DLR 3.0.2 (Period 0)
  INSERT INTO dlis (department_id, period_id, code, description, verification_heading)
  VALUES (
    tourism_dept_id,
    period_0_id,
    'DLR 3.0.2',
    'IHCAE receives recognition from IMF',
    '• Review of the official document from the IMF conveying the completion of the inspection of IHCAE'
  )
  ON CONFLICT DO NOTHING;
  
  -- Insert DLR 3.2.1 (Period 2)
  INSERT INTO dlis (department_id, period_id, code, description, verification_heading)
  VALUES (
    tourism_dept_id,
    period_2_id,
    'DLR 3.2.1',
    'T&CAD has established the gender disaggregated baseline of homestay',
    '• Desk Review of Activity Reports/Evaluation Studies
• Desk Review of Certification by T & CAD and other Departments
• Field Verification of Homestays'
  )
  ON CONFLICT DO NOTHING;
  
  -- Insert DLR 3.2.2 (Period 2)
  INSERT INTO dlis (department_id, period_id, code, description, verification_heading)
  VALUES (
    tourism_dept_id,
    period_2_id,
    'DLR 3.2.2',
    '10 percent of women-led homestays received training in business management and digital marketing skills by T&CAD',
    '• Desk Review of Training on Business Management & Digital Marketing
• Field Review'
  )
  ON CONFLICT DO NOTHING;
  
  -- Insert DLR 3.3.1 (Period 3)
  INSERT INTO dlis (department_id, period_id, code, description, verification_heading)
  VALUES (
    tourism_dept_id,
    period_3_id,
    'DLR 3.3.1',
    '20 percent of women-led homestays received training in business management and digital marketing skills by T&CAD (cumulative)',
    '• Desk Review of Training on Business Management & Digital Marketing
• Field Review'
  )
  ON CONFLICT DO NOTHING;
  
  -- Insert DLR 3.5.1 (Period 5)
  INSERT INTO dlis (department_id, period_id, code, description, verification_heading)
  VALUES (
    tourism_dept_id,
    period_5_id,
    'DLR 3.5.1',
    '60 percent of trained women-led homestays have adopted digital marketing and/or digital payment tools',
    '• Desk Review of adoption of Digital Marketing
• Field Review of Digital Marketing Adoption
• Desk Review of adoption of Digital Payment Tools
• Desk Review of adoption of Digital Payment Tools'
  )
  ON CONFLICT DO NOTHING;
END $$;
