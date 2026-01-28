/*
  # Add Verification Method to DLIs

  1. Changes
    - Add `verification_method` column to `dlis` table
    - Populate verification methods from the third column of the data requirements table
  
  2. Notes
    - Verification methods describe how each DLI will be verified
    - These are displayed below the "Verifications" subheading
*/

-- Add verification_method column
ALTER TABLE dlis 
ADD COLUMN IF NOT EXISTS verification_method text;

-- Update verification methods for each DLI
UPDATE dlis SET verification_method = 'Review of the GO on establishment of the Employment and Entrepreneurship Promotion Facility' WHERE code = 'DLR 1.0.1';

UPDATE dlis SET verification_method = E'• Desk Review\n• Structured Interviews' WHERE code = 'DLR 1.3.1';

UPDATE dlis SET verification_method = E'• Testing the functionality of CBP\n• Verification of Go Live Approval' WHERE code = 'DLR 1.3.2';

UPDATE dlis SET verification_method = E'• Scheme Integration Verification\n• Verification of Scheme Functionalities (at least three schemes)\n• Telephonic Review' WHERE code = 'DLR 1.4.1';

UPDATE dlis SET verification_method = E'• Desk Review\n• Structured Interviews' WHERE code = 'DLR 1.5.1';

UPDATE dlis SET verification_method = E'• Desk Review\n• MIS Review\n• Spot Checks\n• Certifications' WHERE code = 'DLR 1.5.2';

UPDATE dlis SET verification_method = E'• Spot Checks\n• Telephonic and Field Review\n• Proposed Deliverables' WHERE code = 'DLR 1.5.3';
