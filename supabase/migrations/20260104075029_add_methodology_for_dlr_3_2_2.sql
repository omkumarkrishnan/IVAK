/*
  # Add Verification Methodology for DLR 3.2.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 3.2.2 (10% of women-led homestays received training in business management and digital marketing skills by T&CAD)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Training on Business Management & Digital Marketing
    - B. Field Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 3.2.2
*/

-- Update methodology for DLR 3.2.2 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Training on Business Management & Digital Marketing

The IVA will verify the following:

a. The percentage of women-led homestay owners who are trained in Business Management Skills
b. The percentage of women-led homestay owners who are trained in Digital Marketing Skills

B. Field Review

The IVA will verify the following aspects on 20 percent of the random sample of women-led Homestay owners from the list of all women-led homestay owners provided by T& CAD:

a. Name of the Homestay Owner
b. Status of Training on Business Management and Digital Marketing (Yes/No)
c. Type of Trainee (Owner/Manager)
d. Dates of the Training Program on Business Management and Digital Marketing
e. Subject of Training on Business Management Skills
f. Content Covered in Training Modules on Business Management
g. Post-training application of learnings in Business management
   - Pricing
   - Reservation Management
   - Customer Service
   - Staff Training & Management
h. Subject of Training on Digital Marketing Skills
i. Content Covered in Training Modules on Digital Marketing
j. Post-training application of learnings in Digital Marketing
   - Website Development
   - Social Media Promotion
   - Onboarding to Aggregators Platforms
   - Search Engine Optimization
   - Mobile Messaging Services
   - Emails'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 3.2.2');
