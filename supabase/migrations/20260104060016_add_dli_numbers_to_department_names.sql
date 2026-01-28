/*
  # Add DLI Numbers to Department Names

  1. Purpose
    - Update department names to include their corresponding DLI numbers in brackets
    - Makes it easier to identify which DLI belongs to which department
  
  2. Changes
    - Planning and Development → Planning and Development (DLI 1)
    - Commerce and Industries → Commerce and Industries (DLI 2)
    - Tourism and Civil Aviation Department → Tourism and Civil Aviation Department (DLI 3)
    - Skill Development Department → Skill Development Department (DLI 4)
    - Rural Development Department/Directorate of Eco-Tourism –Forest Department → Rural Development Department/Directorate of Eco-Tourism –Forest Department (DLI 5)
    - Information Technology Department → Information Technology Department (DLI 6)
    - Health and Family Welfare Department → Health and Family Welfare Department (DLI 7)
    - PDD/SDD/HFWD/WCDD (DLI 8) → Already has the DLI number
*/

-- Update Planning and Development
UPDATE departments
SET name = 'Planning and Development (DLI 1)'
WHERE name = 'Planning and Development';

-- Update Commerce and Industries
UPDATE departments
SET name = 'Commerce and Industries (DLI 2)'
WHERE name = 'Commerce and Industries';

-- Update Tourism and Civil Aviation Department
UPDATE departments
SET name = 'Tourism and Civil Aviation Department (DLI 3)'
WHERE name = 'Tourism and Civil Aviation Department';

-- Update Skill Development Department
UPDATE departments
SET name = 'Skill Development Department (DLI 4)'
WHERE name = 'Skill Development Department';

-- Update Rural Development Department
UPDATE departments
SET name = 'Rural Development Department/Directorate of Eco-Tourism –Forest Department (DLI 5)'
WHERE name = 'Rural Development Department/Directorate of Eco-Tourism –Forest Department';

-- Update Information Technology Department
UPDATE departments
SET name = 'Information Technology Department (DLI 6)'
WHERE name = 'Information Technology Department';

-- Update Health and Family Welfare Department
UPDATE departments
SET name = 'Health and Family Welfare Department (DLI 7)'
WHERE name = 'Health and Family Welfare Department';