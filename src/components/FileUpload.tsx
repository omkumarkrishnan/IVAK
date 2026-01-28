import { useState, useRef } from 'react';
import { Upload, File, X, Download, Loader2 } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { DLIFile } from '../types/database';
import { useAuth } from '../contexts/AuthContext';

interface FileUploadProps {
  dliId: string;
  files: DLIFile[];
  onFileChange: () => void;
}

const MAX_FILES = 7;

export function FileUpload({ dliId, files, onFileChange }: FileUploadProps) {
  const { user } = useAuth();
  const [uploading, setUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState<{ [key: string]: boolean }>({});
  const [deletingId, setDeletingId] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileUpload = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const selectedFiles = event.target.files;
    if (!selectedFiles || selectedFiles.length === 0 || !user) return;

    const currentFileCount = files.length;
    const newFileCount = selectedFiles.length;
    const totalFileCount = currentFileCount + newFileCount;

    if (totalFileCount > MAX_FILES) {
      alert(`You can only upload up to ${MAX_FILES} files total. You currently have ${currentFileCount} file(s) and are trying to add ${newFileCount} more.`);
      if (fileInputRef.current) {
        fileInputRef.current.value = '';
      }
      return;
    }

    setUploading(true);
    const filesToUpload = Array.from(selectedFiles);
    const uploadPromises = filesToUpload.map(async (file) => {
      const fileId = `${file.name}-${Date.now()}`;
      setUploadProgress(prev => ({ ...prev, [fileId]: true }));

      try {
        const fileExt = file.name.split('.').pop();
        const fileName = `${user.id}/${dliId}/${Date.now()}-${Math.random().toString(36).substring(7)}.${fileExt}`;

        const { error: uploadError } = await supabase.storage
          .from('dli-files')
          .upload(fileName, file);

        if (uploadError) throw uploadError;

        const { error: dbError } = await supabase.from('dli_files').insert({
          dli_id: dliId,
          file_name: file.name,
          file_path: fileName,
          file_size: file.size,
          mime_type: file.type,
          uploaded_by: user.id,
        });

        if (dbError) throw dbError;

        setUploadProgress(prev => {
          const newProgress = { ...prev };
          delete newProgress[fileId];
          return newProgress;
        });

        return { success: true, fileName: file.name };
      } catch (error) {
        console.error('Error uploading file:', file.name, error);
        setUploadProgress(prev => {
          const newProgress = { ...prev };
          delete newProgress[fileId];
          return newProgress;
        });
        return { success: false, fileName: file.name, error };
      }
    });

    try {
      const results = await Promise.all(uploadPromises);
      const failedUploads = results.filter(r => !r.success);

      if (failedUploads.length > 0) {
        alert(`Failed to upload ${failedUploads.length} file(s): ${failedUploads.map(f => f.fileName).join(', ')}`);
      }

      onFileChange();
      if (fileInputRef.current) {
        fileInputRef.current.value = '';
      }
    } catch (error) {
      console.error('Error in upload process:', error);
      alert('Failed to upload files. Please try again.');
    } finally {
      setUploading(false);
      setUploadProgress({});
    }
  };

  const handleFileDelete = async (fileId: string, filePath: string) => {
    if (!confirm('Are you sure you want to delete this file?')) return;

    setDeletingId(fileId);
    try {
      const { error: storageError } = await supabase.storage
        .from('dli-files')
        .remove([filePath]);

      if (storageError) throw storageError;

      const { error: dbError } = await supabase
        .from('dli_files')
        .delete()
        .eq('id', fileId);

      if (dbError) throw dbError;

      onFileChange();
    } catch (error) {
      console.error('Error deleting file:', error);
      alert('Failed to delete file. Please try again.');
    } finally {
      setDeletingId(null);
    }
  };

  const handleFileDownload = async (filePath: string, fileName: string) => {
    try {
      const { data, error } = await supabase.storage
        .from('dli-files')
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
      console.error('Error downloading file:', error);
      alert('Failed to download file. Please try again.');
    }
  };

  const formatFileSize = (bytes: number | null) => {
    if (!bytes) return 'Unknown size';
    if (bytes < 1024) return bytes + ' B';
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
    return (bytes / (1024 * 1024)).toFixed(1) + ' MB';
  };

  const remainingSlots = MAX_FILES - files.length;
  const canUpload = remainingSlots > 0;

  return (
    <div className="mt-3 space-y-3">
      <div className="flex items-center gap-2">
        <input
          ref={fileInputRef}
          type="file"
          multiple
          onChange={handleFileUpload}
          disabled={uploading || !canUpload}
          className="hidden"
          id={`file-upload-${dliId}`}
        />
        <label
          htmlFor={`file-upload-${dliId}`}
          className={`flex items-center gap-2 px-3 py-2 text-sm font-medium rounded-lg transition-colors ${
            uploading || !canUpload
              ? 'bg-slate-200 text-slate-500 cursor-not-allowed'
              : 'bg-slate-900 text-white hover:bg-slate-800 cursor-pointer'
          }`}
        >
          {uploading ? (
            <>
              <Loader2 className="w-4 h-4 animate-spin" />
              Uploading...
            </>
          ) : (
            <>
              <Upload className="w-4 h-4" />
              Upload File{remainingSlots !== 1 ? 's' : ''}
            </>
          )}
        </label>
        {canUpload && (
          <span className="text-xs text-slate-500">
            {remainingSlots} of {MAX_FILES} slot{remainingSlots !== 1 ? 's' : ''} available
          </span>
        )}
        {!canUpload && (
          <span className="text-xs text-amber-600 font-medium">
            Maximum {MAX_FILES} files reached
          </span>
        )}
      </div>

      {files.length > 0 && (
        <div className="space-y-2">
          {files.map((file) => (
            <div
              key={file.id}
              className="flex items-center justify-between p-3 bg-white border border-slate-200 rounded-lg"
            >
              <div className="flex items-center gap-3 flex-1 min-w-0">
                <File className="w-4 h-4 text-slate-600 flex-shrink-0" />
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium text-slate-900 truncate">
                    {file.file_name}
                  </p>
                  <p className="text-xs text-slate-500">
                    {formatFileSize(file.file_size)}
                  </p>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <button
                  onClick={() => handleFileDownload(file.file_path, file.file_name)}
                  className="p-1.5 text-slate-600 hover:text-slate-900 hover:bg-slate-100 rounded transition-colors"
                  title="Download file"
                >
                  <Download className="w-4 h-4" />
                </button>
                <button
                  onClick={() => handleFileDelete(file.id, file.file_path)}
                  disabled={deletingId === file.id}
                  className="p-1.5 text-red-600 hover:text-red-700 hover:bg-red-50 rounded transition-colors disabled:opacity-50"
                  title="Delete file"
                >
                  {deletingId === file.id ? (
                    <Loader2 className="w-4 h-4 animate-spin" />
                  ) : (
                    <X className="w-4 h-4" />
                  )}
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
