/*
  # Add Verification Methodology for DLR 3.2.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 3.2.1 (T&CAD has established the gender-disaggregated baseline of homestay owners)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Activity Reports/Evaluation Studies
    - B. Desk Review of Certification by T&CAD and other Departments
    - C. Field Verification of Homestays
    
  3. Changes
    - Update methodology field for all verifications under DLR 3.2.1
*/

-- Update methodology for DLR 3.2.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Activity Reports/Evaluation Studies

The IVA will confirm the following aspects available from the homestay details with the T&CAD Activity Reports/Evaluation Studies on homestays:

a. No. of Registered Homestays
b. No. of Homestays registered with T&CAD
c. No. of Homestays registered with other depts.
d. No. of non-registered homestays
e. No. of homestays owned by women
f. No. of fully owned homestays
g. No. of Partially owned homestays
h. No. of co-owners
i. No. of Homestays in Urban area
j. No. of Homestays in Rural area
k. Total Investment Size (Homestays)

B. Desk Review of Certification by T & CAD and other Departments

The IVA to verify the following aspects:

a. Homestay Name
b. Homestay Owners name
c. Gender of Owner
d. Date of registration.
e. Location of Homestay (Rural/Urban)
f. Ownership Status (Full/Partial)

C. Field Verification of Homestays

The IVA will conduct a field verification for the 20 percent randomly selected sample of Homestays and verify the following aspects:

a. Name of Homestay
b. Name of the Owner
c. Education level of Owner
d. Ownership status (Full/Partial)
e. No of co-owners
f. Gender of Owner/Co-owner
g. Date of registration.
h. Location of Homestay (Rural/Urban)
i. Year of establishment
j. No. of guests (in the last calendar year)
k. Days of occupancy (last calendar year)
l. No. of full-time employees
m. No. of part-time employees
n. No of paid employees
o. No. of unpaid employees
p. Registration details
q. No. of rooms
r. No. of beds'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 3.2.1');
