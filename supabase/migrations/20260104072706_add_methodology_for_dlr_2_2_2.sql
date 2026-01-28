/*
  # Add Verification Methodology for DLR 2.2.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 2.2.2 (2 Incubation or acceleration services established)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Approval Letter for Incubation Services
    - B. Desk Review of Activity Reports on Incubation Services
    - C. Telephonic Reviews for Verification of Incubation Services
    - D. Desk Review of Approval Letter for Acceleration Services
    - E. Desk Review of Activity Reports on Acceleration Services
    - F. Telephonic Reviews for Verification of Acceleration Services
    
  3. Changes
    - Update methodology field for all verifications under DLR 2.2.2
*/

-- Update methodology for DLR 2.2.2 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of the Approval Letter for Incubation Services

The IVA will verify the following aspects based on the available approval letters for the establishment of 2 Incubation Services in the Non-Farm Sector:

a. Government letterhead and authorized signatures on each document.
b. Financial commitments, resource allocation details, and deadlines.
c. Launch date of the incubation services in non-farm sectors.

B. Desk Review of Activity Reports/Evaluation Studies on Incubation Services

The IVA will cross-verify the following aspects based on the available reports on the establishment of 2 Incubation Services in the Non-Farm Sector:

a. Names of empanelled Service providers for Incubation Services
b. Details of services offered (Mentorship, Training, Access to Investors, Linkage to Marketing, Administrative Assistance) by the respective service providers
c. The objective of the Incubation Service Provided
d. Provide the details of the external service provided and its sub-services (for example, for linkage to marketing, the Activity Reports/Evaluation Studies needs to give details on the type of marketing linkages (digital marketing/ participation in buyer-seller meets/supplier contracts with established retailers, etc.) provided for various sub-sectors.
e. Other Services Being Provided
f. The mode in which mentorship is being provided: (Virtual/Offline/ Blended/ NA)
g. The mode in which Trainings (Virtual/Offline/ Blended/ NA) Service Provided
h. How is Access to Investors being provided (Virtual/Offline/ Blended/ NA)
i. Linkage to Marketing (Virtual/Offline/ Blended/ NA)
j. Administrative Assistance provided (Virtual/Offline/ Blended/ NA)
k. Area Serviced
l. Date of Launch of specific services
m. The outreach of service with the number of beneficiaries served by each service
n. What has been the Impact of service (mention particular benefits from the service provision to beneficiaries)

C. Telephonic Reviews for Verification of Incubation Services

The IVA will verify the following aspects for 25 percent of selected beneficiary enterprises chosen using stratified random sampling from the list of beneficiary enterprises through telephonic interviews:

Enterprise Level:
a. Access to Mentorship (Name of Mentor)
b. Training attended - Name of the Training Programs, Dates of the Training Programs
c. Access to Investors (Name of Investors)
d. Linkage to Marketing (Facilitating contacts with retailers & bulk consumers, support for branding, support for online marketing, etc.)
e. Nature of administrative assistance provided by Incubation Service

Aggregate Level:
a. Total Number of Owners in Beneficiary Enterprise
b. Number of Women Owners in Beneficiary Enterprise
c. Percentage of Share in Ownership(capital) of Women in Enterprise
d. Number of Youth (18-35) Owners in beneficiary enterprise
e. Percentage of Share in Ownership (capital) of Youth (18-35) in enterprise

D. Desk Review of the Approval Letter for Acceleration Services

The IVA will verify the following aspects based on the available approval letters for the establishment of 2 Acceleration Services in the Non-Farm Sector:

a. Government letterhead and authorized signatures on each document.
b. Financial commitments, resource allocation details, and deadlines
c. Launch date of the Acceleration Services in non-farm sectors.

E. Desk Review of Activity Reports/Evaluation Studies on Acceleration Services

The IVA will cross-verify the following aspects based on the available Activity Reports/Evaluation Studies on the establishment of 2 Acceleration Services in the Non-Farm Sector:

a. Names of empanelled Service providers for Acceleration Services
b. The objective of acceleration services provided
c. Provide the details of the service provided and its sub-services
d. The mode in which mentorship is being provided: (Virtual/Offline/ Blended/ NA)
e. Other Services Being Provided
f. The mode in which Trainings (Virtual/Offline/ Blended/ NA) Service Provided
g. How is Access to Investors being provided (Virtual/Offline/ Blended/ NA)
h. Service Provided: Linkage to Marketing (Virtual/Offline/ Blended/ NA)
i. Administrative Assistance provided (Virtual/Offline/ Blended/ NA)
j. Area Serviced
k. Date of Launch of specific services
l. The outreach of service with the number of beneficiaries served by each service
m. What has been the Impact of service (mention particular benefits from the service provision to beneficiaries)

F. Telephonic Reviews for Verification of Acceleration Services

The IVA will verify the following aspects for 25 percent of the beneficiary enterprises chosen using stratified random sampling through telephonic interviews:

Enterprise Level:
a. Access to Mentorship (Name of Mentor)
b. Trainings attended - Name and Dates of Training Programs
c. Access to Investors (Name of Investors)
d. Linkage to Marketing (Facilitating contacts with retailers & bulk consumers, providing support for branding, support for online marketing, and Presence of Marketing Staff)
e. Nature of Administrative Assistance provided

Aggregate Level:
a. Total number of owners in beneficiary enterprises
b. Number of Women owners in beneficiary enterprises
c. Percentage of share in ownership of women in enterprises
d. Number of Youth (18-35) owners in beneficiary enterprises
e. Percentage of share in ownership of youth (18-35) in enterprises'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 2.2.2');
