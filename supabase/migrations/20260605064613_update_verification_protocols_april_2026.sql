
-- DLR 1.5.3: Telephonic review sample reduced from 20% to 10%
UPDATE dlis SET verification_heading =
'• Spot Checks on 25% of trainees
• Telephonic Review of 10% of trainees (reduced from 20% per April 2026 MoM)
• Field Review of 20% of trainees'
WHERE code = 'DLR 1.5.3';

-- DLR 2.2.2: Telephonic review sample reduced from 25% to 10%; sample inclusive of incubation + acceleration beneficiaries
UPDATE dlis SET verification_heading =
'• Desk Review of Approval Letter for Incubation Services
• Desk Review of Activity Reports/Evaluation Studies on Incubation Services
• Desk Review of Approval Letter for Acceleration Services
• Desk Review of Activity Reports/Evaluation Studies on Acceleration Services
• Telephonic Review of 10% of beneficiaries (inclusive of incubation and acceleration service beneficiaries)'
WHERE code = 'DLR 2.2.2';

-- DLR 2.4.1: Telephonic review sample reduced from 25% to 10%; sample inclusive of incubation + acceleration beneficiaries
UPDATE dlis SET verification_heading =
'• Desk Review of Approval Letter for two additional Incubation Services
• Desk Review of Approval Letter for the Two Additional Acceleration Services
• Telephonic Review of 10% of beneficiaries (inclusive of incubation and acceleration service beneficiaries)'
WHERE code = 'DLR 2.4.1';

-- DLR 2.4.2: Telephonic review sample reduced from 25% to 10%
UPDATE dlis SET verification_heading =
'• Desk Review of Commercial Loans
• Telephonic Review of 10% of beneficiaries (reduced from 25% per April 2026 MoM)'
WHERE code = 'DLR 2.4.2';

-- DLR 2.5.2 (referred to as 2.5.1 in minutes for 8%): Telephonic review sample reduced from 25% to 10%
UPDATE dlis SET verification_heading =
'• Desk Review of Commercial Loans
• Telephonic Review of 10% of beneficiaries (reduced from 25% per April 2026 MoM)'
WHERE code = 'DLR 2.5.2';

-- DLR 3.2.1: As per PAD + additional telephonic review of 2% of homestays
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies
• Desk Review of Certification by T & CAD and other Departments
• Field Verification of 20% of Homestays
• Telephonic Review of 2% of homestays (added per April 2026 MoM)'
WHERE code = 'DLR 3.2.1';

-- DLR 4.2.1: Telephonic review sample reduced from 25% to 5%, inclusive of career counselling + placement support beneficiaries
UPDATE dlis SET verification_heading =
'• Desk Review of Approval Letter, Launch Letter and Activity Reports/Evaluation Studies
• Desk Review of MIS Data/Official Documents
• Telephonic Review of 5% of beneficiaries (including career counselling and placement support beneficiaries, reduced from 25% per April 2026 MoM)'
WHERE code = 'DLR 4.2.1';

-- DLR 4.3.1: Telephonic review sample reduced from 25% to 5%, inclusive of ongoing and certified trainees
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification
• Telephonic Review of 5% of trainees (inclusive of ongoing and certified trainees, reduced from 25% per April 2026 MoM)'
WHERE code = 'DLR 4.3.1';

-- DLR 4.4.1: Telephonic review sample reduced from 25% to 5%, inclusive of ongoing and certified trainees
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies on Skill Development Training, Assessment and Certification
• Telephonic Review of 5% of trainees (inclusive of ongoing and certified trainees, reduced from 25% per April 2026 MoM)'
WHERE code = 'DLR 4.4.1';

-- DLR 4.5.1: Telephonic review sample revised to 3-5% of male and female trainees each
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies on Placement
• Telephonic Review of 3–5% of male and female graduated trainees each (revised from 20% per April 2026 MoM; final sample size to be confirmed based on universe)'
WHERE code = 'DLR 4.5.1';

-- DLR 5.2.1: Protocol note on definition of "financing disbursed" to be clarified in stakeholder discussion
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies
• Desk Review of Intervention areas
• Field Review of 20% of total selected activities
Note: Definition of "financing disbursed" (department-to-district vs district-to-activity level) to be confirmed in dedicated stakeholder discussion (applies to DLR 5.2.1, 5.3.1, 5.4.1, 5.5.1)'
WHERE code = 'DLR 5.2.1';

-- DLR 5.3.1
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies
• Desk Review of Intervention Areas
• Field Review of 20% of total selected activities
Note: Definition of "financing disbursed" (department-to-district vs district-to-activity level) to be confirmed in dedicated stakeholder discussion (applies to DLR 5.2.1, 5.3.1, 5.4.1, 5.5.1)'
WHERE code = 'DLR 5.3.1';

-- DLR 5.4.1
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies
• Desk Review of Intervention Areas
• Field Review of 20% of total selected activities
Note: Definition of "financing disbursed" (department-to-district vs district-to-activity level) to be confirmed in dedicated stakeholder discussion (applies to DLR 5.2.1, 5.3.1, 5.4.1, 5.5.1)'
WHERE code = 'DLR 5.4.1';

-- DLR 5.5.1
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies
• Desk Review of Intervention Areas
• Field Review of 20% of total selected activities
Note: Definition of "financing disbursed" (department-to-district vs district-to-activity level) to be confirmed in dedicated stakeholder discussion (applies to DLR 5.2.1, 5.3.1, 5.4.1, 5.5.1)'
WHERE code = 'DLR 5.5.1';

-- DLR 6.3.1: Needs review pending HEZ discussions; protocol to be set once DLR form finalised
UPDATE dlis SET verification_heading =
'• Desk Review of Report on Pilot Study
• Desk Review of Report on internet connectivity
• Desk Review of Report on Users Accessing Internet Connectivity
• Field Review of 20% of Gram Panchayats
Note: Protocol subject to review in context of ongoing High Economic Zones (HEZ) discussions across districts; final verification protocol to be confirmed once DLR form is finalised (per April 2026 MoM)'
WHERE code = 'DLR 6.3.1';

-- DLR 7.2.1: As per PAD + additional field review of 10% of teachers
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies on Training of Teachers in Life Skills Education & in Undertaking Preliminary Screening for identifying Mental Health Related Concerns
• MIS Review
• Telephonic Review of 10% of teachers
• Field Review of 10% of teachers (added per April 2026 MoM)'
WHERE code = 'DLR 7.2.1';

-- DLR 7.5.1: Telephonic review sample reduced from 20% to 10%
UPDATE dlis SET verification_heading =
'• Desk Review
• MIS Review
• Telephonic Review of 10% of beneficiaries (reduced from 20% per April 2026 MoM)'
WHERE code = 'DLR 7.5.1';

-- DLR 8.3.1: Telephonic review sample reduced from 20% to 10%; spot checks added at 10%
UPDATE dlis SET verification_heading =
'• Desk Review
• Telephonic Review of 10% of beneficiaries (reduced from 20% per April 2026 MoM)
• Spot Checks of 10% of beneficiaries (added per April 2026 MoM)'
WHERE code = 'DLR 8.3.1';

-- DLR 8.3.2: Telephonic review sample reduced from 25% to 2-5%
UPDATE dlis SET verification_heading =
'• Desk Review of Approval Letter of Migration Support Services guideline and its launch
• Telephonic Review of 2–5% of beneficiaries (reduced from 25% per April 2026 MoM)'
WHERE code = 'DLR 8.3.2';

-- DLR 8.4.1: Telephonic review sample reduced from 20% to 10%; spot checks added at 10%
UPDATE dlis SET verification_heading =
'• Desk Review
• Telephonic Review of 10% of beneficiaries (reduced from 20% per April 2026 MoM)
• Spot Checks of 10% of beneficiaries (added per April 2026 MoM)'
WHERE code = 'DLR 8.4.1';

-- DLR 8.5.1: Telephonic review sample reduced from 30% to 10%; spot checks added at 10%
UPDATE dlis SET verification_heading =
'• Desk Review of Activity Reports/Evaluation Studies
• MIS Review
• Telephonic Review of 10% of beneficiaries (reduced from 30% per April 2026 MoM)
• Spot Checks of 10% of beneficiaries (added per April 2026 MoM)'
WHERE code = 'DLR 8.5.1';
