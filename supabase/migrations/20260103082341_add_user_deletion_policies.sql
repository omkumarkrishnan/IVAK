/*
  # Add User Deletion Policies
  
  1. Changes
    - Add DELETE policy for profiles table allowing admins to delete users
    - Add policy for admins to view all profiles for user management
  
  2. Security
    - Only admins can delete user profiles
    - Only admins can view all user profiles
*/

-- Allow admins to view all profiles for user management
CREATE POLICY "Admins can view all profiles"
  ON profiles FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Allow admins to delete user profiles
CREATE POLICY "Admins can delete users"
  ON profiles FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );