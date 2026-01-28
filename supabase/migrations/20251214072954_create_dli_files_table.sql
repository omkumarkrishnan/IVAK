/*
  # Create DLI Files Table and Storage

  ## Overview
  This migration creates the infrastructure for file attachments on DLIs.

  ## New Tables
  
  ### `dli_files`
  - `id` (uuid, primary key) - Unique identifier
  - `dli_id` (uuid, foreign key) - References dlis table
  - `file_name` (text, not null) - Original file name
  - `file_path` (text, not null) - Storage path in Supabase Storage
  - `file_size` (bigint) - File size in bytes
  - `mime_type` (text) - MIME type of the file
  - `uploaded_by` (uuid, foreign key) - References auth.users
  - `created_at` (timestamptz) - Upload timestamp

  ## Storage
  
  - Creates a storage bucket named 'dli-files'
  - Public read access, authenticated write access

  ## Security
  
  - Enable RLS on dli_files table
  - **SELECT Policy**: Authenticated users can view all files
  - **INSERT Policy**: Authenticated users can upload files
  - **DELETE Policy**: Users can delete their own files, admins can delete any file

  ## Indexes
  
  - Index on dli_files.dli_id for faster lookups
*/

-- Create dli_files table
CREATE TABLE IF NOT EXISTS dli_files (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  dli_id uuid NOT NULL REFERENCES dlis(id) ON DELETE CASCADE,
  file_name text NOT NULL,
  file_path text NOT NULL,
  file_size bigint,
  mime_type text,
  uploaded_by uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE dli_files ENABLE ROW LEVEL SECURITY;

-- RLS Policies for dli_files
CREATE POLICY "Anyone can view dli files"
  ON dli_files FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Authenticated users can upload files"
  ON dli_files FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = uploaded_by);

CREATE POLICY "Users can delete own files or admins can delete any"
  ON dli_files FOR DELETE
  TO authenticated
  USING (
    auth.uid() = uploaded_by
    OR EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  );

-- Create index for better performance
CREATE INDEX IF NOT EXISTS dli_files_dli_id_idx ON dli_files(dli_id);

-- Create storage bucket for DLI files
INSERT INTO storage.buckets (id, name, public)
VALUES ('dli-files', 'dli-files', true)
ON CONFLICT (id) DO NOTHING;

-- Storage policies for dli-files bucket
CREATE POLICY "Anyone can view files"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (bucket_id = 'dli-files');

CREATE POLICY "Authenticated users can upload files"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (bucket_id = 'dli-files');

CREATE POLICY "Users can delete own files or admins can delete any"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'dli-files'
    AND (
      auth.uid()::text = (storage.foldername(name))[1]
      OR EXISTS (
        SELECT 1 FROM profiles
        WHERE profiles.id = auth.uid()
        AND profiles.role = 'admin'
      )
    )
  );