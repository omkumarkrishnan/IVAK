import { useEffect, useState } from 'react';
import { useAuth } from '../contexts/AuthContext';
import {
  LogOut, User, Home, BarChart3, CheckCircle, Clock, FileText,
  Users, Download, AlertTriangle,
} from 'lucide-react';
import { supabase } from '../lib/supabase';
import { Department, Period, DLI, Verification } from '../types/database';
import { UserManagement } from '../components/UserManagement';
import { generateStatusReport } from '../lib/generateStatusReport';

interface DashboardProps {
  onNavigateHome: () => void;
}

interface DLRStats {
  total: number;
  complete: number;    // all tasks submitted/verified
  incomplete: number;  // some submitted, some non-verified
  notStarted: number;  // no submissions yet
}

interface VerificationTaskStats {
  total: number;
  submitted: number;
  nonVerified: number;
}

interface IncompleteDLR {
  code: string;
  pendingTasks: string[];
  totalTasks: number;
  doneTasks: number;
}

interface DepartmentStats {
  department: Department;
  dlrStats: DLRStats;
}

interface PeriodStats {
  period: Period;
  taskStats: VerificationTaskStats;
}

interface DLIStats {
  dli: DLI;
  taskStats: VerificationTaskStats;
  isIncomplete: boolean;
  pendingTasks: string[];
}

export function DashboardPage({ onNavigateHome }: DashboardProps) {
  const { profile, signOut } = useAuth();
  const [loading, setLoading] = useState(true);
  const [generatingReport, setGeneratingReport] = useState(false);
  const [showUserManagement, setShowUserManagement] = useState(false);

  const [overallDLRStats, setOverallDLRStats] = useState<DLRStats>({ total: 0, complete: 0, incomplete: 0, notStarted: 0 });
  const [incompleteDLRs, setIncompleteDLRs] = useState<IncompleteDLR[]>([]);
  const [departmentStats, setDepartmentStats] = useState<DepartmentStats[]>([]);
  const [periodStats, setPeriodStats] = useState<PeriodStats[]>([]);
  const [dliStats, setDLIStats] = useState<DLIStats[]>([]);

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
                <button onClick={onNavigateHome} className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors">
                  <Home className="w-4 h-4" />
                  <span className="text-sm font-medium">Home</span>
                </button>
                <button onClick={signOut} className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors">
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
              <p className="text-slate-600 mb-6">You need administrator or consultant privileges to access the dashboard.</p>
              <button onClick={onNavigateHome} className="inline-flex items-center gap-2 px-6 py-3 bg-slate-900 text-white rounded-lg hover:bg-slate-800 transition-colors">
                <Home className="w-4 h-4" />
                Return to Home
              </button>
            </div>
          </div>
        </main>
      </div>
    );
  }

  useEffect(() => { fetchStats(); }, []);

  const fetchStats = async () => {
    setLoading(true);
    try {
      const { data: departments } = await supabase.from('departments').select('*').order('dli_number');
      const { data: periods }     = await supabase.from('periods').select('*').order('name');
      const { data: dlis }        = await supabase.from('dlis').select('*, period:periods(*)').order('code');
      const { data: verifications } = await supabase.from('verifications').select('*');

      const verifArray = verifications || [];
      const dlisArray  = dlis          || [];
      const deptsArray = departments   || [];
      const periodsArray = periods     || [];

      // ── DLR-level classification ──────────────────────────────────────────
      // A DLR is:
      //   complete    – all tasks submitted/verified
      //   incomplete  – some submitted AND some non-verified  ← needs attention
      //   notStarted  – zero tasks submitted
      const classifyDLR = (dliId: string) => {
        const tasks   = verifArray.filter(v => v.dli_id === dliId);
        const done    = tasks.filter(v => v.state === 'submitted' || v.state === 'verified');
        const pending = tasks.filter(v => v.state === 'non-verified');
        if (done.length === 0)    return 'notStarted' as const;
        if (pending.length === 0) return 'complete'   as const;
        return 'incomplete' as const;
      };

      // Overall DLR counts
      const dlrCounts: DLRStats = { total: dlisArray.length, complete: 0, incomplete: 0, notStarted: 0 };
      const incompleteList: IncompleteDLR[] = [];

      dlisArray.forEach(dli => {
        const cat = classifyDLR(dli.id);
        dlrCounts[cat]++;
        if (cat === 'incomplete') {
          const tasks   = verifArray.filter(v => v.dli_id === dli.id);
          const done    = tasks.filter(v => v.state === 'submitted' || v.state === 'verified');
          const pending = tasks.filter(v => v.state === 'non-verified');
          incompleteList.push({ code: dli.code, pendingTasks: pending.map(v => v.description), totalTasks: tasks.length, doneTasks: done.length });
        }
      });
      setOverallDLRStats(dlrCounts);
      setIncompleteDLRs(incompleteList);

      // Department stats (DLR-level)
      const deptStats: DepartmentStats[] = deptsArray.map(dept => {
        const deptDlis = dlisArray.filter(d => d.department_id === dept.id);
        const stats: DLRStats = { total: deptDlis.length, complete: 0, incomplete: 0, notStarted: 0 };
        deptDlis.forEach(dli => { stats[classifyDLR(dli.id)]++; });
        return { department: dept, dlrStats: stats };
      });
      setDepartmentStats(deptStats);

      // Period stats (task-level, for period cards)
      const periodStatsMap = new Map<string, PeriodStats>();
      periodsArray.forEach(period => {
        const periodDlis  = dlisArray.filter(d => d.period_id === period.id);
        const periodTasks = verifArray.filter(v => periodDlis.some(d => d.id === v.dli_id));
        periodStatsMap.set(period.id, {
          period,
          taskStats: {
            total:      periodTasks.length,
            submitted:  periodTasks.filter(v => v.state === 'submitted' || v.state === 'verified').length,
            nonVerified: periodTasks.filter(v => v.state === 'non-verified').length,
          },
        });
      });
      setPeriodStats(Array.from(periodStatsMap.values()));

      // DLI stats (task-level + incomplete flag)
      const dliStatsArray: DLIStats[] = dlisArray.map(dli => {
        const tasks   = verifArray.filter(v => v.dli_id === dli.id);
        const done    = tasks.filter(v => v.state === 'submitted' || v.state === 'verified');
        const pending = tasks.filter(v => v.state === 'non-verified');
        return {
          dli,
          taskStats: { total: tasks.length, submitted: done.length, nonVerified: pending.length },
          isIncomplete: done.length > 0 && pending.length > 0,
          pendingTasks: pending.map(v => v.description),
        };
      });
      setDLIStats(dliStatsArray);
    } catch (error) {
      console.error('Error fetching stats:', error);
    } finally {
      setLoading(false);
    }
  };

  const pct = (value: number, total: number) =>
    total === 0 ? '0%' : `${Math.round((value / total) * 100)}%`;

  const handleDownloadReport = async () => {
    setGeneratingReport(true);
    try {
      await generateStatusReport();
    } catch (err) {
      console.error('Failed to generate report:', err);
    } finally {
      setGeneratingReport(false);
    }
  };

  const formatDepartmentName = (name: string) => {
    const match = name.match(/^(.+?)\s*\((DLI \d+)\)$/);
    if (match) return <div><div>{match[1]}</div><div className="text-sm text-slate-500">({match[2]})</div></div>;
    return name;
  };

  // ── Sub-components ──────────────────────────────────────────────────────────

  const DLICard = ({ stat }: { stat: DLIStats }) => (
    <div className={`bg-white rounded-lg border p-5 ${stat.isIncomplete ? 'border-orange-300 ring-1 ring-orange-200' : 'border-slate-200'}`}>
      <div className="flex items-start justify-between mb-3">
        <div>
          <h3 className="text-sm font-bold text-slate-900">{stat.dli.code}</h3>
          <p className="text-xs text-slate-500 mt-0.5">{stat.dli.period?.name || ''}</p>
        </div>
        {stat.isIncomplete && (
          <span className="inline-flex items-center gap-1 text-xs font-semibold px-2 py-0.5 rounded-full bg-orange-100 text-orange-700 border border-orange-200">
            <AlertTriangle className="w-3 h-3" />
            Incomplete
          </span>
        )}
      </div>

      <div className="space-y-2">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-1.5">
            <CheckCircle className="w-3.5 h-3.5 text-green-600" />
            <span className="text-xs text-slate-600">Submitted</span>
          </div>
          <span className="text-sm font-bold text-green-700">
            {stat.taskStats.submitted}
            <span className="text-xs font-normal text-slate-400 ml-1">({pct(stat.taskStats.submitted, stat.taskStats.total)})</span>
          </span>
        </div>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-1.5">
            <FileText className="w-3.5 h-3.5 text-slate-400" />
            <span className="text-xs text-slate-600">Not verified</span>
          </div>
          <span className={`text-sm font-bold ${stat.isIncomplete ? 'text-orange-600' : 'text-slate-600'}`}>
            {stat.taskStats.nonVerified}
            <span className="text-xs font-normal text-slate-400 ml-1">({pct(stat.taskStats.nonVerified, stat.taskStats.total)})</span>
          </span>
        </div>
        <div className="pt-2 border-t border-slate-100 flex items-center justify-between">
          <span className="text-xs font-semibold text-slate-500">Total tasks</span>
          <span className="text-sm font-bold text-slate-800">{stat.taskStats.total}</span>
        </div>
      </div>

      {stat.isIncomplete && stat.pendingTasks.length > 0 && (
        <div className="mt-3 pt-3 border-t border-orange-200">
          <p className="text-xs font-semibold text-orange-700 mb-1.5">Outstanding tasks:</p>
          <ul className="space-y-1">
            {stat.pendingTasks.map((t, i) => (
              <li key={i} className="text-xs text-orange-800 flex items-start gap-1">
                <span className="text-orange-400 mt-0.5 shrink-0">•</span>
                <span>{t}</span>
              </li>
            ))}
          </ul>
        </div>
      )}
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
                  <span className="text-sm font-medium text-slate-700 capitalize">{profile.role}</span>
                </div>
              )}
              {profile?.role === 'admin' && (
                <button onClick={() => setShowUserManagement(true)} className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors">
                  <Users className="w-4 h-4" />
                  <span className="text-sm font-medium">Manage Users</span>
                </button>
              )}
              <button
                onClick={handleDownloadReport}
                disabled={generatingReport || loading}
                className="flex items-center gap-2 px-4 py-2 bg-slate-900 text-white hover:bg-slate-800 rounded-lg transition-colors disabled:opacity-60 disabled:cursor-not-allowed"
              >
                {generatingReport
                  ? <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white" />
                  : <Download className="w-4 h-4" />}
                <span className="text-sm font-medium">{generatingReport ? 'Generating...' : 'Status Report'}</span>
              </button>
              <button onClick={onNavigateHome} className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors">
                <Home className="w-4 h-4" />
                <span className="text-sm font-medium">Home</span>
              </button>
              <button onClick={signOut} className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:text-slate-900 hover:bg-slate-100 rounded-lg transition-colors">
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
          <p className="text-slate-600">DLR-level verification status across the programme</p>
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-slate-900"></div>
          </div>
        ) : (
          <div className="space-y-8">

            {/* Overall DLR-level summary */}
            <div>
              <h3 className="text-xl font-semibold text-slate-900 mb-4">Overall DLR Status</h3>
              <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
                <div className="bg-white rounded-lg border border-slate-200 p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm text-slate-500 mb-1">Total DLRs</p>
                      <p className="text-3xl font-bold text-slate-900">{overallDLRStats.total}</p>
                    </div>
                    <FileText className="w-10 h-10 text-slate-300" />
                  </div>
                </div>
                <div className="bg-green-50 rounded-lg border border-green-200 p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm text-green-700 mb-1">Complete</p>
                      <p className="text-3xl font-bold text-green-800">{overallDLRStats.complete}</p>
                      <p className="text-xs text-green-600 mt-1">{pct(overallDLRStats.complete, overallDLRStats.total)} of total</p>
                    </div>
                    <CheckCircle className="w-10 h-10 text-green-500" />
                  </div>
                </div>
                <div className={`rounded-lg border p-6 ${incompleteDLRs.length > 0 ? 'bg-orange-50 border-orange-300' : 'bg-white border-slate-200'}`}>
                  <div className="flex items-center justify-between">
                    <div>
                      <p className={`text-sm mb-1 ${incompleteDLRs.length > 0 ? 'text-orange-700' : 'text-slate-500'}`}>Incomplete</p>
                      <p className={`text-3xl font-bold ${incompleteDLRs.length > 0 ? 'text-orange-800' : 'text-slate-700'}`}>{overallDLRStats.incomplete}</p>
                      <p className={`text-xs mt-1 ${incompleteDLRs.length > 0 ? 'text-orange-600' : 'text-slate-400'}`}>tasks outstanding</p>
                    </div>
                    <AlertTriangle className={`w-10 h-10 ${incompleteDLRs.length > 0 ? 'text-orange-400' : 'text-slate-300'}`} />
                  </div>
                </div>
                <div className="bg-white rounded-lg border border-slate-200 p-6">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm text-slate-500 mb-1">Not Started</p>
                      <p className="text-3xl font-bold text-slate-600">{overallDLRStats.notStarted}</p>
                      <p className="text-xs text-slate-400 mt-1">{pct(overallDLRStats.notStarted, overallDLRStats.total)} of total</p>
                    </div>
                    <Clock className="w-10 h-10 text-slate-300" />
                  </div>
                </div>
              </div>
            </div>

            {/* Needs Attention — Incomplete DLRs */}
            {incompleteDLRs.length > 0 && (
              <div>
                <div className="flex items-center gap-2 mb-4">
                  <AlertTriangle className="w-5 h-5 text-orange-500" />
                  <h3 className="text-xl font-semibold text-orange-800">Needs Attention — Incomplete DLRs</h3>
                  <span className="ml-1 text-xs font-bold px-2 py-0.5 rounded-full bg-orange-100 text-orange-700 border border-orange-200">
                    {incompleteDLRs.length}
                  </span>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {incompleteDLRs.map(dlr => (
                    <div key={dlr.code} className="bg-orange-50 rounded-lg border border-orange-300 p-5">
                      <div className="flex items-start justify-between mb-3">
                        <div>
                          <span className="text-base font-bold text-orange-900">{dlr.code}</span>
                          <span className="ml-2 text-xs text-orange-600">{dlr.doneTasks}/{dlr.totalTasks} tasks submitted</span>
                        </div>
                        <span className="inline-flex items-center gap-1 text-xs font-semibold px-2 py-0.5 rounded-full bg-orange-200 text-orange-800">
                          <AlertTriangle className="w-3 h-3" />
                          {dlr.pendingTasks.length} outstanding
                        </span>
                      </div>
                      <p className="text-xs font-semibold text-orange-700 mb-2">Verification tasks not yet submitted:</p>
                      <ul className="space-y-1.5">
                        {dlr.pendingTasks.map((task, i) => (
                          <li key={i} className="flex items-start gap-2 text-sm text-orange-800 bg-white/60 rounded px-2.5 py-1.5 border border-orange-200">
                            <span className="text-orange-400 mt-0.5 shrink-0">•</span>
                            {task}
                          </li>
                        ))}
                      </ul>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* By Department */}
            <div>
              <h3 className="text-xl font-semibold text-slate-900 mb-4">By Department</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {departmentStats.map((stat) => {
                  const hasIncomplete = stat.dlrStats.incomplete > 0;
                  return (
                    <div key={stat.department.id} className={`bg-white rounded-lg border p-5 ${hasIncomplete ? 'border-orange-200 ring-1 ring-orange-100' : 'border-slate-200'}`}>
                      <h3 className="text-sm font-bold text-slate-900 mb-3">{formatDepartmentName(stat.department.name)}</h3>
                      <div className="space-y-2">
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-1.5">
                            <CheckCircle className="w-3.5 h-3.5 text-green-600" />
                            <span className="text-xs text-slate-600">Complete</span>
                          </div>
                          <span className="text-sm font-bold text-green-700">
                            {stat.dlrStats.complete}
                            <span className="text-xs font-normal text-slate-400 ml-1">/ {stat.dlrStats.total} DLRs</span>
                          </span>
                        </div>
                        {hasIncomplete && (
                          <div className="flex items-center justify-between">
                            <div className="flex items-center gap-1.5">
                              <AlertTriangle className="w-3.5 h-3.5 text-orange-500" />
                              <span className="text-xs text-orange-700 font-medium">Incomplete</span>
                            </div>
                            <span className="text-sm font-bold text-orange-700">
                              {stat.dlrStats.incomplete}
                              <span className="text-xs font-normal text-slate-400 ml-1">/ {stat.dlrStats.total} DLRs</span>
                            </span>
                          </div>
                        )}
                        <div className="flex items-center justify-between">
                          <div className="flex items-center gap-1.5">
                            <FileText className="w-3.5 h-3.5 text-slate-400" />
                            <span className="text-xs text-slate-600">Not started</span>
                          </div>
                          <span className="text-sm font-bold text-slate-600">
                            {stat.dlrStats.notStarted}
                            <span className="text-xs font-normal text-slate-400 ml-1">/ {stat.dlrStats.total} DLRs</span>
                          </span>
                        </div>
                        <div className="pt-2 border-t border-slate-100 flex items-center justify-between">
                          <span className="text-xs font-semibold text-slate-500">Total DLRs</span>
                          <span className="text-sm font-bold text-slate-800">{stat.dlrStats.total}</span>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>

            {/* By Period */}
            <div>
              <h3 className="text-xl font-semibold text-slate-900 mb-4">By Period</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                {periodStats.map((stat) => (
                  <div key={stat.period.id} className="bg-white rounded-lg border border-slate-200 p-5">
                    <h3 className="text-sm font-bold text-slate-900 mb-3">{stat.period.name}</h3>
                    <div className="space-y-2">
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-1.5">
                          <CheckCircle className="w-3.5 h-3.5 text-green-600" />
                          <span className="text-xs text-slate-600">Submitted</span>
                        </div>
                        <span className="text-sm font-bold text-green-700">
                          {stat.taskStats.submitted}
                          <span className="text-xs font-normal text-slate-400 ml-1">({pct(stat.taskStats.submitted, stat.taskStats.total)})</span>
                        </span>
                      </div>
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-1.5">
                          <FileText className="w-3.5 h-3.5 text-slate-400" />
                          <span className="text-xs text-slate-600">Not verified</span>
                        </div>
                        <span className="text-sm font-bold text-slate-600">
                          {stat.taskStats.nonVerified}
                          <span className="text-xs font-normal text-slate-400 ml-1">({pct(stat.taskStats.nonVerified, stat.taskStats.total)})</span>
                        </span>
                      </div>
                      <div className="pt-2 border-t border-slate-100 flex items-center justify-between">
                        <span className="text-xs font-semibold text-slate-500">Total tasks</span>
                        <span className="text-sm font-bold text-slate-800">{stat.taskStats.total}</span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* By DLR */}
            <div>
              <h3 className="text-xl font-semibold text-slate-900 mb-4">By DLR</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {dliStats.map((stat) => (
                  <DLICard key={stat.dli.id} stat={stat} />
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
