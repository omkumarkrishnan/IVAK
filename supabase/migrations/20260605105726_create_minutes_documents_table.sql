-- Create storage bucket for minutes documents
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'minutes-documents',
  'minutes-documents',
  false,
  52428800,
  ARRAY[
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  ]
)
ON CONFLICT (id) DO NOTHING;

-- Minutes & Decisions documents table
CREATE TABLE minutes_documents (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title        text NOT NULL,
  file_name    text NOT NULL,
  file_path    text NOT NULL,
  file_size    bigint,
  mime_type    text,
  uploaded_by  uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  uploaded_at  timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE minutes_documents ENABLE ROW LEVEL SECURITY;

-- All authenticated users can read
CREATE POLICY "minutes_select" ON minutes_documents
  FOR SELECT TO authenticated USING (true);

-- Admin and consultant can insert
CREATE POLICY "minutes_insert" ON minutes_documents
  FOR INSERT TO authenticated
  WITH CHECK (auth.uid() = uploaded_by);

-- Admin and consultant can delete their own; admin can delete any
CREATE POLICY "minutes_delete" ON minutes_documents
  FOR DELETE TO authenticated
  USING (auth.uid() = uploaded_by);

-- Storage policies for minutes-documents bucket
CREATE POLICY "minutes_storage_select"
  ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'minutes-documents');

CREATE POLICY "minutes_storage_insert"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'minutes-documents');

CREATE POLICY "minutes_storage_delete"
  ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'minutes-documents' AND (storage.foldername(name))[1] = auth.uid()::text);
