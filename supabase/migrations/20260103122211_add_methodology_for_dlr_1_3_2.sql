/*
  # Add Verification Methodology for DLR 1.3.2

  1. Purpose
    - Populate the methodology field for DLR 1.3.2 verifications
    - DLR 1.3.2: "PDD has created a Centralized Beneficiary Platform (CBP) for planning and monitoring the delivery of benefits and services for the economic inclusion of women and youth."
  
  2. Methodology Content
    - Contains detailed verification methodology including:
      - Testing the functionality of CBP (2 verification points)
      - Verification of Go Live Approval (9 verification points)
*/

UPDATE verifications
SET methodology = 'A. Testing the functionality of CBP

a. Verify the Website address provided for the CBP portal

b. Validate the authentication procedures for accessing the CBP


B. Verification of Go Live Approval

a. PDD to provide the approval letter received for the go-live of CBP

b. Check the listing of the CBP portal address in STQC of GoI website

c. Request PDD to provide contract document with FRS & SRS prepared for CBP

d. Confirm specifications required for compliance of FRS & SRS with CBP using Contract Document

e. Request PDD to provide the Security Audit Certificate for CBP

f. Verify the Security Audit Certificate

g. Request that PDD provide a report on the training of GoS staff on CBP operation.

h. Verify report on training of GoS staff on CBP operation

i. Verify for adequacy the number of GoS officials trained to operate the CBP'
WHERE dli_id IN (
  SELECT id FROM dlis WHERE code = 'DLR 1.3.2'
);