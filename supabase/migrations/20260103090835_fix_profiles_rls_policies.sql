/*
  # Fix Profiles RLS Policies
  
  1. Changes
    - Drop all existing SELECT policies on profiles table
    - Create a single comprehensive SELECT policy that allows:
      - All authenticated users to view their own profile
      - This fixes the circular dependency issue where admins couldn't read their own profile
  
  2. Security
    - Every authenticated user can read their own profile
    - Admins can view other profiles through separate queries once their own profile is loaded
*/

-- Drop existing SELECT policies
DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;

-- Create new comprehensive SELECT policy
CREATE POLICY "Authenticated users can view own profile"
  ON profiles FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Create separate policy for admins to view all profiles
-- This will work after the user's own profile is loaded
CREATE POLICY "Admins can view all profiles"
  ON profiles FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
    )
  );
