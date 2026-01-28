import { useEffect, useState } from 'react';
import { useAuth } from '../contexts/AuthContext';
import { LogOut, User, Home, BarChart3, CheckCircle, Clock, FileText, Users } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { Department, Period, DLI, Verification } from '../types/database';
import { UserManagement } from '../components/UserManagement';

interface DashboardProps {
  onNavigateHome: () => void;
}

interface VerificationStats {
  total: number;
  verified: number;
  submitted: number;
  nonVerified: number;
}

interface DepartmentStats extends VerificationStats {
  department: Department;
}

interface PeriodStats extends VerificationStats {
  period: Period;
}

interface DLIStats extends VerificationStats {
  dli: DLI;
}

export function DashboardPage({ onNavigateHome }: DashboardProps) {
  const { profile, signOut } = useAuth();
  const [loading, setLoading] = useState(true);
  const [showUserManagement, setShowUserManagement] = useState(false);
  const [overallStats, setOverallStats] = useState<VerificationStats>({
    total: 0,
    verified: 0,
    submitted: 0,
    nonVerified: 0,
  });
  const [departmentStats, setDepartmentStats] = useState<DepartmentStats[]>([]);
  const [periodStats, setPeriodStats] = useState<PeriodStats[]>([]);
  const [dliStats, setDLIStats] = useState<DLIStats[]>([]);

  // Check if user has dashboard access
  const allowedRoles = ['admin', 'consultant', 'field_agent', 'iva'];
  if (profile && !allowedRoles.includes(profile.role)) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
        <nav className="bg-white shadow-sm border-b border-slate-200">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex justify-between items-center h-16">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 bg-slate-900 rounded-lg flex items-center justify-center">
                  <span className="text-white font-bold text-lg">C</span>
                </div>
                <h1 className="text-xl font-bold text-slate-900">CESI</h1>
              </div>

              <div className="flex items-center gap-4">
                <button
                  onClick={onNavigateHome}
                  className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors"
                >
                  <Home className="w-4 h-4" />
                  <span className="text-sm font-medium">Home</span>
                </button>
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
          <div className="flex items-center justify-center min-h-[60vh]">
            <div className="text-center">
              <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <User className="w-8 h-8 text-red-600" />
              </div>
              <h2 className="text-2xl font-bold text-slate-900 mb-2">Access Denied</h2>
              <p className="text-slate-600 mb-6">
                You need administrator or consultant privileges to access the dashboard.
              </p>
              <button
                onClick={onNavigateHome}
                className="inline-flex items-center gap-2 px-6 py-3 bg-slate-900 text-white rounded-lg hover:bg-slate-800 transition-colors"
              >
                <Home className="w-4 h-4" />
                Return to Home
              </button>
            </div>
          </div>
        </main>
      </div>
    );
  }

  useEffect(() => {
    fetchStats();
  }, []);

  const fetchStats = async () => {
    setLoading(true);
    try {
      const { data: departments } = await supabase.from('departments').select('*').order('dli_number');
      const { data: periods } = await supabase.from('periods').select('*').order('name');
      const { data: dlis } = await supabase.from('dlis').select('*, period:periods(*)').order('code');
      const { data: verifications } = await supabase.from('verifications').select('*');

      const verificationsArray = verifications || [];
      const dlisArray = dlis || [];
      const departmentsArray = departments || [];
      const periodsArray = periods || [];

      const overall: VerificationStats = {
        total: verificationsArray.length,
        verified: verificationsArray.filter((v) => v.state === 'verified').length,
        submitted: verificationsArray.filter((v) => v.state === 'submitted').length,
        nonVerified: verificationsArray.filter((v) => v.state === 'non-verified').length,
      };
      setOverallStats(overall);

      const deptStats: DepartmentStats[] = departmentsArray.map((dept) => {
        const deptDlis = dlisArray.filter((dli) => dli.department_id === dept.id);
        const deptVerifications = verificationsArray.filter((v) =>
          deptDlis.some((dli) => dli.id === v.dli_id)
        );
        return {
          department: dept,
          total: deptVerifications.length,
          verified: deptVerifications.filter((v) => v.state === 'verified').length,
          submitted: deptVerifications.filter((v) => v.state === 'submitted').length,
          nonVerified: deptVerifications.filter((v) => v.state === 'non-verified').length,
        };
      });
      setDepartmentStats(deptStats);

      const periodStatsMap = new Map<string, PeriodStats>();
      periodsArray.forEach((period) => {
        const periodDlis = dlisArray.filter((dli) => dli.period_id === period.id);
        const periodVerifications = verificationsArray.filter((v) =>
          periodDlis.some((dli) => dli.id === v.dli_id)
        );
        periodStatsMap.set(period.id, {
          period,
          total: periodVerifications.length,
          verified: periodVerifications.filter((v) => v.state === 'verified').length,
          submitted: periodVerifications.filter((v) => v.state === 'submitted').length,
          nonVerified: periodVerifications.filter((v) => v.state === 'non-verified').length,
        });
      });
      setPeriodStats(Array.from(periodStatsMap.values()));

      const dliStatsArray: DLIStats[] = dlisArray.map((dli) => {
        const dliVerifications = verificationsArray.filter((v) => v.dli_id === dli.id);
        return {
          dli,
          total: dliVerifications.length,
          verified: dliVerifications.filter((v) => v.state === 'verified').length,
          submitted: dliVerifications.filter((v) => v.state === 'submitted').length,
          nonVerified: dliVerifications.filter((v) => v.state === 'non-verified').length,
        };
      });
      setDLIStats(dliStatsArray);
    } catch (error) {
      console.error('Error fetching stats:', error);
    } finally {
      setLoading(false);
    }
  };

  const getPercentage = (value: number, total: number) => {
    if (total === 0) return 0;
    return Math.round((value / total) * 100);
  };

  const formatDepartmentName = (name: string) => {
    const match = name.match(/^(.+?)\s*\((DLI \d+)\)$/);
    if (match) {
      return (
        <div>
          <div>{match[1]}</div>
          <div className="text-sm text-slate-600">({match[2]})</div>
        </div>
      );
    }
    return name;
  };

  const StatCard = ({ title, stats }: { title: string; stats: VerificationStats }) => (
    <div className="bg-white rounded-lg border border-slate-200 p-6">
      <h3 className="text-lg font-semibold text-slate-900 mb-4">{title}</h3>
      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <CheckCircle className="w-4 h-4 text-green-600" />
            <span className="text-sm text-slate-600">Verified</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-lg font-bold text-green-700">{stats.verified}</span>
            <span className="text-xs text-slate-500">
              ({getPercentage(stats.verified, stats.total)}%)
            </span>
          </div>
        </div>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Clock className="w-4 h-4 text-amber-600" />
            <span className="text-sm text-slate-600">Submitted</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-lg font-bold text-amber-700">{stats.submitted}</span>
            <span className="text-xs text-slate-500">
              ({getPercentage(stats.submitted, stats.total)}%)
            </span>
          </div>
        </div>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <FileText className="w-4 h-4 text-slate-400" />
            <span className="text-sm text-slate-600">Not Verified</span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-lg font-bold text-slate-700">{stats.nonVerified}</span>
            <span className="text-xs text-slate-500">
              ({getPercentage(stats.nonVerified, stats.total)}%)
            </span>
          </div>
        </div>
        <div className="pt-3 border-t border-slate-200">
          <div className="flex items-center justify-between">
            <span className="text-sm font-semibold text-slate-700">Total</span>
            <span className="text-lg font-bold text-slate-900">{stats.total}</span>
          </div>
        </div>
      </div>
    </div>
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <nav className="bg-white shadow-sm border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-slate-900 rounded-lg flex items-center justify-center">
                <span className="text-white font-bold text-lg">C</span>
              </div>
              <h1 className="text-xl font-bold text-slate-900">CESI</h1>
            </div>

            <div className="flex items-center gap-4">
              {profile && (
                <div className="flex items-center gap-2 px-3 py-1.5 bg-slate-100 rounded-lg">
                  <User className="w-4 h-4 text-slate-600" />
                  <span className="text-sm font-medium text-slate-700 capitalize">
                    {profile.role}
                  </span>
                </div>
              )}
              {profile?.role === 'admin' && (
                <button
                  onClick={() => setShowUserManagement(true)}
                  className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors"
                >
                  <Users className="w-4 h-4" />
                  <span className="text-sm font-medium">Manage Users</span>
                </button>
              )}
              <button
                onClick={onNavigateHome}
                className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors"
              >
                <Home className="w-4 h-4" />
                <span className="text-sm font-medium">Home</span>
              </button>
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
          <div className="flex items-center gap-3 mb-2">
            <BarChart3 className="w-8 h-8 text-slate-900" />
            <h2 className="text-3xl font-bold text-slate-900">Dashboard</h2>
          </div>
          <p className="text-slate-600">Overview of verification statuses across all DLIs</p>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-slate-900"></div>
          </div>
        ) : (
          <div className="space-y-8">
            <div>
              <h3 className="text-xl font-semibold text-slate-900 mb-4">Overall Statistics</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                <div className="bg-white rounded-lg border border-slate-200 p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm text-slate-600 mb-1">Total Verifications</p>
                      <p className="text-3xl font-bold text-slate-900">{overallStats.total}</p>
                    </div>
                    <FileText className="w-10 h-10 text-slate-400" />
                  </div>
                </div>
                <div className="bg-white rounded-lg border border-slate-200 p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm text-slate-600 mb-1">Verified</p>
                      <p className="text-3xl font-bold text-green-700">{overallStats.verified}</p>
                      <p className="text-xs text-slate-500 mt-1">
                        {getPercentage(overallStats.verified, overallStats.total)}% complete
                      </p>
                    </div>
                    <CheckCircle className="w-10 h-10 text-green-600" />
                  </div>
                </div>
                <div className="bg-white rounded-lg border border-slate-200 p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm text-slate-600 mb-1">Submitted</p>
                      <p className="text-3xl font-bold text-amber-700">{overallStats.submitted}</p>
                      <p className="text-xs text-slate-500 mt-1">
                        {getPercentage(overallStats.submitted, overallStats.total)}% of total
                      </p>
                    </div>
                    <Clock className="w-10 h-10 text-amber-600" />
                  </div>
                </div>
                <div className="bg-white rounded-lg border border-slate-200 p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm text-slate-600 mb-1">Not Verified</p>
                      <p className="text-3xl font-bold text-slate-700">{overallStats.nonVerified}</p>
                      <p className="text-xs text-slate-500 mt-1">
                        {getPercentage(overallStats.nonVerified, overallStats.total)}% remaining
                      </p>
                    </div>
                    <FileText className="w-10 h-10 text-slate-400" />
                  </div>
                </div>
              </div>
            </div>

            <div>
              <h3 className="text-xl font-semibold text-slate-900 mb-4">By Department</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {departmentStats.map((stat) => (
                  <div key={stat.department.id} className="bg-white rounded-lg border border-slate-200 p-6">
                    <h3 className="text-lg font-semibold text-slate-900 mb-4">{formatDepartmentName(stat.department.name)}</h3>
                    <div className="space-y-3">
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          <CheckCircle className="w-4 h-4 text-green-600" />
                          <span className="text-sm text-slate-600">Verified</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <span className="text-lg font-bold text-green-700">{stat.verified}</span>
                          <span className="text-xs text-slate-500">
                            ({getPercentage(stat.verified, stat.total)}%)
                          </span>
                        </div>
                      </div>
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          <Clock className="w-4 h-4 text-amber-600" />
                          <span className="text-sm text-slate-600">Submitted</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <span className="text-lg font-bold text-amber-700">{stat.submitted}</span>
                          <span className="text-xs text-slate-500">
                            ({getPercentage(stat.submitted, stat.total)}%)
                          </span>
                        </div>
                      </div>
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          <FileText className="w-4 h-4 text-slate-400" />
                          <span className="text-sm text-slate-600">Not Verified</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <span className="text-lg font-bold text-slate-700">{stat.nonVerified}</span>
                          <span className="text-xs text-slate-500">
                            ({getPercentage(stat.nonVerified, stat.total)}%)
                          </span>
                        </div>
                      </div>
                      <div className="pt-3 border-t border-slate-200">
                        <div className="flex items-center justify-between">
                          <span className="text-sm font-semibold text-slate-700">Total</span>
                          <span className="text-lg font-bold text-slate-900">{stat.total}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            <div>
              <h3 className="text-xl font-semibold text-slate-900 mb-4">By Period</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                {periodStats.map((stat) => (
                  <StatCard key={stat.period.id} title={stat.period.name} stats={stat} />
                ))}
              </div>
            </div>

            <div>
              <h3 className="text-xl font-semibold text-slate-900 mb-4">By DLI</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {dliStats.map((stat) => (
                  <StatCard
                    key={stat.dli.id}
                    title={`${stat.dli.code} - ${stat.dli.period?.name || ''}`}
                    stats={stat}
                  />
                ))}
              </div>
            </div>
          </div>
        )}
      </main>

      {showUserManagement && (
        <UserManagement onClose={() => setShowUserManagement(false)} />
      )}
    </div>
  );
}
