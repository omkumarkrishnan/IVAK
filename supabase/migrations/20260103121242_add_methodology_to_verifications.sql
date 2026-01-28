/*
  # Add Methodology Field to Verifications

  1. Changes
    - Add `methodology` column to `verifications` table
      - Type: text (to store detailed methodology content)
      - Nullable: true (as existing verifications may not have methodology yet)
      - Description: Stores the detailed verification methodology for each verification item
  
  2. Purpose
    - Enable storing comprehensive verification methodology text
    - Support displaying methodology details when users click on a verification
    - Allow structured methodology content (like Desk Review steps, Structured Interview questions, etc.)
*/

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'verifications' AND column_name = 'methodology'
  ) THEN
    ALTER TABLE verifications ADD COLUMN methodology text;
  END IF;
END $$;