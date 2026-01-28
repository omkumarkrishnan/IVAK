import { useEffect, useState } from 'react';
import { useAuth } from '../contexts/AuthContext';
import { LogOut, User, RefreshCw, BarChart3, Trash2, UserPlus, Users } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { DepartmentWithDLIs } from '../types/database';
import { DepartmentList } from '../components/DepartmentList';
import { ConfirmationModal } from '../components/ConfirmationModal';
import { AddUserModal } from '../components/AddUserModal';
import { UserManagement } from '../components/UserManagement';

interface HomePageProps {
  onNavigateDashboard: () => void;
}

export function HomePage({ onNavigateDashboard }: HomePageProps) {
  const { profile, signOut } = useAuth();
  const [departments, setDepartments] = useState<DepartmentWithDLIs[]>([]);
  const [loading, setLoading] = useState(true);
  const [showClearConfirm, setShowClearConfirm] = useState(false);
  const [clearing, setClearing] = useState(false);
  const [showAddUserModal, setShowAddUserModal] = useState(false);
  const [showUserManagement, setShowUserManagement] = useState(false);

  useEffect(() => {
    console.log('Profile:', profile);
    console.log('Profile role:', profile?.role);
    console.log('Is admin:', profile?.role === 'admin');
  }, [profile]);

  const fetchDepartments = async () => {
    setLoading(true);
    try {
      const { data: deptData, error: deptError } = await supabase
        .from('departments')
        .select('*')
        .order('dli_number');

      if (deptError) throw deptError;

      const { data: dliData, error: dliError } = await supabase
        .from('dlis')
        .select(`
          *,
          period:periods(*)
        `)
        .order('code');

      if (dliError) throw dliError;

      const { data: verificationData, error: verificationError } = await supabase
        .from('verifications')
        .select('*')
        .order('created_at');

      if (verificationError) throw verificationError;

      const { data: filesData, error: filesError } = await supabase
        .from('dli_files')
        .select('*')
        .order('created_at');

      if (filesError) throw filesError;

      const { data: ivaReportsData, error: ivaReportsError } = await supabase
        .from('iva_reports')
        .select('*')
        .order('uploaded_at');

      if (ivaReportsError) throw ivaReportsError;

      const departmentsWithDLIs: DepartmentWithDLIs[] = (deptData || []).map((dept) => ({
        ...dept,
        dlis: (dliData || [])
          .filter((dli) => dli.department_id === dept.id)
          .map((dli) => ({
            ...dli,
            verifications: (verificationData || []).filter((v) => v.dli_id === dli.id),
            files: (filesData || []).filter((f) => f.dli_id === dli.id),
            iva_reports: (ivaReportsData || []).filter((r) => r.dli_id === dli.id),
          })),
      }));

      setDepartments(departmentsWithDLIs);
    } catch (error) {
      console.error('Error fetching departments:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchDepartments();
  }, []);

  const handleClearData = async () => {
    setClearing(true);
    try {
      await supabase.from('iva_reports').delete().neq('id', '00000000-0000-0000-0000-000000000000');
      await supabase.from('dli_files').delete().neq('id', '00000000-0000-0000-0000-000000000000');
      await supabase.from('verifications').delete().neq('id', '00000000-0000-0000-0000-000000000000');
      await supabase.from('dlis').delete().neq('id', '00000000-0000-0000-0000-000000000000');
      await supabase.from('periods').delete().neq('id', '00000000-0000-0000-0000-000000000000');
      await supabase.from('departments').delete().neq('id', '00000000-0000-0000-0000-000000000000');

      setShowClearConfirm(false);
      await fetchDepartments();
    } catch (error) {
      console.error('Error clearing data:', error);
    } finally {
      setClearing(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <nav className="bg-white shadow-sm border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-slate-900 rounded-lg flex items-center justify-center">
                <span className="text-white font-bold text-lg">CESI</span>
              </div>
              <h1 className="text-xl font-bold text-slate-900">Sikkim: INSPIRES IVA@IIMK</h1>
            </div>

            <div className="flex items-center gap-4">
              {profile && (
                <div className="flex items-center gap-2 px-3 py-1.5 bg-slate-100 rounded-lg">
                  <User className="w-4 h-4 text-slate-600" />
                  <span className="text-sm font-medium text-slate-700">
                    {profile.email} ({profile.role})
                  </span>
                </div>
              )}
              {profile?.role === 'admin' && (
                <>
                  <button
                    onClick={() => setShowAddUserModal(true)}
                    className="flex items-center gap-2 px-4 py-2 bg-slate-900 text-white hover:bg-slate-800 rounded-lg transition-colors"
                  >
                    <UserPlus className="w-4 h-4" />
                    <span className="text-sm font-medium">Add User</span>
                  </button>
                  <button
                    onClick={() => setShowUserManagement(true)}
                    className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors"
                  >
                    <Users className="w-4 h-4" />
                    <span className="text-sm font-medium">Manage Users</span>
                  </button>
                </>
              )}
              {profile?.role !== 'client' && (
                <button
                  onClick={onNavigateDashboard}
                  className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors"
                >
                  <BarChart3 className="w-4 h-4" />
                  <span className="text-sm font-medium">Dashboard</span>
                </button>
              )}
              <button
                onClick={fetchDepartments}
                className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors"
              >
                <RefreshCw className="w-4 h-4" />
                <span className="text-sm font-medium">Refresh</span>
              </button>
              {profile?.role === 'admin' && (
                <button
                  onClick={() => setShowClearConfirm(true)}
                  className="flex items-center gap-2 px-4 py-2 text-red-700 hover:text-red-900 hover:bg-red-50 rounded-lg transition-colors"
                >
                  <Trash2 className="w-4 h-4" />
                  <span className="text-sm font-medium">Clear Data</span>
                </button>
              )}
              <button
                onClick={signOut}
                className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors"
              >
                <LogOut className="w-4 h-4" />
                <span className="text-sm font-medium">Sign Out</span>
              </button>
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="mb-6">
          <h2 className="text-3xl font-bold text-slate-900 mb-2">
            Departments & DLIs
          </h2>
          <p className="text-slate-600">
            Manage Disbursement Linked Indicators and their verifications
          </p>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-slate-900"></div>
          </div>
        ) : (
          <DepartmentList
            departments={departments}
            onVerificationUpdate={fetchDepartments}
            userRole={profile?.role}
          />
        )}
      </main>

      <ConfirmationModal
        isOpen={showClearConfirm}
        title="Clear All Data"
        message="This action will permanently delete ALL data including departments, periods, DLIs, verifications, and uploaded files. The entire database will be cleared. This action cannot be undone. Are you sure you want to proceed?"
        confirmLabel={clearing ? 'Clearing...' : 'Clear All Data'}
        cancelLabel="Cancel"
        variant="danger"
        onConfirm={handleClearData}
        onCancel={() => setShowClearConfirm(false)}
      />

      {showAddUserModal && (
        <AddUserModal
          onClose={() => setShowAddUserModal(false)}
          onSuccess={() => {
            setShowAddUserModal(false);
          }}
        />
      )}

      {showUserManagement && (
        <UserManagement onClose={() => setShowUserManagement(false)} />
      )}
    </div>
  );
}
