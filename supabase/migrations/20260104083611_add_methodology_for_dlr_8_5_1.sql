/*
  # Add Verification Methodology for DLR 8.5.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 8.5.1 (20 percent of trainees trained and certified in childcare/geriatric care, or reproductive health, or early childhood development placed in national or international locations)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of Activity Reports/Evaluation Studies
    - B. MIS Review
    - C. Spot Checks
    - D. Telephonic Review
    - E. Field Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 8.5.1
*/

-- Update methodology for DLR 8.5.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of Activity Reports/Evaluation Studies

The IVA will verify the following aspects based on the details available from the Activity Reports/Evaluation Studies on trained and certified individuals who secured employment (wage employment or self-employment) in national or international locations:

a. Number of Trained and Certified Individuals (gender disaggregated)
b. Number of Trained and Certified Individuals who secured employment (gender disaggregated)
c. Number of Trained and Certified Individuals who have wage employment (gender disaggregated)
d. Number of Self-employed Trained and Certified Individuals (gender disaggregated)
e. Number of Trained and Certified Individuals Employed Nationally (gender disaggregated)
f. Number of Trained and Certified Individuals Employed in International Locations (gender disaggregated)

B. MIS Review

The IVA will confirm the following aspects based on the details available from MIS data on trained and certified individuals who secured employment (wage employment or self-employment) in national or international locations:

a. Number of Trained and Certified Individuals (gender disaggregated)
b. Number of Trained and Certified Individuals who secured employment (gender disaggregated)
c. Number of Trained and Certified Individuals who have wage employment (gender disaggregated)
d. Number of Self-employed Trained and Certified Individuals (gender disaggregated)
e. Number of Trained and Certified Individuals Employed Nationally (gender disaggregated)
f. Number of Trained and Certified Individuals Employed in International Locations (gender disaggregated)

C. Spot Checks

The IVA will conduct "spot checks" on 25% of trainees using personal interviews. The objective of the interview will be to assess the understanding and ability to use the concepts and skills taught in the training programs. The questions used to ascertain the training effectiveness will be prepared based on the training content in the following areas:

a. Attitude
b. Behaviour
c. Critical skills
d. Professionalism

IVA will report the performance scores of the trainees on works readiness. The report will contain the percentage of trainees scoring average, above average, and below average marks.

D. Telephonic Review

The IVA will verify the following aspects using telephonic interviews based on a random sample of 30 percent of the beneficiaries drawn from the list of trained and certified individuals who secured employment:

a. Name of Beneficiary
b. Nature of Employment
c. Field of Employment
d. Joining Date of Employment
e. Location
f. Name of Employer
g. Gender
h. Age
i. Present Address
j. Training Completion Date

E. Field Review

The IVA will conduct field verification of 10 percent beneficiaries drawn from the list of trained and certified beneficiaries to verify whether they have received the certification (as indicated in the provided certificates) and the beneficiary perception on training programs.

The IVA will verify the following aspects:

a. Date of Training Sessions
b. Location of Training Sessions
c. Topic of Training
d. Receipt of Certificate'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 8.5.1');
