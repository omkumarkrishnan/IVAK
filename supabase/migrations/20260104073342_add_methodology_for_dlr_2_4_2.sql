/*
  # Add Verification Methodology for DLR 2.4.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 2.4.2 (5% of women-led/youth-led enterprises supported under SYSS secure commercial loans)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Commercial Loans
    - B. Telephonic Review of Commercial Loans
    
  3. Changes
    - Update methodology field for all verifications under DLR 2.4.2
*/

-- Update methodology for DLR 2.4.2 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Commercial Loans

The IVA will verify the following aspects based on the available Activity Reports/Evaluation Studies on the Commercial loans provided to beneficiary enterprises in the non-farm sector:

a. Number of beneficiary enterprises
b. Number of women-led beneficiary enterprises
c. Number of youth-led beneficiary enterprises
d. Number of beneficiary enterprises that received commercial Loans
e. Number of beneficiary enterprises that received commercial Loans from formal financial institutions
f. Number of beneficiary enterprises that received commercial Loans under SYSS
g. Number of women-led beneficiary enterprises that received commercial Loans
h. Number of women-led beneficiary enterprises that received commercial Loans from formal financial institutions
i. Number of women-led beneficiary enterprises that received commercial Loans under SYSS
j. Number of youth-led beneficiary enterprises that received commercial Loans
k. Number of youth-led beneficiary enterprises that received commercial Loans from formal financial institutions
l. Number of youth-led beneficiary enterprises that received commercial Loans under SYSS

B. Telephonic Review of Commercial Loans

IVA will verify the following aspects based on 25 percent of beneficiaries selected using stratified random sampling from the list of beneficiary enterprises under SYSS through Telephonic Interviews:

a. Name of Beneficiary Enterprise
b. Registration details of enterprise
c. Name of Entrepreneur
d. Gender (Male/Female)
e. Youth 18-35 (Yes/No)
f. Percentage of ownership of enterprises by women entrepreneurs
g. Percentage of ownership of enterprises by youth entrepreneurs
h. Commercial loans received (Yes/No)
i. Source of Commercial Loan
j. Date of Commercial Loan Sanctioned
k. Amount of Commercial Loan
l. Purpose of Commercial Loan
m. Sector
n. Date of sanction of support under SYSS
o. Details of support received under SYSS
p. Number of Youth (18-35) Owners in beneficiary enterprise
q. Number of Women (18-35) Owners in beneficiary enterprise'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 2.4.2');
