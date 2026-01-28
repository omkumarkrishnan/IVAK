/*
  # Create IVA Reports Table

  1. Purpose
    - Store IVA Verification Reports linked to specific DLRs
    - Track upload metadata and file information
    
  2. New Tables
    - `iva_reports`
      - `id` (uuid, primary key)
      - `dli_id` (uuid, foreign key to dlis)
      - `report_name` (text) - Display name like "IVA Report 1.0.1"
      - `file_name` (text) - Original filename
      - `file_path` (text) - Storage path
      - `file_size` (bigint) - File size in bytes
      - `mime_type` (text) - File MIME type
      - `uploaded_by` (uuid, foreign key to auth.users)
      - `uploaded_at` (timestamptz) - Upload timestamp
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
      
  3. Security
    - Enable RLS on `iva_reports` table
    - Add policies for authenticated users to view reports
    - Add policies for admins and IVA users to upload/delete reports
    
  4. Storage
    - Create storage bucket for IVA reports
    - Set up appropriate storage policies
*/

-- Create iva_reports table
CREATE TABLE IF NOT EXISTS iva_reports (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  dli_id uuid NOT NULL REFERENCES dlis(id) ON DELETE CASCADE,
  report_name text NOT NULL,
  file_name text NOT NULL,
  file_path text NOT NULL,
  file_size bigint,
  mime_type text,
  uploaded_by uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  uploaded_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Enable RLS
ALTER TABLE iva_reports ENABLE ROW LEVEL SECURITY;

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_iva_reports_dli_id ON iva_reports(dli_id);
CREATE INDEX IF NOT EXISTS idx_iva_reports_uploaded_by ON iva_reports(uploaded_by);

-- RLS Policies

-- Authenticated users can view all IVA reports
CREATE POLICY "Authenticated users can view IVA reports"
  ON iva_reports FOR SELECT
  TO authenticated
  USING (true);

-- Admin and IVA users can insert IVA reports
CREATE POLICY "Admin and IVA users can insert IVA reports"
  ON iva_reports FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'iva')
    )
  );

-- Admin and IVA users can delete IVA reports
CREATE POLICY "Admin and IVA users can delete IVA reports"
  ON iva_reports FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'iva')
    )
  );

-- Create storage bucket for IVA reports
INSERT INTO storage.buckets (id, name, public)
VALUES ('iva-reports', 'iva-reports', false)
ON CONFLICT (id) DO NOTHING;

-- Storage policies for iva-reports bucket

-- Authenticated users can view IVA reports
CREATE POLICY "Authenticated users can view IVA reports"
  ON storage.objects FOR SELECT
  TO authenticated
  USING (bucket_id = 'iva-reports');

-- Admin and IVA users can upload IVA reports
CREATE POLICY "Admin and IVA users can upload IVA reports"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'iva-reports' AND
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'iva')
    )
  );

-- Admin and IVA users can delete IVA reports
CREATE POLICY "Admin and IVA users can delete IVA reports"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'iva-reports' AND
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'iva')
    )
  );
