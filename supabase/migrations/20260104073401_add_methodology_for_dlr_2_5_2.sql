/*
  # Add Verification Methodology for DLR 2.5.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 2.5.2 (8% of women-led/youth-led enterprises supported under SYSS secure commercial loans - cumulative)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Commercial Loans
    - B. Telephonic Review for Commercial Loans
    
  3. Changes
    - Update methodology field for all verifications under DLR 2.5.2
*/

-- Update methodology for DLR 2.5.2 verifications
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

B. Telephonic Review for Commercial Loans

The IVA will verify through telephonic interviews the following aspects based on 25 percent of the randomly selected beneficiary enterprises selected from the list of beneficiary enterprises under SYSS:

a. Name of Beneficiary enterprise
b. Registration details of the enterprise
c. Name of Entrepreneur
d. Gender (Male/Female)
e. Youth 18-35 (Yes/No)
f. Percentage of ownership of enterprises by women entrepreneurs
g. Percentage of ownership of enterprises by youth entrepreneurs
h. Commercial loans received (yes/No)
i. Source of Commercial Loan
j. Date of Commercial Loan Sanctioned
k. Amount of Commercial Loan
l. Purpose of Commercial Loan
m. Sector of beneficiary enterprise
n. Date of sanction of support under SYSS
o. Details of support received under SYSS
p. Number of Youth (18-35) owners in beneficiary enterprise
q. Number of Women (18-35) owners in beneficiary enterprise'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 2.5.2');
