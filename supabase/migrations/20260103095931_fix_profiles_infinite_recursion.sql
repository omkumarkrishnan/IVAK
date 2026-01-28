/*
  # Fix Infinite Recursion in Profiles RLS Policies

  ## Problem
  The current RLS policies on the profiles table create infinite recursion because they
  query the profiles table itself to check if a user is an admin. When trying to read
  a profile, the policy checks the profiles table, which triggers the same policy again.

  ## Solution
  1. Create a security definer function that bypasses RLS to check user roles
  2. Replace all policies with new ones that use this function
  3. This breaks the circular dependency and allows proper authorization

  ## Changes
  - Drop existing problematic policies
  - Create `is_admin()` function with SECURITY DEFINER
  - Create new simplified policies using the function
*/

-- Drop existing policies that cause infinite recursion
DROP POLICY IF EXISTS "Users can view profiles" ON profiles;
DROP POLICY IF EXISTS "Allow profile updates" ON profiles;
DROP POLICY IF EXISTS "Admins can delete users" ON profiles;
DROP POLICY IF EXISTS "Allow profile creation" ON profiles;

-- Create a security definer function to check if current user is admin
-- This function bypasses RLS, preventing infinite recursion
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 
    FROM public.profiles 
    WHERE id = auth.uid() 
    AND role = 'admin'
  );
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.is_admin() TO authenticated;

-- Create new policies using the security definer function

-- SELECT: Users can view their own profile OR admins can view all profiles
CREATE POLICY "Users can view profiles"
  ON profiles
  FOR SELECT
  TO authenticated
  USING (
    auth.uid() = id OR is_admin()
  );

-- INSERT: Users can only create their own profile
CREATE POLICY "Users can insert own profile"
  ON profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- UPDATE: Users can update their own profile OR admins can update any profile
CREATE POLICY "Users can update profiles"
  ON profiles
  FOR UPDATE
  TO authenticated
  USING (
    auth.uid() = id OR is_admin()
  )
  WITH CHECK (
    auth.uid() = id OR is_admin()
  );

-- DELETE: Only admins can delete profiles
CREATE POLICY "Admins can delete profiles"
  ON profiles
  FOR DELETE
  TO authenticated
  USING (is_admin());
