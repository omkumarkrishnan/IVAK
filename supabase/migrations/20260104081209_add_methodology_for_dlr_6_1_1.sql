/*
  # Add Verification Methodology for DLR 6.1.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 6.1.1 (Feasibility study conducted by Information Technology Department for establishing connectivity across the State)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Feasibility Study Report
    
  3. Changes
    - Update methodology field for all verifications under DLR 6.1.1
*/

-- Update methodology for DLR 6.1.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Feasibility Study Report

The IVA will review the feasibility study report for checking the following aspects:

a. Confirm the date of feasibility study report
b. Verify the scope and objectives
c. Confirm that the report has details on Baseline Internet Connectivity Situation in each district
d. Confirm that the report includes an assessment of the digital connectivity implementation initiative already undertaken in Soreng district and documents the lessons learnt from its implementation.
e. Confirm that the report has a technology option analysis (Technology Feasibility, Economic Feasibility, Operational feasibility, Market Feasibility, Management Feasibility, Legal Feasibility and Risk Assessment)
f. Confirm that the report provides recommendations for each district including details on mixed technology approach by combination of relevant technologies for each district (as relevant).
g. Confirm the report provides the implementation plan along with the benefits and costs.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 6.1.1');
