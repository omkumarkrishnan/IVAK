import {
  Document,
  Packer,
  Paragraph,
  Table,
  TableRow,
  TableCell,
  TextRun,
  HeadingLevel,
  AlignmentType,
  WidthType,
  ShadingType,
  TableLayoutType,
} from 'docx';
import { saveAs } from 'file-saver';
import { supabase } from './supabase';

// ── colour palette ────────────────────────────────────────────────────────────
const C = {
  headerBg:   '1e293b',
  headerText: 'FFFFFF',
  complete:   'd1fae5',   // green-100  – all tasks done (submitted = verified)
  partial:    'ffedd5',   // orange-100 – some tasks still outstanding
  notStarted: 'f1f5f9',   // slate-100  – no submissions yet
  pendingBg:  'fff7ed',   // orange-50  – pending-decision rows
  mutedText:  '475569',
  dimText:    '64748b',
};

// ── helpers ───────────────────────────────────────────────────────────────────
function mkCell(
  text: string,
  opts: { bold?: boolean; bg?: string; color?: string; width?: number; italic?: boolean } = {}
): TableCell {
  return new TableCell({
    shading: opts.bg ? { type: ShadingType.SOLID, color: opts.bg, fill: opts.bg } : undefined,
    width: opts.width ? { size: opts.width, type: WidthType.PERCENTAGE } : undefined,
    children: [
      new Paragraph({
        children: [new TextRun({ text, bold: opts.bold ?? false, italics: opts.italic ?? false, color: opts.color ?? '000000', size: 20 })],
        spacing: { before: 60, after: 60 },
      }),
    ],
  });
}

function mkHeader(text: string, width?: number): TableCell {
  return mkCell(text, { bold: true, bg: C.headerBg, color: C.headerText, width });
}

function h1(text: string): Paragraph {
  return new Paragraph({
    heading: HeadingLevel.HEADING_1,
    spacing: { before: 480, after: 200 },
    children: [new TextRun({ text, bold: true, size: 28, color: C.headerBg })],
  });
}

function note(text: string): Paragraph {
  return new Paragraph({
    spacing: { after: 180 },
    children: [new TextRun({ text, size: 21, color: C.mutedText, italics: true })],
  });
}

function legend(hex: string, label: string): Paragraph {
  return new Paragraph({
    spacing: { after: 60 },
    children: [
      new TextRun({ text: '  \u25A0  ', bold: true, color: hex }),
      new TextRun({ text: label, size: 20, color: C.mutedText }),
    ],
  });
}

// ── DLR categorisation ────────────────────────────────────────────────────────
// "submitted" is treated as equivalent to "verified" for counting purposes.
// A DLR is:
//   complete    – all its tasks are submitted or verified
//   partial     – at least one task submitted but at least one still non-verified
//   not_started – no tasks have been submitted or verified
type DlrCategory = 'complete' | 'partial' | 'not_started';

interface DlrRow {
  dlr: string;
  description: string;
  department: string;
  category: DlrCategory;
  doneCount: number;
  totalCount: number;
  outstandingTasks: string[];
}

// Pending decisions from April 2026 minutes
const PENDING_DECISIONS: { dlrs: string[]; issue: string; background: string }[] = [
  {
    dlrs: ['DLR 5.2.1', 'DLR 5.3.1', 'DLR 5.4.1', 'DLR 5.5.1'],
    issue: 'Definition of "financing disbursed" to be confirmed',
    background:
      'Per April 2026 MoM: The level at which "financing disbursed" is measured (department-to-district vs district-to-activity level) needs to be resolved in a dedicated stakeholder discussion before verification of DLR 5.2.1 through 5.5.1 can proceed.',
  },
  {
    dlrs: ['DLR 6.3.1'],
    issue: 'Verification protocol pending High Economic Zones (HEZ) discussions',
    background:
      'Per April 2026 MoM: The protocol for DLR 6.3.1 is subject to review in the context of ongoing HEZ discussions across districts. The final verification protocol will be confirmed once the DLR form is finalised.',
  },
];

// ── main export ───────────────────────────────────────────────────────────────
export async function generateStatusReport(): Promise<void> {
  const [{ data: depts }, { data: dlis }, { data: verifications }] = await Promise.all([
    supabase.from('departments').select('*').order('dli_number'),
    supabase.from('dlis').select('*').order('code'),
    supabase.from('verifications').select('*'),
  ]);

  const deptsArray = depts ?? [];
  const dlisArray  = dlis  ?? [];
  const verifArray = verifications ?? [];

  const today = new Date().toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric' });

  // ── classify each DLR ───────────────────────────────────────────────────────
  const dlrRows: DlrRow[] = dlisArray.map(dli => {
    const dept     = deptsArray.find(d => d.id === dli.department_id);
    const tasks    = verifArray.filter(v => v.dli_id === dli.id);
    const done     = tasks.filter(v => v.state === 'submitted' || v.state === 'verified');
    const pending  = tasks.filter(v => v.state === 'non-verified');

    let category: DlrCategory;
    if (done.length === 0)                             category = 'not_started';
    else if (pending.length === 0)                     category = 'complete';
    else                                               category = 'partial';

    return {
      dlr:              dli.code,
      description:      dli.description,
      department:       dept?.name ?? '',
      category,
      doneCount:        done.length,
      totalCount:       tasks.length,
      outstandingTasks: pending.map(v => v.description),
    };
  });

  const completeDlrs    = dlrRows.filter(r => r.category === 'complete');
  const partialDlrs     = dlrRows.filter(r => r.category === 'partial');
  const notStartedDlrs  = dlrRows.filter(r => r.category === 'not_started');
  const totalDlrs       = dlrRows.length;
  const pct = (n: number) => totalDlrs ? `${Math.round((n / totalDlrs) * 100)}%` : '0%';

  // ── department summary (DLR-level counts) ───────────────────────────────────
  const deptSummaries = deptsArray.map(dept => {
    const deptDlrs = dlrRows.filter(r => r.department === dept.name);
    return {
      name:        dept.name,
      total:       deptDlrs.length,
      complete:    deptDlrs.filter(r => r.category === 'complete').length,
      partial:     deptDlrs.filter(r => r.category === 'partial').length,
      notStarted:  deptDlrs.filter(r => r.category === 'not_started').length,
    };
  });

  // ── build document ─────────────────────────────────────────────────────────

  const titleBlock = [
    new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 120 }, children: [new TextRun({ text: 'Sikkim INSPIRES IVA', bold: true, size: 52, color: C.headerBg })] }),
    new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 120 }, children: [new TextRun({ text: 'Programme Verification Status Report', size: 36, color: C.mutedText })] }),
    new Paragraph({ alignment: AlignmentType.CENTER, spacing: { after: 600 }, children: [new TextRun({ text: `As of: ${today}`, size: 24, color: C.dimText, italics: true })] }),
  ];

  // Section 1 – Overall summary (DLR-level, submitted = complete)
  const overallTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('Status', 52), mkHeader('DLRs', 24), mkHeader('% of Total', 24)] }),
      new TableRow({ children: [mkCell('Complete (all verification tasks done)',          { bg: C.complete    }), mkCell(String(completeDlrs.length),   { bold: true, bg: C.complete    }), mkCell(pct(completeDlrs.length),   { bg: C.complete    })] }),
      new TableRow({ children: [mkCell('Incomplete (some verification tasks outstanding)', { bg: C.partial     }), mkCell(String(partialDlrs.length),    { bold: true, bg: C.partial     }), mkCell(pct(partialDlrs.length),    { bg: C.partial     })] }),
      new TableRow({ children: [mkCell('Not yet started',                                  { bg: C.notStarted  }), mkCell(String(notStartedDlrs.length), { bold: true, bg: C.notStarted  }), mkCell(pct(notStartedDlrs.length), { bg: C.notStarted  })] }),
      new TableRow({ children: [mkCell('Total DLRs', { bold: true }), mkCell(String(totalDlrs), { bold: true }), mkCell('100%')] }),
    ],
  });

  const legendBlock = [
    new Paragraph({ spacing: { before: 300, after: 100 }, children: [new TextRun({ text: 'Legend', bold: true, size: 22, color: C.headerBg })] }),
    legend('16a34a', 'Green — Complete: all verification tasks have been submitted'),
    legend('ea580c', 'Orange — Incomplete: one or more verification tasks still outstanding'),
    legend('94a3b8', 'Grey — Not yet started: no submissions received'),
  ];

  // Section 2 – Department breakdown
  const deptTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('Department', 40), mkHeader('Total DLRs', 15), mkHeader('Complete', 15), mkHeader('Incomplete', 15), mkHeader('Not Started', 15)] }),
      ...deptSummaries.map(s => new TableRow({ children: [
        mkCell(s.name),
        mkCell(String(s.total), { bold: true }),
        mkCell(String(s.complete),   { bg: s.complete   > 0 ? C.complete   : undefined }),
        mkCell(String(s.partial),    { bg: s.partial    > 0 ? C.partial    : undefined }),
        mkCell(String(s.notStarted), { bg: s.notStarted > 0 ? C.notStarted : undefined }),
      ]})),
    ],
  });

  // Section 3 – Complete DLRs
  const completeTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('DLR', 12), mkHeader('Description', 58), mkHeader('Department', 30)] }),
      ...completeDlrs.map(r => new TableRow({ children: [
        mkCell(r.dlr, { bold: true, bg: C.complete }),
        mkCell(r.description, { bg: C.complete }),
        mkCell(r.department,  { bg: C.complete }),
      ]})),
    ],
  });

  // Section 4 – Incomplete DLRs (partial)
  const incompleteTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('DLR', 11), mkHeader('Description', 36), mkHeader('Department', 26), mkHeader('Outstanding Tasks', 27)] }),
      ...partialDlrs.map(r => {
        const tasksText = r.outstandingTasks.map(t => `• ${t}`).join('\n');
        return new TableRow({ children: [
          mkCell(r.dlr, { bold: true, bg: C.partial }),
          mkCell(r.description, { bg: C.partial }),
          mkCell(r.department,  { bg: C.partial }),
          new TableCell({
            shading: { type: ShadingType.SOLID, color: C.partial, fill: C.partial },
            children: [
              new Paragraph({
                spacing: { before: 60, after: 40 },
                children: [new TextRun({ text: `${r.outstandingTasks.length} of ${r.totalCount} tasks outstanding:`, bold: true, size: 20, color: 'c2410c' })],
              }),
              ...r.outstandingTasks.map(t =>
                new Paragraph({
                  spacing: { before: 30, after: 30 },
                  children: [new TextRun({ text: `• ${t}`, size: 20 })],
                })
              ),
            ],
          }),
        ]});
      }),
    ],
  });

  // Section 5 – Pending decisions
  const pendingTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('DLRs Affected', 18), mkHeader('Issue Requiring Decision', 35), mkHeader('Background (April 2026 MoM)', 47)] }),
      ...PENDING_DECISIONS.map(pd => new TableRow({ children: [
        mkCell(pd.dlrs.join(', '), { bold: true, bg: C.pendingBg }),
        mkCell(pd.issue,           { bold: true, bg: C.pendingBg, color: 'b45309' }),
        mkCell(pd.background,      { bg: C.pendingBg, italic: true }),
      ]})),
    ],
  });

  // Section 6 – Not yet started
  const notStartedTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('DLR', 12), mkHeader('Description', 58), mkHeader('Department', 30)] }),
      ...notStartedDlrs.map(r => new TableRow({ children: [
        mkCell(r.dlr, { bold: true, bg: C.notStarted }),
        mkCell(r.description, { bg: C.notStarted }),
        mkCell(r.department,  { bg: C.notStarted }),
      ]})),
    ],
  });

  const doc = new Document({
    sections: [{
      children: [
        ...titleBlock,

        h1('1.  Overall Summary'),
        note('Note: "Complete" means all verification tasks for a DLR have been submitted. Submitted tasks are treated as verified for the purposes of this report.'),
        overallTable,
        ...legendBlock,

        h1('2.  Status by Department'),
        deptTable,

        h1('3.  Complete DLRs — All Verification Tasks Submitted'),
        note(`${completeDlrs.length} DLRs have all verification tasks submitted and are considered complete pending formal IVA sign-off.`),
        completeTable,

        h1('4.  Incomplete DLRs — Outstanding Verification Tasks'),
        note(`${partialDlrs.length} DLR${partialDlrs.length !== 1 ? 's have' : ' has'} at least one task submitted but one or more tasks remain outstanding. These require follow-up before the DLR can be considered complete.`),
        incompleteTable,

        h1('5.  Pending Decisions — April 2026 Minutes of Meeting'),
        note('The following DLRs have open protocol questions flagged in the April 2026 MoM that require a decision before verification work can proceed.'),
        pendingTable,

        h1('6.  DLRs Not Yet Started'),
        note(`${notStartedDlrs.length} DLRs have no verification task submissions (broadly Year 3–5 targets).`),
        notStartedTable,

        new Paragraph({
          alignment: AlignmentType.CENTER,
          spacing: { before: 800 },
          children: [new TextRun({ text: 'Generated by Sikkim INSPIRES IVA System — CESI, IIM Kozhikode', size: 18, color: '94a3b8', italics: true })],
        }),
      ],
    }],
  });

  const blob = await Packer.toBlob(doc);
  saveAs(blob, `Sikkim_INSPIRES_IVA_Status_Report_${new Date().toISOString().slice(0, 10)}.docx`);
}
