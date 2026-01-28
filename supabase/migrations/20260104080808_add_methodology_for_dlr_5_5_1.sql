/*
  # Add Verification Methodology for DLR 5.5.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 5.5.1 (60 percent financing disbursed in each district as per the district-level IEIAPs - cumulative)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Activity Reports/Evaluation Studies
    - B. Desk Review of Intervention Areas
    - C. Field Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 5.5.1
*/

-- Update methodology for DLR 5.5.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Activity Reports/Evaluation Studies

The IVA will verify the district wise data from SIFMS Report on disbursements with IEIAP Schemes on Comprehensive business support to Self Help Groups (SHG) & Youth Enterprises, Rural Tourism and Eco Tourism.

B. Desk Review of Intervention Areas

The IVA will verify the district wise data from SIFMS Report on the intervention areas.

C. Field Review

The IVA will select a list of activities (20 percent sample) from the 13 activities and any other activities covering 6 districts.

The IVA will undertake site visits and interact with concerned representatives for schemes at state, district and village-level to verify the following:

a. Verify the designation of the concerned official.
b. Physical Assets and support for Infrastructure upgradation created for the various activities based on the disbursed fund.
c. Any other support for enterprises covered

The IVA will verify (20 percent sample) the following aspects based on an interaction with the scheme beneficiaries through a field visit to the respective activity site:

I. Activity Name
II. Intervention Area
III. District
IV. Starting date of Activity
V. Status of Activity (Work in Progress, Completed)
VI. Receipt of Disbursed Activity funds (Bank Details)'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 5.5.1');
