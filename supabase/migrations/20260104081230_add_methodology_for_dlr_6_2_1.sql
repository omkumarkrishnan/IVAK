/*
  # Add Verification Methodology for DLR 6.2.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 6.2.1 (ITD has prepared the State Data Policy and compliance plan)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of State Data Policy
    - B. Desk Review of the Compliance Plan
    
  3. Changes
    - Update methodology field for all verifications under DLR 6.2.1
*/

-- Update methodology for DLR 6.2.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of State Data Policy

The IVA will review the State Data Policy on the following aspects:

a. Verify the government letterhead and authorized signatures
b. Verify the supporting procedures to manage Information Assets
c. Verify the governing structures to manage Information Assets
d. Verify that the following are included as a minimum in the state data policy: objectives, need for the policy, scope of the policy, benefits of the policy, data classification, type of data access, pricing, legal framework, sharing and access protocols, implementation mechanism, institutional arrangements, committees to be formed, budget provisions among others.
e. Review the alignment of SDP with Digital Data Protection Bill, 2023
f. Confirm the inclusion of Frameworks for Quality Assurance

B. Desk Review of the Compliance Plan

The IVA will confirm the compliance on the following:

a. Verify Standard Operating Procedures (SOP) outlined in the Compliance Plan
b. Verify Compliance of SOP with SDP
c. Confirm the Compliance with Citizens Right to Privacy (Digital Data Protection Bill, 2023)'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 6.2.1');
