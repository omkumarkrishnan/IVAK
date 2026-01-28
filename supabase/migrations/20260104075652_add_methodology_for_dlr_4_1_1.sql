/*
  # Add Verification Methodology for DLR 4.1.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 4.1.1 (Four Training Providers/Partners empanelled by SICB/SDD to deliver both technical and non-cognitive skill training in priority sectors)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of GO or Circular or Memorandum
    
  3. Changes
    - Update methodology field for all verifications under DLR 4.1.1
*/

-- Update methodology for DLR 4.1.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of GO or Circular or Memorandum

a. Verify the government letterhead and authorized signatures on each document.
b. Confirm that the documents are dated and specify the partnership duration.
c. Confirm that the documents have the names of the specified participating Training Providers and Partners
d. Verify the scope and objectives outlined in each partnership.
e. Verify the Roles and responsibilities of each Training Providers & Partner.
f. Verify details on the activities to be undertaken by each Training Providers & Partner.
g. Confirm the Priority Sectors covered by Training Providers & Partners
h. Confirm the Technical Skills and Non-Cognitive Skills included in training by Training Providers & Partners
i. Verify the Financial commitments, resource allocation details and deadlines.
j. Verify the non-financial commitments and deadlines.
k. Count the total number of partnership agreements between Training Providers & Partners
l. Verify the issue date and Validity of Accreditation certificates issued by training agency on behalf of respective sector skill councils authenticated by NSDC'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 4.1.1');
