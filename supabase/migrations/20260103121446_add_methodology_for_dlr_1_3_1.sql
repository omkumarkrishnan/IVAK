/*
  # Add Verification Methodology for DLR 1.3.1

  1. Purpose
    - Populate the methodology field for DLR 1.3.1 verifications
    - DLR 1.3.1: "Two partnerships formulated between the PDD and private sector, social enterprises, and/or technical partners."
  
  2. Methodology Content
    - Contains detailed verification methodology including:
      - Desk Review procedures (10 verification points)
      - Structured Interview procedures (5 verification points)
*/

UPDATE verifications
SET methodology = 'A. Desk Review of the contract or MOU or agreement or equivalent will be undertaken for checking the following:

a. Verify the government letterhead and authorized signatures on each document.

b. Confirm that the documents are dated and specify the duration of the partnership.

c. Confirm that the documents have precise details regarding participating parties like Private sector agencies, Social Enterprises, and Technical Partners.

d. Verify the scope and objectives outlined in each partnership.

e. Verify the time frame of the partnership.

f. Verify the Roles and responsibilities of each partner.

g. Verify details on the activities to be undertaken by each partner.

h. Verify the financial commitments, resource allocation details, and corresponding deadlines.

i. Verify the non-financial commitments and corresponding deadlines.

j. Review the total number of partnership agreements with Private sector agencies, social enterprises, and Technical Partners.


B. Structured Interviews

a. Structured interviews will be conducted with the PDD officials (and other stakeholders as relevant). A sample of five officials (per partnership) executing a contract, MOU, agreement, or equivalent of partnership documents will be interviewed. The following details will be confirmed during the structured interview: Verify the scope and objectives outlined in each partnership contract, MOU, agreement, or equivalent.

b. Verify the roles and responsibilities of each partner.

c. Verify details on the activities to be undertaken by each partner.

d. Verify the financial commitments, resource allocation details, and corresponding deadlines.

e. Verify the non-financial commitments and corresponding deadlines.'
WHERE dli_id IN (
  SELECT id FROM dlis WHERE code = 'DLR 1.3.1'
);