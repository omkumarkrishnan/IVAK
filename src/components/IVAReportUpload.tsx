import { useState, useRef } from 'react';
import { FileCheck, File, X, Download, Loader2 } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { IVAReport } from '../types/database';
import { useAuth } from '../contexts/AuthContext';

interface IVAReportUploadProps {
  dliId: string;
  dliCode: string;
  reports: IVAReport[];
  onReportChange: () => void;
  userRole?: string;
}

export function IVAReportUpload({ dliId, dliCode, reports, onReportChange, userRole }: IVAReportUploadProps) {
  const { user } = useAuth();
  const [uploading, setUploading] = useState(false);
  const [deletingId, setDeletingId] = useState<string | null>(null);
  const [showUploadModal, setShowUploadModal] = useState(false);
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const canUpload = ['admin', 'consultant', 'field_agent', 'iva'].includes(userRole || '');

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      setSelectedFile(file);
      setShowUploadModal(true);
    }
  };

  const handleUpload = async () => {
    if (!selectedFile || !user) return;

    setUploading(true);
    try {
      const fileExt = selectedFile.name.split('.').pop();
      const fileName = `${user.id}/${dliId}/${Date.now()}.${fileExt}`;

      const { error: uploadError } = await supabase.storage
        .from('iva-reports')
        .upload(fileName, selectedFile);

      if (uploadError) throw uploadError;

      const reportName = `IVA Report ${dliCode}`;

      const { error: dbError } = await supabase.from('iva_reports').insert({
        dli_id: dliId,
        report_name: reportName,
        file_name: selectedFile.name,
        file_path: fileName,
        file_size: selectedFile.size,
        mime_type: selectedFile.type,
        uploaded_by: user.id,
      });

      if (dbError) throw dbError;

      onReportChange();
      setShowUploadModal(false);
      setSelectedFile(null);
      if (fileInputRef.current) {
        fileInputRef.current.value = '';
      }
    } catch (error) {
      console.error('Error uploading IVA report:', error);
      alert('Failed to upload IVA report. Please try again.');
    } finally {
      setUploading(false);
    }
  };

  const handleReportDelete = async (reportId: string, filePath: string) => {
    if (!confirm('Are you sure you want to delete this IVA report?')) return;

    setDeletingId(reportId);
    try {
      const { error: storageError } = await supabase.storage
        .from('iva-reports')
        .remove([filePath]);

      if (storageError) throw storageError;

      const { error: dbError } = await supabase
        .from('iva_reports')
        .delete()
        .eq('id', reportId);

      if (dbError) throw dbError;

      onReportChange();
    } catch (error) {
      console.error('Error deleting IVA report:', error);
      alert('Failed to delete IVA report. Please try again.');
    } finally {
      setDeletingId(null);
    }
  };

  const handleReportDownload = async (filePath: string, fileName: string) => {
    try {
      const { data, error } = await supabase.storage
        .from('iva-reports')
        .download(filePath);

      if (error) throw error;

      const url = URL.createObjectURL(data);
      const a = document.createElement('a');
      a.href = url;
      a.download = fileName;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      URL.revokeObjectURL(url);
    } catch (error) {
      console.error('Error downloading IVA report:', error);
      alert('Failed to download IVA report. Please try again.');
    }
  };

  const formatFileSize = (bytes: number | null) => {
    if (!bytes) return 'Unknown size';
    if (bytes < 1024) return bytes + ' B';
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
    return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  return (
    <div className="mt-3 space-y-3">
      <div className="flex items-center gap-2">
        {canUpload && (
          <>
            <input
              ref={fileInputRef}
              type="file"
              onChange={handleFileSelect}
              disabled={uploading}
              className="hidden"
              id={`iva-report-upload-${dliId}`}
              accept=".pdf,.doc,.docx,.xls,.xlsx"
            />
            <label
              htmlFor={`iva-report-upload-${dliId}`}
              className={`flex items-center gap-2 px-3 py-2 text-sm font-medium rounded-lg transition-colors cursor-pointer ${
                uploading
                  ? 'bg-green-200 text-green-700 cursor-not-allowed'
                  : 'bg-green-600 text-white hover:bg-green-700'
              }`}
            >
              {uploading ? (
                <>
                  <Loader2 className="w-4 h-4 animate-spin" />
                  Uploading...
                </>
              ) : (
                <>
                  <FileCheck className="w-4 h-4" />
                  Upload IVA Report
                </>
              )}
            </label>
          </>
        )}
      </div>

      {reports.length > 0 && (
        <div className="space-y-2">
          {reports.map((report) => (
            <div
              key={report.id}
              className="flex items-center justify-between p-3 bg-green-50 border border-green-200 rounded-lg"
            >
              <div className="flex items-center gap-3 flex-1 min-w-0">
                <FileCheck className="w-4 h-4 text-green-600 flex-shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium text-green-900 truncate">
                    {report.report_name}
                  </p>
                  <p className="text-xs text-green-700">
                    {report.file_name}
                  </p>
                  <p className="text-xs text-green-600">
                    {formatFileSize(report.file_size)} • {formatDate(report.uploaded_at)}
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <button
                  onClick={() => handleReportDownload(report.file_path, report.file_name)}
                  className="p-1.5 text-green-600 hover:text-green-900 hover:bg-green-100 rounded transition-colors"
                  title="Download IVA report"
                >
                  <Download className="w-4 h-4" />
                </button>
                {canUpload && (
                  <button
                    onClick={() => handleReportDelete(report.id, report.file_path)}
                    disabled={deletingId === report.id}
                    className="p-1.5 text-red-600 hover:text-red-700 hover:bg-red-50 rounded transition-colors disabled:opacity-50"
                    title="Delete IVA report"
                  >
                    {deletingId === report.id ? (
                      <Loader2 className="w-4 h-4 animate-spin" />
                    ) : (
                      <X className="w-4 h-4" />
                    )}
                  </button>
                )}
              </div>
            </div>
          ))}
        </div>
      )}

      {showUploadModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
            <h3 className="text-lg font-semibold text-slate-900 mb-4">
              Upload IVA Verification Report
            </h3>
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Report Name
                </label>
                <input
                  type="text"
                  value={`IVA Report ${dliCode}`}
                  disabled
                  className="w-full px-3 py-2 border border-slate-300 rounded-lg bg-slate-50 text-slate-900"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Selected File
                </label>
                <div className="flex items-center gap-2 p-3 bg-slate-50 border border-slate-200 rounded-lg">
                  <File className="w-4 h-4 text-slate-600" />
                  <span className="text-sm text-slate-900 truncate">
                    {selectedFile?.name}
                  </span>
                </div>
              </div>
              <div className="flex gap-3 pt-4">
                <button
                  onClick={() => {
                    setShowUploadModal(false);
                    setSelectedFile(null);
                    if (fileInputRef.current) {
                      fileInputRef.current.value = '';
                    }
                  }}
                  disabled={uploading}
                  className="flex-1 px-4 py-2 text-sm font-medium text-slate-700 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors disabled:opacity-50"
                >
                  Cancel
                </button>
                <button
                  onClick={handleUpload}
                  disabled={uploading}
                  className="flex-1 px-4 py-2 text-sm font-medium text-white bg-green-600 hover:bg-green-700 rounded-lg transition-colors disabled:opacity-50 flex items-center justify-center gap-2"
                >
                  {uploading ? (
                    <>
                      <Loader2 className="w-4 h-4 animate-spin" />
                      Uploading...
                    </>
                  ) : (
                    'Upload Report'
                  )}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
