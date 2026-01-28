/*
  # Create User Profiles and Roles System

  ## Overview
  This migration sets up the user profile system for the CESI application with role-based access control.

  ## New Tables
  
  ### `profiles`
  - `id` (uuid, primary key) - Links to auth.users
  - `email` (text, not null) - User's email address
  - `role` (text, not null) - User's role: 'admin', 'consultant', or 'client'
  - `created_at` (timestamptz) - Timestamp of profile creation
  - `updated_at` (timestamptz) - Timestamp of last profile update

  ## Security
  
  - Enable Row Level Security (RLS) on `profiles` table
  - **SELECT Policy**: Authenticated users can view their own profile
  - **INSERT Policy**: Only authenticated users can create their own profile (triggered on signup)
  - **UPDATE Policy**: Users can only update their own profile
  - **DELETE Policy**: No user can delete profiles (admin-only operation via service role)

  ## Important Notes
  
  1. Profiles are created automatically via a trigger when a new user signs up in auth.users
  2. Default role is 'client' - admin must manually upgrade users to 'consultant' or 'admin' roles
  3. RLS ensures users can only access their own profile data
  4. Email is stored for easy reference without querying auth.users
*/

-- Create profiles table
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email text NOT NULL,
  role text NOT NULL DEFAULT 'client' CHECK (role IN ('admin', 'consultant', 'client')),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- RLS Policies

-- Users can view their own profile
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

-- Users can insert their own profile (for signup flow)
CREATE POLICY "Users can create own profile"
  ON profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- Users can update their own profile
CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Create function to handle profile creation on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role)
  VALUES (new.id, new.email, 'client');
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger to automatically create profile on user signup
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS profiles_role_idx ON profiles(role);