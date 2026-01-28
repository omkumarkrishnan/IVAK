/*
  # Simplify Profiles RLS Policies
  
  1. Changes
    - Remove the recursive "Admins can view all profiles" policy
    - Keep only the simple "Authenticated users can view own profile" policy
    - This fixes the circular dependency that was causing profile fetches to fail
  
  2. Security
    - Users can only read their own profile
    - For admin functionality to view all users, we'll use a separate edge function with service role access
*/

-- Drop the problematic recursive policy
DROP POLICY IF EXISTS "Admins can view all profiles" ON profiles;

-- Keep the simple policy that allows users to view their own profile
-- (This policy already exists as "Authenticated users can view own profile")
