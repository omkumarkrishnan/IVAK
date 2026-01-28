/*
  # Add Verification Methodology for DLR 7.0.1
  
  1. Purpose
    - Add verification methodology for DLR 7.0.1 (Mobile App on mental health awareness and service delivery linkages launched by the H&FWD)
    - Note: The prior result of DLI 7 may be treated as achieved
    
  2. Changes
    - Update methodology field for all verifications under DLR 7.0.1
*/

-- Update methodology for DLR 7.0.1 verifications
UPDATE verifications
SET methodology = 'The prior result of DLI 7 may be treated as achieved.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 7.0.1');
