/*
  # Add DLI Number Column to Departments

  1. Purpose
    - Add a dli_number column to departments table for proper ordering
    - Populate the column with the corresponding DLI numbers
  
  2. Changes
    - Add dli_number column (integer)
    - Populate the column for all existing departments
    - Create an index for efficient ordering
*/

-- Add dli_number column
ALTER TABLE departments ADD COLUMN IF NOT EXISTS dli_number INTEGER;

-- Populate dli_number for each department
UPDATE departments SET dli_number = 1 WHERE name LIKE '%DLI 1%';
UPDATE departments SET dli_number = 2 WHERE name LIKE '%DLI 2%';
UPDATE departments SET dli_number = 3 WHERE name LIKE '%DLI 3%';
UPDATE departments SET dli_number = 4 WHERE name LIKE '%DLI 4%';
UPDATE departments SET dli_number = 5 WHERE name LIKE '%DLI 5%';
UPDATE departments SET dli_number = 6 WHERE name LIKE '%DLI 6%';
UPDATE departments SET dli_number = 7 WHERE name LIKE '%DLI 7%';
UPDATE departments SET dli_number = 8 WHERE name LIKE '%DLI 8%';

-- Create index for efficient ordering
CREATE INDEX IF NOT EXISTS idx_departments_dli_number ON departments(dli_number);