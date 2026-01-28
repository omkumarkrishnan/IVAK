/*
  # Fix Security and Performance Issues

  1. Performance Improvements
    - Add missing index for dli_files.uploaded_by foreign key
    - Drop unused indexes (profiles_role_idx, dlis_period_id_idx, dli_files_dli_id_idx)

  2. RLS Policy Optimization
    - Recreate all RLS policies to use (select auth.uid()) pattern for better performance
    - This prevents re-evaluation of auth functions for each row

  3. Function Security
    - Fix search_path for handle_new_user and update_updated_at_column functions
    - Set explicit search_path to prevent search path injection attacks
*/

-- ============================================
-- 1. Add Missing Index for Foreign Key
-- ============================================

CREATE INDEX IF NOT EXISTS dli_files_uploaded_by_idx ON dli_files(uploaded_by);

-- ============================================
-- 2. Drop Unused Indexes
-- ============================================

DROP INDEX IF EXISTS profiles_role_idx;
DROP INDEX IF EXISTS dlis_period_id_idx;
DROP INDEX IF EXISTS dli_files_dli_id_idx;

-- ============================================
-- 3. Optimize RLS Policies for profiles Table
-- ============================================

DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
DROP POLICY IF EXISTS "Allow profile creation" ON profiles;
DROP POLICY IF EXISTS "Allow profile updates" ON profiles;

CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  TO authenticated
  USING ((select auth.uid()) = id);

CREATE POLICY "Allow profile creation"
  ON profiles FOR INSERT
  TO authenticated
  WITH CHECK ((select auth.uid()) = id);

CREATE POLICY "Allow profile updates"
  ON profiles FOR UPDATE
  TO authenticated
  USING (
    (select auth.uid()) = id
    OR
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  )
  WITH CHECK (
    (select auth.uid()) = id
    OR
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

-- ============================================
-- 4. Optimize RLS Policies for departments Table
-- ============================================

DROP POLICY IF EXISTS "Only admins can insert departments" ON departments;
DROP POLICY IF EXISTS "Only admins can update departments" ON departments;
DROP POLICY IF EXISTS "Only admins can delete departments" ON departments;

CREATE POLICY "Only admins can insert departments"
  ON departments FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can update departments"
  ON departments FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can delete departments"
  ON departments FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

-- ============================================
-- 5. Optimize RLS Policies for periods Table
-- ============================================

DROP POLICY IF EXISTS "Only admins can insert periods" ON periods;
DROP POLICY IF EXISTS "Only admins can update periods" ON periods;
DROP POLICY IF EXISTS "Only admins can delete periods" ON periods;

CREATE POLICY "Only admins can insert periods"
  ON periods FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can update periods"
  ON periods FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can delete periods"
  ON periods FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

-- ============================================
-- 6. Optimize RLS Policies for dlis Table
-- ============================================

DROP POLICY IF EXISTS "Only admins can insert dlis" ON dlis;
DROP POLICY IF EXISTS "Only admins can update dlis" ON dlis;
DROP POLICY IF EXISTS "Only admins can delete dlis" ON dlis;

CREATE POLICY "Only admins can insert dlis"
  ON dlis FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can update dlis"
  ON dlis FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can delete dlis"
  ON dlis FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

-- ============================================
-- 7. Optimize RLS Policies for verifications Table
-- ============================================

DROP POLICY IF EXISTS "Only admins can insert verifications" ON verifications;
DROP POLICY IF EXISTS "Only admins can delete verifications" ON verifications;

CREATE POLICY "Only admins can insert verifications"
  ON verifications FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

CREATE POLICY "Only admins can delete verifications"
  ON verifications FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

-- ============================================
-- 8. Optimize RLS Policies for dli_files Table
-- ============================================

DROP POLICY IF EXISTS "Authenticated users can upload files" ON dli_files;
DROP POLICY IF EXISTS "Users can delete own files or admins can delete any" ON dli_files;

CREATE POLICY "Authenticated users can upload files"
  ON dli_files FOR INSERT
  TO authenticated
  WITH CHECK (uploaded_by = (select auth.uid()));

CREATE POLICY "Users can delete own files or admins can delete any"
  ON dli_files FOR DELETE
  TO authenticated
  USING (
    uploaded_by = (select auth.uid())
    OR
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = (select auth.uid()) AND role = 'admin'
    )
  );

-- ============================================
-- 9. Fix Function Search Paths
-- ============================================

-- Recreate handle_new_user function with secure search_path
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role)
  VALUES (new.id, new.email, 'user');
  RETURN new;
END;
$$;

-- Recreate update_updated_at_column function with secure search_path
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS trigger
LANGUAGE plpgsql
SET search_path = public
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;