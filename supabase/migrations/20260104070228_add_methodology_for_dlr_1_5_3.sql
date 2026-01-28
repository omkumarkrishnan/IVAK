/*
  # Add Verification Methodology for DLR 1.5.3
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 1.5.3 (60 percent of youth who participated in work readiness programs are work-ready in priority sectors)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Spot Checks
    - B. Telephonic and Field Review
    
  3. Changes
    - Update methodology field for all verifications under DLR 1.5.3
*/

-- Update methodology for DLR 1.5.3 verifications
UPDATE verifications
SET methodology = 'A. Spot Checks

The IVA will conduct "spot checks" on 25% of trainees using personal interviews. The objective of the interview will be to assess the understanding and ability to use the concepts and skills taught in the training programs. The questions used to ascertain the training effectiveness will be prepared based on the training content in the following areas:

a. Attitude
b. Behavior
c. Critical skills
d. Professionalism

IVA will report the performance scores of the trainees on works readiness. The report will contain the percentage of trainees scoring average, above average, and below average marks.

B. Telephonic and Field Review

The IVA will verify 20 percent randomly selected trainees through telephone (5 percent) and field interviews (20 percent). The telephonic and field verifications will be conducted on the respective sample of participants who participated in the work readiness program, both in training programs or boot camps, to verify whether they have received the certification (as indicated in the provided certificates). Furthermore, the IVA will also verify the following aspects:

a. Date of Training Sessions
b. Location of Training Sessions
c. Topic of Training
d. Receipt of Certificate
e. Feedback about the Training Program'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 1.5.3');
