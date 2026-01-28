/*
  # Add Verification Methodology for DLR 7.3.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 7.3.2 (Update to mobile app on mental health launched by the H&FWD)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Approval Letter for Updated Mobile App
    - B. System Review of App Updation
    
  3. Changes
    - Update methodology field for all verifications under DLR 7.3.2
*/

-- Update methodology for DLR 7.3.2 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Approval Letter for Updated Mobile App

The IVA will verify the following aspects of the approval letter on Mobile App containing the list of updated features:

a. Verify the government letterhead and authorized signatures.
b. Review approval for go-live of the updated Mobile App.
c. Review the details related to updated features of Mobile App.

B. System Review of App Updation

The IVA will review the functionality of all the enhancements of the App specified in the approval letter, including the following components:

a. Availability in languages in addition to English
b. Contents available in offline
c. Additions to self-screening tools
d. Additions to generic advisory
e. Compatibility with additional operating systems
f. Verify Emergency contact numbers listed and test through calls.
g. Verify data analytics on app use provided by the App store (e.g., Google Play Console).
h. Undertake a dummy usage of the App to ensure that all the functionalities are working as envisaged.

The IVA will also review the following aspects:

a. Growth in user base of the App as evidenced by downloads from the online app store.
b. User feedback and rating provided by users on the online app store.

The IVA will review the following aspects:

a. Growth in user base in terms of usage of self-screening services across periods since date of launch
b. User feedback related to self-screening services.

Note: Data from Google Play store does not provide exact number of downloads but only indicates an aggregate number like 500 plus downloads'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 7.3.2');
