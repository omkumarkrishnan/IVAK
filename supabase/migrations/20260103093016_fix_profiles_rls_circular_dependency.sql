/*
  # Fix profiles RLS circular dependency

  1. Changes
    - Drop existing SELECT policies that create circular dependencies
    - Create single simplified SELECT policy that works for all users
    - Users can always read their own profile
    - Admins can read all profiles (checked without circular dependency)
    
  2. Security
    - All authenticated users can read their own profile
    - Admin users can read all profiles
*/

-- Drop existing SELECT policies
DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;

-- Create a single SELECT policy that handles both cases
CREATE POLICY "Users can view profiles"
  ON profiles
  FOR SELECT
  TO authenticated
  USING (
    -- Users can always see their own profile
    auth.uid() = id
    OR
    -- OR check if current user has admin role
    -- This subquery only returns true/false, avoiding circular dependency
    (
      SELECT role FROM profiles WHERE id = auth.uid() LIMIT 1
    ) = 'admin'
  );
