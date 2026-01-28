/*
  # Add Verification Methodology for DLR 1.5.2
  
  1. Purpose
    - Add comprehensive verification methodology for DLR 1.5.2 (6 work-readiness programs/boot camps launched by PDD in priority sectors)
    - Provides detailed step-by-step verification process for IVA team
    
  2. Methodology Sections
    - A. Review Work Readiness Training Program/Bootcamp from Activity Reports/Evaluation Studies
    - B. Review Work Readiness Training Program/Bootcamp from MIS Data/Official documents
    - C. Spot Checks of Trainees
    - D. Certifications
    
  3. Changes
    - Update methodology field for all verifications under DLR 1.5.2
*/

-- Update methodology for DLR 1.5.2 verifications
UPDATE verifications
SET methodology = 'A. Review Work Readiness Training Program/Bootcamp from Activity Reports/ Evaluation Studies

IVA will confirm the following training details for the training programs and boot camps.

a. Training Objectives,
b. Content,
c. Methodology,
d. Schedule,
e. Trainer Profiles
f. Assessment Details
g. Learning Outcomes, including Certification.

B. Review Work Readiness Training Program/Bootcamp from MIS Data/Official documents

IVA will cross–check the following training details for the training programs and boot camps.

a. Titles of each work readiness training program,
b. Content of all the training modules
c. Dates and schedule of conduct of each training Program
d. Details of Priority Sector.
e. Details of Training Partners.
f. Details of trainee

C. Spot Checks of Trainees

The IVA will conduct in-person "spot checks" on 25% of trainees using interviews (gender-disaggregated data; age disaggregated data with separate data for youth aged 18-35 years). The objective of the interview will be to assess the participants'' understanding and ability to use the concepts and skills taught in the training programs. The questions used to ascertain the training effectiveness will be prepared based on the training content along the following parameters:

a. Communication Skills: Effective verbal and written communication in a professional context.
b. Resume Building: Crafting compelling resumes that highlight skills and experiences.
c. Interview Techniques: Preparing for and excelling in job interviews.
d. Professional Etiquette: Understanding workplace norms, behavior, and etiquette.
e. Time Management: Efficiently managing time and tasks in a work environment.
f. Digital Literacy: The respondent should be able to type a letter in a Word file and perform simple Excel calculations.

The IVA will provide the tool for the spot checks.

Spot checks are interviews undertaken with trainees during their training program at the venue.

D. Certifications

IVA will verify trainee names and certification details given by PDD for course completions.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 1.5.2');
