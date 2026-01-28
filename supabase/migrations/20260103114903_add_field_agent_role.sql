/*
  # Add Field Agent Role Type

  1. Changes
    - Modifies the profiles table CHECK constraint to include 'field_agent' as a valid role
    - Existing roles remain: 'admin', 'consultant', 'client'
    - New role: 'field_agent'
  
  2. Security
    - No changes to RLS policies (field_agent inherits authenticated user permissions)
    - Field agents will have same base access as consultants by default
*/

-- Drop existing CHECK constraint if it exists
DO $$
BEGIN
  ALTER TABLE profiles DROP CONSTRAINT IF EXISTS profiles_role_check;
EXCEPTION
  WHEN undefined_object THEN NULL;
END $$;

-- Add new CHECK constraint with field_agent role included
ALTER TABLE profiles
ADD CONSTRAINT profiles_role_check 
CHECK (role IN ('admin', 'consultant', 'client', 'field_agent'));