/*
  # Fix Storage Delete Policy for DLI Files

  ## Problem
  The storage DELETE policy queries the profiles table directly to check if a user is an admin.
  This creates a circular dependency with the profiles RLS policies, preventing file deletion.

  ## Solution
  Update the storage DELETE policy to use the is_admin() function which has SECURITY DEFINER
  and bypasses RLS, avoiding the circular dependency.

  ## Changes
  - Drop and recreate the storage DELETE policy to use is_admin() function
  - This allows users to delete their own files and admins to delete any files
*/

-- Drop existing storage DELETE policy
DROP POLICY IF EXISTS "Users can delete own files or admins can delete any" ON storage.objects;

-- Create improved DELETE policy using is_admin() function
CREATE POLICY "Users can delete own files or admins can delete any"
ON storage.objects
FOR DELETE
TO authenticated
USING (
  bucket_id = 'dli-files' 
  AND (
    (auth.uid())::text = (storage.foldername(name))[1]
    OR is_admin()
  )
);
