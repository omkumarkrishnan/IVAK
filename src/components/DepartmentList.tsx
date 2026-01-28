import { useState } from 'react';
import { ChevronDown, ChevronRight, CheckCircle, Clock, FileText, Info, FileCheck } from 'lucide-react';
import { DepartmentWithDLIs, Verification, DLI } from '../types/database';
import { supabase } from '../lib/supabase';
import { FileUpload } from './FileUpload';
import { IVAReportUpload } from './IVAReportUpload';
import { VerificationMethodologyModal } from './VerificationMethodologyModal';
import { DataRequirementsModal } from './DataRequirementsModal';

interface DepartmentListProps {
  departments: DepartmentWithDLIs[];
  onVerificationUpdate: () => void;
  userRole?: string;
}

export function DepartmentList({ departments, onVerificationUpdate, userRole }: DepartmentListProps) {
  const [expandedDepts, setExpandedDepts] = useState<Set<string>>(new Set());
  const [expandedDlis, setExpandedDlis] = useState<Set<string>>(new Set());
  const [isMethodologyModalOpen, setIsMethodologyModalOpen] = useState(false);
  const [selectedVerification, setSelectedVerification] = useState<Verification | null>(null);
  const [isDataRequirementsModalOpen, setIsDataRequirementsModalOpen] = useState(false);
  const [selectedDli, setSelectedDli] = useState<DLI | null>(null);

  const toggleDepartment = (deptId: string) => {
    const newExpanded = new Set(expandedDepts);
    if (newExpanded.has(deptId)) {
      newExpanded.delete(deptId);
    } else {
      newExpanded.add(deptId);
    }
    setExpandedDepts(newExpanded);
  };

  const toggleDli = (dliId: string) => {
    const newExpanded = new Set(expandedDlis);
    if (newExpanded.has(dliId)) {
      newExpanded.delete(dliId);
    } else {
      newExpanded.add(dliId);
    }
    setExpandedDlis(newExpanded);
  };

  const updateVerificationState = async (verificationId: string, newState: string) => {
    const { error } = await supabase
      .from('verifications')
      .update({ state: newState })
      .eq('id', verificationId);

    if (!error) {
      onVerificationUpdate();
    }
  };

  const getStateIcon = (state: string) => {
    switch (state) {
      case 'verified':
        return <CheckCircle className="w-4 h-4 text-green-600" />;
      case 'submitted':
        return <Clock className="w-4 h-4 text-amber-600" />;
      default:
        return <FileText className="w-4 h-4 text-slate-400" />;
    }
  };

  const getStateColor = (state: string) => {
    switch (state) {
      case 'verified':
        return 'bg-green-50 text-green-700 border-green-200';
      case 'submitted':
        return 'bg-amber-50 text-amber-700 border-amber-200';
      default:
        return 'bg-slate-50 text-slate-700 border-slate-200';
    }
  };

  const getStateLabel = (state: string) => {
    switch (state) {
      case 'verified':
        return 'Verified';
      case 'submitted':
        return 'Submitted';
      default:
        return 'Not Verified';
    }
  };

  const openMethodologyModal = (verification: Verification) => {
    setSelectedVerification(verification);
    setIsMethodologyModalOpen(true);
  };

  const closeMethodologyModal = () => {
    setIsMethodologyModalOpen(false);
    setSelectedVerification(null);
  };

  const openDataRequirementsModal = (dli: DLI) => {
    setSelectedDli(dli);
    setIsDataRequirementsModalOpen(true);
  };

  const closeDataRequirementsModal = () => {
    setIsDataRequirementsModalOpen(false);
    setSelectedDli(null);
  };

  return (
    <div className="space-y-4">
      {departments.map((dept) => (
        <div key={dept.id} className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
          <button
            onClick={() => toggleDepartment(dept.id)}
            className="w-full px-6 py-4 flex items-center justify-between hover:bg-slate-50 transition-colors"
          >
            <div className="flex items-center gap-3">
              {expandedDepts.has(dept.id) ? (
                <ChevronDown className="w-5 h-5 text-slate-600" />
              ) : (
                <ChevronRight className="w-5 h-5 text-slate-600" />
              )}
              <h3 className="text-lg font-semibold text-slate-900">{dept.name}</h3>
              <span className="px-2 py-1 bg-slate-100 text-slate-600 text-xs font-medium rounded">
                {dept.dlis.length} DLRs
              </span>
            </div>
          </button>

          {expandedDepts.has(dept.id) && (
            <div className="px-6 pb-4 space-y-3">
              {dept.dlis.map((dli) => (
                <div key={dli.id} className="border border-slate-200 rounded-lg overflow-hidden">
                  <button
                    onClick={() => toggleDli(dli.id)}
                    className="w-full px-4 py-3 flex items-start gap-3 hover:bg-slate-50 transition-colors text-left"
                  >
                    {expandedDlis.has(dli.id) ? (
                      <ChevronDown className="w-4 h-4 text-slate-600 mt-1 flex-shrink-0" />
                    ) : (
                      <ChevronRight className="w-4 h-4 text-slate-600 mt-1 flex-shrink-0" />
                    )}
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2 flex-wrap mb-1">
                        <span className="font-semibold text-slate-900">{dli.code}</span>
                        {dli.period && (
                          <span className="px-2 py-0.5 bg-blue-100 text-blue-700 text-xs font-medium rounded">
                            {dli.period.name}
                          </span>
                        )}
                      </div>
                      <p className="text-sm text-slate-600">{dli.description}</p>
                    </div>
                  </button>

                  {expandedDlis.has(dli.id) && (
                    <div className="px-4 pb-3 pl-11 space-y-4">
                      {dli.verifications && dli.verifications.length > 0 && (
                        <div className="space-y-2">
                          <div className="flex items-center justify-between gap-3">
                            <h4 className="text-sm font-semibold text-slate-700">Verifications</h4>
                            <div className="flex items-center gap-2">
                              {dli.verifications.some(v => v.methodology) && userRole !== 'client' && userRole !== 'field_agent' && (
                                <button
                                  onClick={() => openMethodologyModal(dli.verifications.find(v => v.methodology)!)}
                                  className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium text-blue-600 hover:text-blue-700 hover:bg-blue-50 rounded transition-colors"
                                  title="View Verification Methodology"
                                >
                                  <Info className="w-3.5 h-3.5" />
                                  <span>Methodology</span>
                                </button>
                              )}
                              {dli.data_requirements && dli.data_requirements.length > 0 && (
                                <button
                                  onClick={() => openDataRequirementsModal(dli)}
                                  className="flex items-center gap-1 px-3 py-1.5 text-xs font-medium text-green-600 hover:text-green-700 hover:bg-green-50 rounded transition-colors"
                                  title="View Data Requirements"
                                >
                                  <FileCheck className="w-3.5 h-3.5" />
                                  <span>Data Requirements</span>
                                </button>
                              )}
                            </div>
                          </div>
                          {dli.verification_heading && (
                            <div className="text-xs text-slate-600 mb-3 whitespace-pre-line bg-slate-50 p-2 rounded border border-slate-200">
                              {dli.verification_heading}
                            </div>
                          )}
                          {dli.verifications.map((verification) => (
                            <div
                              key={verification.id}
                              className="flex items-start gap-3 p-3 bg-slate-50 rounded-lg"
                            >
                              {getStateIcon(verification.state)}
                              <div className="flex-1 min-w-0">
                                <p className="text-sm text-slate-700 mb-2">{verification.description}</p>
                                <div className="flex items-center gap-2">
                                  <span className="text-xs text-slate-500">Status:</span>
                                  <select
                                    value={verification.state}
                                    onChange={(e) => updateVerificationState(verification.id, e.target.value)}
                                    disabled={userRole === 'client'}
                                    className={`text-xs px-2 py-1 border rounded font-medium ${getStateColor(verification.state)} ${
                                      userRole === 'client' ? 'opacity-60 cursor-not-allowed' : 'cursor-pointer'
                                    }`}
                                  >
                                    <option value="non-verified">Not Verified</option>
                                    <option value="submitted">Submitted</option>
                                    <option value="verified">Verified</option>
                                  </select>
                                </div>
                              </div>
                            </div>
                          ))}
                        </div>
                      )}

                      <div>
                        <h4 className="text-sm font-semibold text-slate-700 mb-2">Attachments</h4>
                        <div className="flex gap-2">
                          <FileUpload
                            dliId={dli.id}
                            files={dli.files || []}
                            onFileChange={onVerificationUpdate}
                          />
                        </div>
                      </div>

                      <div>
                        <h4 className="text-sm font-semibold text-slate-700 mb-2">IVA Verification Reports</h4>
                        <IVAReportUpload
                          dliId={dli.id}
                          dliCode={dli.code}
                          reports={dli.iva_reports || []}
                          onReportChange={onVerificationUpdate}
                          userRole={userRole}
                        />
                      </div>
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      ))}

      <VerificationMethodologyModal
        isOpen={isMethodologyModalOpen}
        verification={selectedVerification}
        onClose={closeMethodologyModal}
      />

      <DataRequirementsModal
        isOpen={isDataRequirementsModalOpen}
        dli={selectedDli}
        onClose={closeDataRequirementsModal}
      />
    </div>
  );
}
