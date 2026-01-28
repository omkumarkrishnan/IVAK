/*
  # Seed Admin User

  ## Overview
  This migration creates the initial admin user for the CESI application.

  ## Changes
  
  1. Creates an admin user with credentials:
     - Email: omk@cesi.com
     - Password: admin123
     - Role: admin

  ## Important Notes
  
  - This uses the auth.users table's built-in ID generation
  - The trigger will automatically create a profile with 'client' role
  - We then update the profile to set the role to 'admin'
  - If the user already exists, this migration will skip creation
*/

-- Insert admin user into auth.users table
DO $$
DECLARE
  admin_user_id uuid;
BEGIN
  -- Check if user already exists
  SELECT id INTO admin_user_id
  FROM auth.users
  WHERE email = 'omk@cesi.com';

  -- If user doesn't exist, create them
  IF admin_user_id IS NULL THEN
    -- Insert into auth.users
    INSERT INTO auth.users (
      instance_id,
      id,
      aud,
      role,
      email,
      encrypted_password,
      email_confirmed_at,
      raw_app_meta_data,
      raw_user_meta_data,
      created_at,
      updated_at,
      confirmation_token,
      recovery_token,
      email_change_token_new,
      email_change
    ) VALUES (
      '00000000-0000-0000-0000-000000000000',
      gen_random_uuid(),
      'authenticated',
      'authenticated',
      'omk@cesi.com',
      crypt('admin123', gen_salt('bf')),
      now(),
      '{"provider":"email","providers":["email"]}',
      '{}',
      now(),
      now(),
      '',
      '',
      '',
      ''
    )
    RETURNING id INTO admin_user_id;

    -- Update the profile to set role to admin
    UPDATE profiles
    SET role = 'admin'
    WHERE id = admin_user_id;

    RAISE NOTICE 'Admin user created with ID: %', admin_user_id;
  ELSE
    -- User exists, ensure they have admin role
    UPDATE profiles
    SET role = 'admin'
    WHERE id = admin_user_id;
    
    RAISE NOTICE 'Admin user already exists with ID: %', admin_user_id;
  END IF;
END $$;