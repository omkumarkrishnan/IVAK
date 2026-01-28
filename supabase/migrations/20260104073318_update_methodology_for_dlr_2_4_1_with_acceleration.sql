/*
  # Update Verification Methodology for DLR 2.4.1 - Add Acceleration Services
  
  1. Purpose
    - Update verification methodology for DLR 2.4.1 to include acceleration services sections
    - Add sections C and D for desk review and telephonic verification of acceleration services
    
  2. New Sections Added
    - C. Desk Review of Approval Letter for Two Additional Acceleration Services
    - D. Telephonic Reviews for Verification of Acceleration Services
    
  3. Changes
    - Update methodology field to include complete verification process for both incubation and acceleration services
*/

-- Update methodology for DLR 2.4.1 verifications to include acceleration services
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
e. Percentage of share in ownership of youth (18-35) in enterprises

C. Desk Review of the Approval Letter for the Two Additional Acceleration Services

The IVA will verify the approval letter for the two additional acceleration services using the following process:

a. Government letterhead and authorized signatures on each document.
b. Financial commitments, resource allocation details, and deadlines.
c. Launch date of the Acceleration Services in non-farm sectors.

The IVA will verify the following aspects from the Activity Reports/Evaluation Studies on the establishment of 2 additional acceleration Services in the Non-Farm Sector:

a. Names of empanelled Service providers for Acceleration Services
b. Details of services offered (Mentorship, Training, Access to Investors, Linkage to Marketing, Administrative Assistance) by the respective service providers.

D. Telephonic Reviews for Verification of Acceleration Services

The IVA will verify through telephonic interviews the following aspects for 25 percent of the beneficiary enterprises chosen using stratified random sampling from the list of beneficiary enterprises:

I. Enterprise Level

a. Access to Mentorship (Name of Mentor)
b. Trainings attended:
   i. Name of the Training Programs
   ii. Dates of the Training Programs
c. Access to Investors (Name of Investors)
d. Linkage to Marketing (Facilitating contacts with retailers & bulk consumers, providing support for branding, Providing support for online marketing, and Presence of Marketing Staff)
e. Nature of Administrative Assistance provided by Incubation Service

I. Aggregate Level

a. Total number of owners in the beneficiary enterprise
b. Number of Women owners in the beneficiary enterprise
c. Percentage of share in ownership of women (capital holdings) in enterprise
d. Number of Youth (18-35) Owners in beneficiary enterprise
e. Percentage of share in ownership (capital holdings) of youth (18-35) in enterprise'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 2.4.1');
