/*
  # Rename verification_method to verification_heading

  1. Changes
    - Rename column `verification_method` to `verification_heading` in the `dlis` table
*/

ALTER TABLE dlis 
RENAME COLUMN verification_method TO verification_heading;
