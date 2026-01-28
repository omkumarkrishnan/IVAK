/*
  # Fix handle_new_user Function Default Role

  ## Problem
  The handle_new_user() trigger function tries to insert profiles with role='user',
  but the profiles table CHECK constraint only allows 'admin', 'consultant', or 'client'.
  This causes user creation to fail completely.

  ## Solution
  Update the function to use 'client' as the default role instead of 'user'.

  ## Changes
  - Modify handle_new_user() function to insert 'client' as default role
*/

-- Drop and recreate the handle_new_user function with correct default role
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role)
  VALUES (new.id, new.email, 'client');
  RETURN new;
END;
$$;
