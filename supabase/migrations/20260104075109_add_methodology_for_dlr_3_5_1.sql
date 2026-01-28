/*
  # Add Verification Methodology for DLR 3.5.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 3.5.1 (60% of trained women-led homestays have adopted digital marketing and/or digital payment tools)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of adoption of Digital Marketing
    - B. Field Review of Digital Marketing Adoption
    - C. Desk Review of adoption of Digital Payment Tools
    - D. Field Review of Adoption of Digital Payment Tools
    
  3. Changes
    - Update methodology field for all verifications under DLR 3.5.1
*/

-- Update methodology for DLR 3.5.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of adoption of Digital Marketing

The IVA will verify the percentage of women-led homestay owners who have adopted Digital marketing tools.

B. Field Review of Digital Marketing Adoption

The IVA will verify twenty-five percent of the random sample of trained women-led homestay owners/managers through field review on the following aspects:

a. Name of the homestay owner/manager
b. Location of the homestay (Urban/Rural)
c. Name of the District
d. Use of Digital Channels for marketing products and services
   - Website
   - Social media promotion such as Instagram, X, Facebook, etc.
   - Onboarding to Aggregators Platforms like Makemytrip, Triavago etc.
   - Search Engine Optimization for Google, Bing etc
   - Mobile Messaging Services
   - Emails
e. Increase in bookings after adoption of digital marketing.
f. Improvement on lead generations after adoption of digital marketing.
g. Enhancement in conversion of leads to customers

The IVA will validate the respective digital channels by checking the URL, Email communication, social media presence, mobile messages, search engine management during field reviews.

Usage of any one of the digital channels by homestays will be classified under adoption of digital marketing

C. Desk Review of adoption of Digital Payment Tools

The IVA will verify the percentage of women-led homestay owners who have adopted digital payment tools.

D. Field Review of Adoption of Digital Payment Tools

The IVA will verify twenty-five percent of the random sample of trained women-led homestay owners/managers through field review on the following aspects:

a. Name of the homestay owner/manager
b. Location of the homestay (Urban/Rural)
c. Name of the District
d. Use of Digital Payment tools for products and services
   - use of banking cards (Credit/Debit)
   - UPI
   - mobile wallets
   - internet banking
   - mobile banking
   - any other payment tools
e. Ease of realizing payments after the adoption of digital payment tools

The IVA will validate the usage of the respective digital payment tools by checking the transaction details during field reviews.

The validation will include at least two transactions and the tools used.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 3.5.1');
