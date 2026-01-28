/*
  # Allow Service Role to Create User Profiles

  ## Overview
  This migration updates the RLS policies on the profiles table to allow the service role
  to create profiles for any user. This is necessary for the create-user edge function
  to work properly when admins create new users.

  ## Changes
  1. Drop the restrictive INSERT policy
  2. Create a new INSERT policy that allows:
     - Users to create their own profile (for normal signup)
     - Service role to create profiles for any user (for admin user creation)

  ## Security Notes
  - The service role key should only be used in secure edge functions
  - Regular authenticated users can still only create their own profile
  - This change does not affect SELECT, UPDATE, or DELETE policies
*/

-- Drop the old INSERT policy
DROP POLICY IF EXISTS "Users can create own profile" ON profiles;

-- Create new INSERT policy that allows service role to create any profile
CREATE POLICY "Allow profile creation"
  ON profiles FOR INSERT
  TO authenticated
  WITH CHECK (
    -- Allow users to create their own profile
    auth.uid() = id
    -- Service role can create any profile (bypasses RLS anyway, but explicit for clarity)
    OR current_setting('role', true) = 'service_role'
  );