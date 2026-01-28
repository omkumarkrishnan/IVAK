/*
  # Add Verification Methodology for DLR 6.5.1
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 6.5.1 (Study on linkages between digital connectivity and economic activity completed and dissemination workshop organized by ITD)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Desk Review of report on linkages between digital connectivity and economic activity
    - B. Desk review Report on Dissemination Workshops
    
  3. Changes
    - Update methodology field for all verifications under DLR 6.5.1
*/

-- Update methodology for DLR 6.5.1 verifications
UPDATE verifications
SET methodology = 'A. Desk Review of report on linkages between digital connectivity and economic activity

a. Verify the authorized signature of Nodal Officials.
b. Verify the date of the report
c. Verify the scope and objectives
d. Verify the baseline data
e. Verify the current status of digital connectivity
f. Verify the analysis tools
g. Verify the results reported
h. Verify the impact of digital connectivity on economic activity on the following aspects:
   - Impact on worker productivity
   - No. of enterprises benefited from digital connectivity
   - No. of jobs reported due to digital connectivity

B. Desk review Report on Dissemination Workshops

The IVA will review the following from the report on Dissemination Workshop:

a. Number of Departments from Government of Sikkim participating in Workshop
b. Verify the agenda points of Workshop
c. Verify the minutes of Workshop
d. Verify the attendance list
e. Verify the key aspects covered in Dissemination Workshop
f. Verify the outcomes of the Workshop linking digital connectivity and economic activity
g. Verify the Actions points recommended'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 6.5.1');
