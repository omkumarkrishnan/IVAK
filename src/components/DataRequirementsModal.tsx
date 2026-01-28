import { X, FileCheck } from 'lucide-react';
import { DLI } from '../types/database';

interface DataRequirementsModalProps {
  isOpen: boolean;
  dli: DLI | null;
  onClose: () => void;
}

export function DataRequirementsModal({
  isOpen,
  dli,
  onClose,
}: DataRequirementsModalProps) {
  if (!isOpen || !dli) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 p-4 overflow-y-auto">
      <div className="bg-white rounded-lg shadow-xl max-w-4xl w-full my-8">
        <div className="flex items-start gap-4 p-6 border-b border-slate-200">
          <div className="flex-shrink-0 text-green-600">
            <FileCheck className="w-6 h-6" />
          </div>
          <div className="flex-1 min-w-0">
            <h3 className="text-lg font-semibold text-slate-900 mb-1">Data Requirements</h3>
            <p className="text-sm text-slate-600 font-medium">{dli.code}</p>
            <p className="text-sm text-slate-600">{dli.description}</p>
          </div>
          <button
            onClick={onClose}
            className="flex-shrink-0 text-slate-400 hover:text-slate-600 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 max-h-[60vh] overflow-y-auto">
          {dli.data_requirements && dli.data_requirements.length > 0 ? (
            <div className="prose prose-sm max-w-none">
              <ul className="space-y-2">
                {dli.data_requirements.map((requirement, index) => (
                  <li key={index} className="text-slate-700 leading-relaxed">
                    {requirement}
                  </li>
                ))}
              </ul>
            </div>
          ) : (
            <div className="text-center py-8">
              <FileCheck className="w-12 h-12 text-slate-300 mx-auto mb-3" />
              <p className="text-slate-500 text-sm">
                No data requirements information available for this DLR.
              </p>
            </div>
          )}
        </div>

        <div className="flex items-center justify-end gap-3 px-6 py-4 bg-slate-50 rounded-b-lg border-t border-slate-200">
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm font-medium text-white bg-green-600 hover:bg-green-700 rounded-lg transition-colors"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  );
}
