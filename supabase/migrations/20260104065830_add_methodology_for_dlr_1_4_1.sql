/*
  # Add Verification Methodology for DLR 1.4.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 1.4.1 (CBP functional with integration of at least three schemes)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Scheme Integration Verification
    - B. Verification of Scheme Functionalities (at least three schemes)
    - C. Validation of Support Received
    
  3. Changes
    - Update methodology field for all verifications under DLR 1.4.1
*/

-- Update methodology for DLR 1.4.1 verifications
UPDATE verifications
SET methodology = 'A. Scheme Integration Verification

a. PDD will be requested to provide access to the CBP portal for IVA review.
b. IVA to verify the number and names of schemes available in the CBP portal
c. IVA will Cross-check the list of availed schemes and support details provided by PDD with the information available in the CBP portal.

B. Verification of Scheme Functionalities (at least three schemes)

From the detailed list of schemes submitted from the CBP portal/ official documents, the IVA will verify the following scheme functionalities:

a. Number of Schemes (At least three schemes)
b. Name of each scheme.
c. Description of the scheme.
d. Duration of the scheme.
e. Eligibility criteria associated with each scheme.
f. Number of Current Beneficiaries for each Scheme
g. Details of Beneficiaries from each scheme (Age, Gender, Contact Details)
h. Amount of Financial Support received by each beneficiary per scheme
i. Non-financial support received by each beneficiary per scheme

C. Validation of Support Received

IVA will undertake telephonic interviews using a random sample of 25 percent of beneficiaries selected from the above table for each of the schemes and validate the following details:

a. Financial support details match the records in the CBP portal for the three schemes.
b. Non-financial support is listed in the CBP portal against documented evidence provided by PDD.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 1.4.1');
