import { useState, useRef, useEffect } from 'react';
import {
  X, Upload, FileText, Download, Trash2, Loader2, Calendar, File,
} from 'lucide-react';
import { supabase } from '../lib/supabase';
import { useAuth } from '../contexts/AuthContext';

interface MinutesDocument {
  id: string;
  title: string;
  file_name: string;
  file_path: string;
  file_size: number | null;
  mime_type: string | null;
  uploaded_by: string | null;
  uploaded_at: string;
}

interface MinutesModalProps {
  onClose: () => void;
  userRole?: string;
}

const UPLOAD_ROLES = ['admin', 'consultant'];

export function MinutesModal({ onClose, userRole }: MinutesModalProps) {
  const { user } = useAuth();
  const fileInputRef = useRef<HTMLInputElement>(null);

  const [documents, setDocuments] = useState<MinutesDocument[]>([]);
  const [loading, setLoading] = useState(true);
  const [uploading, setUploading] = useState(false);
  const [deletingId, setDeletingId] = useState<string | null>(null);
  const [downloadingId, setDownloadingId] = useState<string | null>(null);

  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [titleInput, setTitleInput] = useState('');
  const [showUploadForm, setShowUploadForm] = useState(false);

  const canUpload = UPLOAD_ROLES.includes(userRole || '');
  const canDelete = UPLOAD_ROLES.includes(userRole || '');

  const fetchDocuments = async () => {
    const { data, error } = await supabase
      .from('minutes_documents')
      .select('*')
      .order('uploaded_at', { ascending: false });
    if (!error) setDocuments(data ?? []);
    setLoading(false);
  };

  useEffect(() => { fetchDocuments(); }, []);

  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setSelectedFile(file);
    if (!titleInput) setTitleInput(file.name.replace(/\.[^.]+$/, ''));
    setShowUploadForm(true);
  };

  const handleUpload = async () => {
    if (!selectedFile || !user || !titleInput.trim()) return;
    setUploading(true);
    try {
      const ext = selectedFile.name.split('.').pop();
      const filePath = `${user.id}/${Date.now()}.${ext}`;

      const { error: storageError } = await supabase.storage
        .from('minutes-documents')
        .upload(filePath, selectedFile);
      if (storageError) throw storageError;

      const { error: dbError } = await supabase.from('minutes_documents').insert({
        title:       titleInput.trim(),
        file_name:   selectedFile.name,
        file_path:   filePath,
        file_size:   selectedFile.size,
        mime_type:   selectedFile.type,
        uploaded_by: user.id,
      });
      if (dbError) throw dbError;

      await fetchDocuments();
      resetForm();
    } catch (err) {
      console.error('Upload error:', err);
      alert('Upload failed. Please try again.');
    } finally {
      setUploading(false);
    }
  };

  const handleDelete = async (doc: MinutesDocument) => {
    if (!confirm(`Delete "${doc.title}"?`)) return;
    setDeletingId(doc.id);
    try {
      await supabase.storage.from('minutes-documents').remove([doc.file_path]);
      await supabase.from('minutes_documents').delete().eq('id', doc.id);
      await fetchDocuments();
    } catch (err) {
      console.error('Delete error:', err);
      alert('Delete failed. Please try again.');
    } finally {
      setDeletingId(null);
    }
  };

  const handleDownload = async (doc: MinutesDocument) => {
    setDownloadingId(doc.id);
    try {
      const { data, error } = await supabase.storage
        .from('minutes-documents')
        .download(doc.file_path);
      if (error) throw error;
      const url = URL.createObjectURL(data);
      const a = document.createElement('a');
      a.href = url;
      a.download = doc.file_name;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(url);
    } catch (err) {
      console.error('Download error:', err);
      alert('Download failed. Please try again.');
    } finally {
      setDownloadingId(null);
    }
  };

  const resetForm = () => {
    setSelectedFile(null);
    setTitleInput('');
    setShowUploadForm(false);
    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  const formatSize = (bytes: number | null) => {
    if (!bytes) return '';
    if (bytes < 1024 * 1024) return `${(bytes / 1024).toFixed(0)} KB`;
    return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
  };

  const formatDate = (iso: string) =>
    new Date(iso).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' });

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-xl shadow-2xl w-full max-w-2xl max-h-[90vh] flex flex-col">

        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-slate-200">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-lg bg-slate-900 flex items-center justify-center">
              <FileText className="w-5 h-5 text-white" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-slate-900">Minutes & Decisions</h2>
              <p className="text-xs text-slate-500">Meeting minutes and key programme decisions</p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 text-slate-400 hover:text-slate-600 hover:bg-slate-100 rounded-lg transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Upload form */}
        {canUpload && (
          <div className="px-6 py-4 border-b border-slate-100 bg-slate-50">
            {!showUploadForm ? (
              <div>
                <input
                  ref={fileInputRef}
                  type="file"
                  className="hidden"
                  id="minutes-file-input"
                  accept=".pdf,.doc,.docx,.xls,.xlsx"
                  onChange={handleFileSelect}
                />
                <label
                  htmlFor="minutes-file-input"
                  className="inline-flex items-center gap-2 px-4 py-2 bg-slate-900 text-white text-sm font-medium rounded-lg hover:bg-slate-800 transition-colors cursor-pointer"
                >
                  <Upload className="w-4 h-4" />
                  Upload Document
                </label>
                <span className="ml-3 text-xs text-slate-400">PDF, Word, or Excel — max 50 MB</span>
              </div>
            ) : (
              <div className="space-y-3">
                <div className="flex items-center gap-2 p-3 bg-white border border-slate-200 rounded-lg">
                  <File className="w-4 h-4 text-slate-500 shrink-0" />
                  <span className="text-sm text-slate-700 truncate">{selectedFile?.name}</span>
                  <span className="ml-auto text-xs text-slate-400 shrink-0">{formatSize(selectedFile?.size ?? null)}</span>
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-600 mb-1">Document Title</label>
                  <input
                    type="text"
                    value={titleInput}
                    onChange={e => setTitleInput(e.target.value)}
                    placeholder="e.g. April 2026 Minutes of Meeting"
                    className="w-full px-3 py-2 text-sm border border-slate-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-slate-900 focus:border-transparent"
                    autoFocus
                  />
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={resetForm}
                    disabled={uploading}
                    className="px-4 py-2 text-sm font-medium text-slate-600 bg-white border border-slate-300 rounded-lg hover:bg-slate-50 transition-colors disabled:opacity-50"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={handleUpload}
                    disabled={uploading || !titleInput.trim()}
                    className="flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-slate-900 rounded-lg hover:bg-slate-800 transition-colors disabled:opacity-50"
                  >
                    {uploading ? <Loader2 className="w-4 h-4 animate-spin" /> : <Upload className="w-4 h-4" />}
                    {uploading ? 'Uploading...' : 'Upload'}
                  </button>
                </div>
              </div>
            )}
          </div>
        )}

        {/* Document list */}
        <div className="flex-1 overflow-y-auto px-6 py-4">
          {loading ? (
            <div className="flex items-center justify-center py-12">
              <Loader2 className="w-6 h-6 animate-spin text-slate-400" />
            </div>
          ) : documents.length === 0 ? (
            <div className="text-center py-12">
              <FileText className="w-12 h-12 text-slate-200 mx-auto mb-3" />
              <p className="text-sm font-medium text-slate-500">No documents uploaded yet</p>
              {canUpload && (
                <p className="text-xs text-slate-400 mt-1">Use the button above to upload the first document.</p>
              )}
            </div>
          ) : (
            <ul className="space-y-2">
              {documents.map(doc => (
                <li
                  key={doc.id}
                  className="flex items-center gap-3 p-4 bg-white border border-slate-200 rounded-lg hover:border-slate-300 transition-colors"
                >
                  <div className="w-9 h-9 rounded-lg bg-slate-100 flex items-center justify-center shrink-0">
                    <FileText className="w-5 h-5 text-slate-600" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-semibold text-slate-900 truncate">{doc.title}</p>
                    <div className="flex items-center gap-2 mt-0.5">
                      <Calendar className="w-3 h-3 text-slate-400" />
                      <span className="text-xs text-slate-500">{formatDate(doc.uploaded_at)}</span>
                      {doc.file_size && (
                        <span className="text-xs text-slate-400">· {formatSize(doc.file_size)}</span>
                      )}
                    </div>
                  </div>
                  <div className="flex items-center gap-1 shrink-0">
                    <button
                      onClick={() => handleDownload(doc)}
                      disabled={downloadingId === doc.id}
                      className="p-2 text-slate-500 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors disabled:opacity-50"
                      title="Download"
                    >
                      {downloadingId === doc.id
                        ? <Loader2 className="w-4 h-4 animate-spin" />
                        : <Download className="w-4 h-4" />}
                    </button>
                    {canDelete && (
                      <button
                        onClick={() => handleDelete(doc)}
                        disabled={deletingId === doc.id}
                        className="p-2 text-red-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors disabled:opacity-50"
                        title="Delete"
                      >
                        {deletingId === doc.id
                          ? <Loader2 className="w-4 h-4 animate-spin" />
                          : <Trash2 className="w-4 h-4" />}
                      </button>
                    )}
                  </div>
                </li>
              ))}
            </ul>
          )}
        </div>

        {/* Footer count */}
        {documents.length > 0 && (
          <div className="px-6 py-3 border-t border-slate-100 bg-slate-50 rounded-b-xl">
            <p className="text-xs text-slate-400">{documents.length} document{documents.length !== 1 ? 's' : ''}</p>
          </div>
        )}
      </div>
    </div>
  );
}
