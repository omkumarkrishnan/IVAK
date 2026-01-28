/*
  # Allow Admins to Update User Profiles

  ## Overview
  This migration updates the UPDATE policy on the profiles table to allow admins
  to update any user's profile, not just their own. This is necessary for the
  create-user edge function to set the correct role when admins create new users.

  ## Changes
  1. Drop the restrictive UPDATE policy
  2. Create a new UPDATE policy that allows:
     - Users to update their own profile
     - Admins to update any profile

  ## Security Notes
  - Only authenticated users with admin role can update other users' profiles
  - Regular users can still only update their own profile
  - This change does not affect SELECT, INSERT, or DELETE policies
*/

-- Drop the old UPDATE policy
DROP POLICY IF EXISTS "Users can update own profile" ON profiles;

-- Create new UPDATE policy that allows admins to update any profile
CREATE POLICY "Allow profile updates"
  ON profiles FOR UPDATE
  TO authenticated
  USING (
    -- Allow users to update their own profile
    auth.uid() = id
    -- Allow admins to update any profile
    OR EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  )
  WITH CHECK (
    -- Allow users to update their own profile
    auth.uid() = id
    -- Allow admins to update any profile
    OR EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  );