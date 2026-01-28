/*
  # Add Verification Methodology for DLR 8.1.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 8.1.1 (3 Partnerships established on childcare, reproductive health, and geriatric care, by PDD in coordination with SDD, H&FWD, and WCDD)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Contract, MOU, Agreement or Equivalent
    - B. Structured interviews
    
  3. Changes
    - Update methodology field for all verifications under DLR 8.1.1
*/

-- Update methodology for DLR 8.1.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Contract, MOU, Agreement or Equivalent

The IVA will review contract, MOU, agreement or equivalent for checking the following aspects:

a. Verify the government letterhead and authorized signatures on each document.
b. Confirm that the documents are dated and specify the partnership duration.
c. Confirm that the documents have clear details regarding participating parties like Sector Skills Councils and other government and private institutions, as applicable
d. Verify the scope and objectives outlined in each partnership.
e. Verify the Roles and responsibilities of each partner.
f. Verify details on the activities to be undertaken by each partner.
g. Verify the Financial commitments, resource allocation details and deadlines.
h. Verify the non-financial commitments and deadlines.
i. Verify how many partnerships are for quality caregiving for childcare and/or reproductive health and/or geriatric care
j. Verify how many partnerships are with private and semi-private institutions of repute.
k. Count the total number of partnership agreements with Sector Skills Councils and other government and private institutions etc.

B. Structured interviews

Structured interviews will be conducted with the PDD officials (and other stakeholders as relevant). A sample of five officials (per partnership) executing a contract, MOU, agreement, or equivalent of partnership documents will be interviewed. The following details will be confirmed during the structured interview:

a. Verify the scope and objectives outlined in each partnership contract, MOU, agreement, or equivalent.
b. Verify the roles and responsibilities of each partner.
c. Verify details on the activities to be undertaken by each partner.
d. Verify the financial commitments, resource allocation details, and corresponding deadlines.
e. Verify the non-financial commitments and corresponding deadlines.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 8.1.1');
