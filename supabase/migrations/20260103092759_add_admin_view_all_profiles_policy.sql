/*
  # Add admin view all profiles policy

  1. Changes
    - Add SELECT policy allowing admins to view all profiles
    
  2. Security
    - Only users with admin role can view all profiles
    - Regular users can still only view their own profile
*/

-- Drop existing restrictive SELECT policy
DROP POLICY IF EXISTS "Authenticated users can view own profile" ON profiles;

-- Create new SELECT policy for own profile
CREATE POLICY "Users can view own profile"
  ON profiles
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Create new SELECT policy for admins to view all profiles
CREATE POLICY "Admins can view all profiles"
  ON profiles
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  );
