/*
  # Add Verification Methodology for DLR 2.2.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 2.2.1 (C&ID has created an Innovation Hub)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review
    - B. Physical Verification of the Innovation Hub
    
  3. Changes
    - Update methodology field for all verifications under DLR 2.2.1
*/

-- Update methodology for DLR 2.2.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review

The IVA will verify the following aspects based on the available GO, Circular, or MOU and Activity Reports/Evaluation Studies on the establishment of the Innovation Hub:

a. Government letterhead and authorized signatures on each document.
b. Date of the GO or Circular or MOU
c. Documents have precise details regarding establishing the Innovation Hub.
d. Scope and objectives of the Innovation Hub
e. Starting date of the Innovation Hub
f. Functions and services of the Innovation Hub
g. Activity Plan and timeframe.

The IVA will verify the following aspects based on the available Job Notifications with the roles and qualifications:

a. Adequacy of the number of positions, qualification details, experience details, and job profiles of the appointed staff for the following posts using the job roles and qualification details provided by C & ID
b. Technical Experts available at the Innovation Hub (Entrepreneurship Development, Women''s Economic Empowerment, Finance, Marketing & Training)
c. Administrative Staff available at the Innovation Hub
d. Online website location.

The IVA will verify the roles and qualifications of the appointed staff for the following posts using the Job roles and qualification details provided by C & ID:

a. Technical Experts (Entrepreneurship Development, Women''s Economic Empowerment, Finance, Marketing & Training)
b. Administrative Staff

B. Physical Verification of the Innovation Hub

The IVA to verify the staff on roll and employees present at Innovation Hub using the Staff Register and appointment log book.

The IVA to check the infrastructure facilities provided in the Innovation Hub on the following aspects:

a. Accessibility to Innovation Hub
b. Internet Connectivity
c. Type of devices fused for digital connectivity (Computers & Accessories)
d. Meeting space (Capacity & Usage)
e. Number of computers
f. Number of digital projectors
g. Details of the Co-working Space (Capacity, Number of Seats/Desks/ other furniture details Utilization)'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 2.2.1');
