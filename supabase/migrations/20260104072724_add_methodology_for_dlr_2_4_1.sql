/*
  # Add Verification Methodology for DLR 2.4.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 2.4.1 (4 incubation or acceleration services established - cumulative)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Approval Letter for two additional Incubation Services
    - B. Telephonic Reviews for Verification of Incubation Services
    
  3. Changes
    - Update methodology field for all verifications under DLR 2.4.1
*/

-- Update methodology for DLR 2.4.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of the Approval Letter for two additional Incubation Services

The IVA will verify the following aspects from the approval letters for the establishment of 2 additional Incubation Services in the Non-Farm Sector:

a. Government letterhead and authorized signatures on each document.
b. Financial commitments, resource allocation details, and deadlines
c. Launch date of the Incubation Services in non-farm sectors.

The IVA will verify the following aspects from the Activity Reports/Evaluation Studies on the establishment of 2 additional Incubation Services in the Non-Farm Sector:

a. Names of empanelled Service providers for Incubation Services
b. Details of services offered (Mentorship, Training, Access to Investors, Linkage to Marketing, Administrative Assistance) by the respective service providers

B. Telephonic Reviews for Verification of Incubation Services

The IVA will verify the following aspects for 25 percent of the beneficiary enterprises chosen using stratified random sampling from the list of beneficiary enterprises through telephonic interviews:

I. Enterprise Level

a. Access to Mentorship (Name of Mentor)
b. Trainings attended:
   i. Name of the Training Programs
   ii. Dates of the Training Programs
c. Access to Investors (Name of Investors)
d. Linkage to Marketing (Facilitating contacts with retailers & bulk consumers, providing support for branding, Providing support for online marketing, and Presence of Marketing Staff)
e. Nature of Administrative Assistance provided by Incubation Service

II. Aggregate Level

a. Total number of owners in beneficiary enterprises
b. Number of Women owners in beneficiary enterprises
c. Percentage of share in ownership of women in enterprises
d. Number of Youth (18-35) owners in beneficiary enterprises
e. Percentage of share in ownership of youth (18-35) in enterprises'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 2.4.1');
