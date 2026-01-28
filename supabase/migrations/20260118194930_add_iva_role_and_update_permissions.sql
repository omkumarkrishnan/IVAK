/*
  # Add IVA Role and Update IVA Report Permissions
  
  1. Changes
    - Add 'iva' to the profiles role CHECK constraint
    - Update RLS policies to allow consultant and field_agent roles to upload IVA reports
    
  2. Valid Roles
    - admin
    - consultant
    - client
    - field_agent
    - iva (newly added)
    
  3. Security
    - All consultant-type roles (consultant, field_agent, iva) can now upload/delete IVA reports
    - Maintains existing read permissions for all authenticated users
*/

-- Drop existing CHECK constraint
DO $$
BEGIN
  ALTER TABLE profiles DROP CONSTRAINT IF EXISTS profiles_role_check;
EXCEPTION
  WHEN undefined_object THEN NULL;
END $$;

-- Add new CHECK constraint with iva role included
ALTER TABLE profiles
ADD CONSTRAINT profiles_role_check 
CHECK (role IN ('admin', 'consultant', 'client', 'field_agent', 'iva'));

-- Update RLS policies for iva_reports table

-- Drop existing insert policy
DROP POLICY IF EXISTS "Admin and IVA users can insert IVA reports" ON iva_reports;

-- Create new insert policy for all consultant roles
CREATE POLICY "Admin and consultant roles can insert IVA reports"
  ON iva_reports FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'consultant', 'field_agent', 'iva')
    )
  );

-- Drop existing delete policy
DROP POLICY IF EXISTS "Admin and IVA users can delete IVA reports" ON iva_reports;

-- Create new delete policy for all consultant roles
CREATE POLICY "Admin and consultant roles can delete IVA reports"
  ON iva_reports FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'consultant', 'field_agent', 'iva')
    )
  );

-- Update storage policies

-- Drop existing upload policy
DROP POLICY IF EXISTS "Admin and IVA users can upload IVA reports" ON storage.objects;

-- Create new upload policy for all consultant roles
CREATE POLICY "Admin and consultant roles can upload IVA reports"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'iva-reports' AND
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'consultant', 'field_agent', 'iva')
    )
  );

-- Drop existing delete policy
DROP POLICY IF EXISTS "Admin and IVA users can delete IVA reports" ON storage.objects;

-- Create new delete policy for all consultant roles
CREATE POLICY "Admin and consultant roles can delete IVA reports"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'iva-reports' AND
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'consultant', 'field_agent', 'iva')
    )
  );
