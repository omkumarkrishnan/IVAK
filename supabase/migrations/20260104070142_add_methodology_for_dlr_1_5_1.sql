/*
  # Add Verification Methodology for DLR 1.5.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 1.5.1 (5 partnerships formulated between PDD and private sector/social enterprises/technical partners)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of official documents
    - B. Structured Interviews
    
  3. Changes
    - Update methodology field for all verifications under DLR 1.5.1
*/

-- Update methodology for DLR 1.5.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of official documents

Desk Review of contract or MOU or agreement or equivalent of partnership with private sector agencies, social enterprises, and technical partners for checking the following:

a. Verify the government letterhead and authorized signatures on each document.
b. Ensure the documents are dated and have precise details regarding the participating parties above, like Private sector agencies, Social enterprises, and Technical Partners.
c. Count the total number of partnership agreements with Private sector agencies, Social Enterprises, and Technical Partners.

B. Structured Interviews

Structured interviews will be conducted with the PDD officials (and other stakeholders as relevant). A sample of five officials (per partnership) responsible for executing a contract, MOU, agreement, or equivalent of partnership documents (with private sector agencies, social enterprises, and/or technical partners) will be interviewed. The following details will be confirmed during the structured interview process:

a. Verify the scope and objectives outlined in each partnership
b. Verify the Roles and responsibilities of each partner.
c. Verify details on the activities to be undertaken by each partner.
d. Verify the financial commitments, resource allocation details, and corresponding deadlines.
e. Verify the non-financial commitments and corresponding deadlines.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 1.5.1');
