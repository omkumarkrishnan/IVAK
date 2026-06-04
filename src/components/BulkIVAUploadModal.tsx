import { useState, useRef, useEffect } from 'react';
import { X, Upload, FileCheck, Loader2, AlertCircle, CheckCircle } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { DLI } from '../types/database';
import { useAuth } from '../contexts/AuthContext';

interface FileEntry {
  id: string;
  file: File;
  dliId: string;
  status: 'pending' | 'uploading' | 'done' | 'error';
  error?: string;
}

interface BulkIVAUploadModalProps {
  onClose: () => void;
  onComplete: () => void;
}

function detectDliFromFilename(filename: string, dlis: DLI[]): string {
  const lower = filename.toLowerCase();
  for (const dli of dlis) {
    const code = dli.code; // e.g. "1.0.1"
    const variants = [
      code,
      code.replace(/\./g, '_'),
      code.replace(/\./g, '-'),
    ];
    for (const variant of variants) {
      const escaped = variant.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
      if (new RegExp(`(^|[^\\d])${escaped}([^\\d]|$)`).test(lower)) {
        return dli.id;
      }
    }
  }
  return '';
}

function formatFileSize(bytes: number) {
  if (bytes < 1024) return bytes + ' B';
  if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
  return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
}

export function BulkIVAUploadModal({ onClose, onComplete }: BulkIVAUploadModalProps) {
  const { user } = useAuth();
  const [dlis, setDlis] = useState<DLI[]>([]);
  const [entries, setEntries] = useState<FileEntry[]>([]);
  const [uploading, setUploading] = useState(false);
  const [loadingDlis, setLoadingDlis] = useState(true);
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    supabase
      .from('dlis')
      .select('*, period:periods(*)')
      .order('code')
      .then(({ data }) => {
        setDlis(data || []);
        setLoadingDlis(false);
      });
  }, []);

  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || []);
    const newEntries: FileEntry[] = files.map((file) => ({
      id: `${file.name}-${Date.now()}-${Math.random()}`,
      file,
      dliId: detectDliFromFilename(file.name, dlis),
      status: 'pending',
    }));
    setEntries((prev) => [...prev, ...newEntries]);
    if (fileInputRef.current) fileInputRef.current.value = '';
  };

  const handleDliChange = (entryId: string, dliId: string) => {
    setEntries((prev) => prev.map((e) => (e.id === entryId ? { ...e, dliId } : e)));
  };

  const handleRemove = (entryId: string) => {
    setEntries((prev) => prev.filter((e) => e.id !== entryId));
  };

  const handleUploadAll = async () => {
    if (!user) return;
    const toUpload = entries.filter((e) => e.dliId && e.status === 'pending');
    if (!toUpload.length) return;

    setUploading(true);

    for (const entry of toUpload) {
      setEntries((prev) =>
        prev.map((e) => (e.id === entry.id ? { ...e, status: 'uploading' } : e))
      );

      try {
        const dli = dlis.find((d) => d.id === entry.dliId)!;
        const ext = entry.file.name.split('.').pop();
        const filePath = `${user.id}/${entry.dliId}/${Date.now()}.${ext}`;

        const { error: uploadError } = await supabase.storage
          .from('iva-reports')
          .upload(filePath, entry.file);

        if (uploadError) throw uploadError;

        const { error: dbError } = await supabase.from('iva_reports').insert({
          dli_id: entry.dliId,
          report_name: `IVA Report ${dli.code}`,
          file_name: entry.file.name,
          file_path: filePath,
          file_size: entry.file.size,
          mime_type: entry.file.type,
          uploaded_by: user.id,
        });

        if (dbError) throw dbError;

        setEntries((prev) =>
          prev.map((e) => (e.id === entry.id ? { ...e, status: 'done' } : e))
        );
      } catch (err: any) {
        setEntries((prev) =>
          prev.map((e) =>
            e.id === entry.id
              ? { ...e, status: 'error', error: err.message || 'Upload failed' }
              : e
          )
        );
      }
    }

    setUploading(false);
    onComplete();
  };

  const pendingWithDli = entries.filter((e) => e.status === 'pending' && e.dliId).length;
  const unmapped = entries.filter((e) => e.status === 'pending' && !e.dliId).length;
  const doneCount = entries.filter((e) => e.status === 'done').length;
  const errorCount = entries.filter((e) => e.status === 'error').length;
  const allDone = entries.length > 0 && entries.every((e) => e.status === 'done' || e.status === 'error');

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-xl shadow-2xl w-full max-w-4xl max-h-[90vh] flex flex-col">
        {/* Header */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-slate-200 flex-shrink-0">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center">
              <FileCheck className="w-4 h-4 text-green-600" />
            </div>
            <div>
              <h2 className="text-base font-semibold text-slate-900">Bulk Upload IVA Reports</h2>
              <p className="text-xs text-slate-500">
                Name files with a DLR code (e.g. <span className="font-mono">1.0.1</span>) for auto-matching
              </p>
            </div>
          </div>
          <button
            onClick={onClose}
            disabled={uploading}
            className="p-2 text-slate-400 hover:text-slate-600 hover:bg-slate-100 rounded-lg transition-colors disabled:opacity-40"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Body */}
        <div className="flex-1 overflow-y-auto p-6 space-y-5">
          {/* Drop zone */}
          {!loadingDlis && (
            <>
              <input
                ref={fileInputRef}
                type="file"
                multiple
                accept=".pdf,.doc,.docx,.xls,.xlsx"
                onChange={handleFileSelect}
                className="hidden"
                id="bulk-iva-file-input"
                disabled={uploading}
              />
              <label
                htmlFor="bulk-iva-file-input"
                className={`flex flex-col items-center justify-center w-full py-10 border-2 border-dashed rounded-xl transition-all ${
                  uploading
                    ? 'border-slate-200 bg-slate-50 cursor-not-allowed opacity-60'
                    : 'border-slate-300 hover:border-green-400 hover:bg-green-50 cursor-pointer'
                }`}
              >
                <Upload className="w-8 h-8 text-slate-400 mb-3" />
                <span className="text-sm font-medium text-slate-700">Click to select files</span>
                <span className="text-xs text-slate-500 mt-1">
                  PDF, DOC, DOCX, XLS, XLSX supported
                </span>
              </label>
            </>
          )}

          {loadingDlis && (
            <div className="flex items-center justify-center py-12">
              <Loader2 className="w-6 h-6 animate-spin text-slate-400" />
            </div>
          )}

          {/* File table */}
          {entries.length > 0 && (
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <h3 className="text-sm font-semibold text-slate-700">
                  {entries.length} file{entries.length !== 1 ? 's' : ''}
                </h3>
                <div className="flex items-center gap-4 text-xs">
                  {doneCount > 0 && (
                    <span className="flex items-center gap-1 text-green-600">
                      <CheckCircle className="w-3 h-3" /> {doneCount} uploaded
                    </span>
                  )}
                  {errorCount > 0 && (
                    <span className="flex items-center gap-1 text-red-600">
                      <AlertCircle className="w-3 h-3" /> {errorCount} failed
                    </span>
                  )}
                  {unmapped > 0 && (
                    <span className="text-amber-600">{unmapped} need DLR assignment</span>
                  )}
                </div>
              </div>

              <div className="border border-slate-200 rounded-lg overflow-hidden">
                <table className="w-full">
                  <thead>
                    <tr className="bg-slate-50 border-b border-slate-200">
                      <th className="text-left px-4 py-2.5 text-xs font-semibold text-slate-600 w-[45%]">
                        File
                      </th>
                      <th className="text-left px-4 py-2.5 text-xs font-semibold text-slate-600 w-[35%]">
                        Assign to DLR
                      </th>
                      <th className="text-left px-4 py-2.5 text-xs font-semibold text-slate-600 w-[15%]">
                        Status
                      </th>
                      <th className="px-4 py-2.5 w-[5%]" />
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100">
                    {entries.map((entry) => {
                      const matchedDli = dlis.find((d) => d.id === entry.dliId);
                      return (
                        <tr key={entry.id} className="hover:bg-slate-50 transition-colors">
                          <td className="px-4 py-3">
                            <div className="flex items-center gap-2.5">
                              <FileCheck className="w-4 h-4 text-slate-400 flex-shrink-0" />
                              <div className="min-w-0">
                                <p
                                  className="text-sm font-medium text-slate-900 truncate max-w-[260px]"
                                  title={entry.file.name}
                                >
                                  {entry.file.name}
                                </p>
                                <p className="text-xs text-slate-400">
                                  {formatFileSize(entry.file.size)}
                                </p>
                              </div>
                            </div>
                          </td>
                          <td className="px-4 py-3">
                            {entry.status === 'done' || entry.status === 'uploading' ? (
                              <span className="text-xs text-slate-500">
                                {matchedDli
                                  ? `${matchedDli.code} (${matchedDli.period?.name || ''})`
                                  : '—'}
                              </span>
                            ) : (
                              <select
                                value={entry.dliId}
                                onChange={(e) => handleDliChange(entry.id, e.target.value)}
                                disabled={uploading}
                                className={`text-xs px-2 py-1.5 border rounded-lg w-full focus:outline-none focus:ring-2 focus:ring-green-500 disabled:opacity-60 ${
                                  entry.dliId
                                    ? 'border-slate-300 bg-white text-slate-900'
                                    : 'border-amber-300 bg-amber-50 text-amber-800'
                                }`}
                              >
                                <option value="">-- Select DLR --</option>
                                {dlis.map((dli) => (
                                  <option key={dli.id} value={dli.id}>
                                    {dli.code}
                                    {dli.period ? ` (${dli.period.name})` : ''}
                                  </option>
                                ))}
                              </select>
                            )}
                          </td>
                          <td className="px-4 py-3">
                            {entry.status === 'pending' && entry.dliId && (
                              <span className="text-xs text-slate-500">Ready</span>
                            )}
                            {entry.status === 'pending' && !entry.dliId && (
                              <span className="text-xs text-amber-600 font-medium">Needs DLR</span>
                            )}
                            {entry.status === 'uploading' && (
                              <span className="flex items-center gap-1 text-xs text-blue-600">
                                <Loader2 className="w-3 h-3 animate-spin" />
                                Uploading
                              </span>
                            )}
                            {entry.status === 'done' && (
                              <span className="flex items-center gap-1 text-xs text-green-600 font-medium">
                                <CheckCircle className="w-3 h-3" />
                                Uploaded
                              </span>
                            )}
                            {entry.status === 'error' && (
                              <span
                                className="flex items-center gap-1 text-xs text-red-600 font-medium cursor-help"
                                title={entry.error}
                              >
                                <AlertCircle className="w-3 h-3" />
                                Failed
                              </span>
                            )}
                          </td>
                          <td className="px-4 py-3 text-center">
                            {entry.status !== 'uploading' && entry.status !== 'done' && (
                              <button
                                onClick={() => handleRemove(entry.id)}
                                disabled={uploading}
                                className="p-1 text-slate-300 hover:text-red-500 rounded transition-colors disabled:opacity-40"
                                title="Remove"
                              >
                                <X className="w-3.5 h-3.5" />
                              </button>
                            )}
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            </div>
          )}
        </div>

        {/* Footer */}
        <div className="flex items-center justify-between px-6 py-4 border-t border-slate-200 flex-shrink-0">
          <p className="text-xs text-slate-500">
            {entries.length === 0 && 'Select files to get started'}
            {entries.length > 0 && unmapped > 0 && !allDone &&
              `${unmapped} file${unmapped !== 1 ? 's' : ''} need a DLR assigned`}
            {entries.length > 0 && unmapped === 0 && !allDone && pendingWithDli > 0 &&
              `${pendingWithDli} file${pendingWithDli !== 1 ? 's' : ''} ready to upload`}
            {allDone && `Upload complete — ${doneCount} succeeded${errorCount > 0 ? `, ${errorCount} failed` : ''}`}
          </p>
          <div className="flex items-center gap-3">
            <button
              onClick={onClose}
              disabled={uploading}
              className="px-4 py-2 text-sm font-medium text-slate-700 bg-slate-100 hover:bg-slate-200 rounded-lg transition-colors disabled:opacity-50"
            >
              {allDone ? 'Close' : 'Cancel'}
            </button>
            {pendingWithDli > 0 && (
              <button
                onClick={handleUploadAll}
                disabled={uploading}
                className="flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-green-600 hover:bg-green-700 rounded-lg transition-colors disabled:opacity-50"
              >
                {uploading ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin" />
                    Uploading...
                  </>
                ) : (
                  <>
                    <Upload className="w-4 h-4" />
                    Upload {pendingWithDli} Report{pendingWithDli !== 1 ? 's' : ''}
                  </>
                )}
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
