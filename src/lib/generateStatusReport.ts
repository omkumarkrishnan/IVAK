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
  BorderStyle,
  ShadingType,
  TableLayoutType,
} from 'docx';
import { saveAs } from 'file-saver';
import { supabase } from './supabase';

// ── colour palette ────────────────────────────────────────────────────────────
const C = {
  headerBg:      '1e293b',   // dark slate   – table headers
  headerText:    'FFFFFF',
  fullySubmitted:'fef3c7',   // amber-100    – all tasks submitted, IVA report pending
  partial:       'ffedd5',   // orange-100   – some tasks submitted, some outstanding
  notStarted:    'f1f5f9',   // slate-100    – no submissions yet
  verified:      'd1fae5',   // green-100    – fully verified
  pendingBg:     'fff7ed',   // orange-50    – pending-decisions rows
  pendingBorder: 'fb923c',   // orange-400
  mutedText:     '475569',
  dimText:       '64748b',
};

// ── helper builders ──────────────────────────────────────────────────────────
function mkCell(
  text: string,
  opts: { bold?: boolean; bg?: string; color?: string; width?: number; italic?: boolean } = {}
): TableCell {
  return new TableCell({
    shading: opts.bg ? { type: ShadingType.SOLID, color: opts.bg, fill: opts.bg } : undefined,
    width: opts.width ? { size: opts.width, type: WidthType.PERCENTAGE } : undefined,
    children: [
      new Paragraph({
        children: [
          new TextRun({
            text,
            bold: opts.bold ?? false,
            italics: opts.italic ?? false,
            color: opts.color ?? '000000',
            size: 20,
          }),
        ],
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

function h2(text: string): Paragraph {
  return new Paragraph({
    heading: HeadingLevel.HEADING_2,
    spacing: { before: 320, after: 140 },
    children: [new TextRun({ text, bold: true, size: 24, color: C.headerBg })],
  });
}

function note(text: string): Paragraph {
  return new Paragraph({
    spacing: { after: 180 },
    children: [new TextRun({ text, size: 21, color: C.mutedText, italics: true })],
  });
}

function legend(color: string, label: string): Paragraph {
  // Approximate legend as coloured text bullet
  return new Paragraph({
    spacing: { after: 60 },
    children: [
      new TextRun({ text: '  \u25A0  ', bold: true, color: color }),
      new TextRun({ text: label, size: 20, color: C.mutedText }),
    ],
  });
}

// ── DLR-level categorisation ─────────────────────────────────────────────────
type DlrCategory = 'verified' | 'fully_submitted' | 'partial' | 'not_started';

interface DlrRow {
  dlr: string;
  description: string;
  department: string;
  category: DlrCategory;
  submittedCount: number;
  totalCount: number;
  pendingTasks: string[];   // task names that are non-verified
}

// Pending decisions from April 2026 minutes (hard-coded from migration notes)
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
  const [
    { data: depts },
    { data: dlis },
    { data: verifications },
  ] = await Promise.all([
    supabase.from('departments').select('*').order('dli_number'),
    supabase.from('dlis').select('*').order('code'),
    supabase.from('verifications').select('*'),
  ]);

  const deptsArray = depts ?? [];
  const dlisArray  = dlis  ?? [];
  const verifArray = verifications ?? [];

  const today = new Date().toLocaleDateString('en-GB', {
    day: 'numeric', month: 'long', year: 'numeric',
  });

  // ── overall counts ─────────────────────────────────────────────────────────
  const totalVerifs    = verifArray.length;
  const totalVerified  = verifArray.filter(v => v.state === 'verified').length;
  const totalSubmitted = verifArray.filter(v => v.state === 'submitted').length;
  const totalNotVerif  = verifArray.filter(v => v.state === 'non-verified').length;
  const pct = (n: number) =>
    totalVerifs ? `${Math.round((n / totalVerifs) * 100)}%` : '0%';

  // ── department summaries ───────────────────────────────────────────────────
  const deptSummaries = deptsArray.map(dept => {
    const deptDlis  = dlisArray.filter(d => d.department_id === dept.id);
    const deptVerif = verifArray.filter(v => deptDlis.some(d => d.id === v.dli_id));
    return {
      name:        dept.name,
      dlrCount:    deptDlis.length,
      verified:    deptVerif.filter(v => v.state === 'verified').length,
      submitted:   deptVerif.filter(v => v.state === 'submitted').length,
      notVerified: deptVerif.filter(v => v.state === 'non-verified').length,
    };
  });

  // ── DLR-level rows ─────────────────────────────────────────────────────────
  const dlrRows: DlrRow[] = dlisArray.map(dli => {
    const dept       = deptsArray.find(d => d.id === dli.department_id);
    const tasks      = verifArray.filter(v => v.dli_id === dli.id);
    const submitted  = tasks.filter(v => v.state === 'submitted' || v.state === 'verified').length;
    const verified   = tasks.filter(v => v.state === 'verified').length;
    const notVerif   = tasks.filter(v => v.state === 'non-verified');
    const total      = tasks.length;

    let category: DlrCategory;
    if (total === 0 || notVerif.length === total) {
      category = 'not_started';
    } else if (verified === total) {
      category = 'verified';
    } else if (notVerif.length === 0) {
      category = 'fully_submitted';
    } else {
      category = 'partial';
    }

    return {
      dlr:           dli.code,
      description:   dli.description,
      department:    dept?.name ?? '',
      category,
      submittedCount: submitted,
      totalCount:    total,
      pendingTasks:  notVerif.map(v => v.description),
    };
  });

  const fullySubmittedDlrs = dlrRows.filter(r => r.category === 'fully_submitted');
  const partialDlrs        = dlrRows.filter(r => r.category === 'partial');
  const notStartedDlrs     = dlrRows.filter(r => r.category === 'not_started');
  const verifiedDlrs       = dlrRows.filter(r => r.category === 'verified');

  // ── document construction ──────────────────────────────────────────────────

  const titleBlock = [
    new Paragraph({
      alignment: AlignmentType.CENTER,
      spacing: { after: 120 },
      children: [new TextRun({ text: 'Sikkim INSPIRES IVA', bold: true, size: 52, color: C.headerBg })],
    }),
    new Paragraph({
      alignment: AlignmentType.CENTER,
      spacing: { after: 120 },
      children: [new TextRun({ text: 'Programme Verification Status Report', size: 36, color: C.mutedText })],
    }),
    new Paragraph({
      alignment: AlignmentType.CENTER,
      spacing: { after: 600 },
      children: [new TextRun({ text: `As of: ${today}`, size: 24, color: C.dimText, italics: true })],
    }),
  ];

  // Section 1 – Overall summary
  const overallTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('Status', 52), mkHeader('Tasks', 24), mkHeader('% of Total', 24)] }),
      new TableRow({ children: [mkCell('Verified',                          { bg: C.verified }),       mkCell(String(totalVerified),  { bold: true, bg: C.verified }),  mkCell(pct(totalVerified),  { bg: C.verified  })] }),
      new TableRow({ children: [mkCell('Submitted (pending IVA sign-off)', { bg: C.fullySubmitted }), mkCell(String(totalSubmitted), { bold: true, bg: C.fullySubmitted }), mkCell(pct(totalSubmitted), { bg: C.fullySubmitted })] }),
      new TableRow({ children: [mkCell('Not Yet Verified',                  { bg: C.notStarted }),    mkCell(String(totalNotVerif),  { bold: true, bg: C.notStarted  }), mkCell(pct(totalNotVerif),  { bg: C.notStarted })] }),
      new TableRow({ children: [mkCell('Total', { bold: true }),            mkCell(String(totalVerifs), { bold: true }), mkCell('100%')] }),
    ],
  });

  // Section 2 – Dept table
  const deptTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('Department', 40), mkHeader('DLRs', 12), mkHeader('Verified', 16), mkHeader('Submitted', 16), mkHeader('Not Verified', 16)] }),
      ...deptSummaries.map(s => new TableRow({ children: [
        mkCell(s.name),
        mkCell(String(s.dlrCount), { bold: true }),
        mkCell(String(s.verified),    { bg: s.verified    > 0 ? C.verified        : undefined }),
        mkCell(String(s.submitted),   { bg: s.submitted   > 0 ? C.fullySubmitted  : undefined }),
        mkCell(String(s.notVerified), { bg: s.notVerified > 0 ? 'fef2f2'          : undefined }),
      ]})),
    ],
  });

  // Section 3 – Fully submitted DLRs (pending IVA report)
  const fullySubmittedTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({ tableHeader: true, children: [mkHeader('DLR', 12), mkHeader('Description', 58), mkHeader('Department', 30)] }),
      ...fullySubmittedDlrs.map(r => new TableRow({ children: [
        mkCell(r.dlr, { bold: true, bg: C.fullySubmitted }),
        mkCell(r.description, { bg: C.fullySubmitted }),
        mkCell(r.department,  { bg: C.fullySubmitted }),
      ]})),
    ],
  });

  // Section 4 – Partial DLRs
  const buildPartialTable = () => {
    const rows: TableRow[] = [
      new TableRow({ tableHeader: true, children: [mkHeader('DLR', 11), mkHeader('Description', 38), mkHeader('Department', 27), mkHeader('Outstanding Tasks', 24)] }),
    ];
    for (const r of partialDlrs) {
      const pendingText = r.pendingTasks.join('\n• ');
      rows.push(new TableRow({ children: [
        mkCell(r.dlr, { bold: true, bg: C.partial }),
        mkCell(r.description, { bg: C.partial }),
        mkCell(r.department,  { bg: C.partial }),
        new TableCell({
          shading: { type: ShadingType.SOLID, color: C.partial, fill: C.partial },
          children: [
            new Paragraph({
              spacing: { before: 60, after: 60 },
              children: [
                new TextRun({ text: `${r.pendingTasks.length} of ${r.totalCount} tasks outstanding:`, bold: true, size: 20, color: 'c2410c' }),
              ],
            }),
            new Paragraph({
              spacing: { before: 40, after: 60 },
              children: [new TextRun({ text: `• ${pendingText}`, size: 20, color: '000000' })],
            }),
          ],
        }),
      ]}));
    }
    return new Table({ layout: TableLayoutType.FIXED, width: { size: 100, type: WidthType.PERCENTAGE }, rows });
  };

  // Section 5 – Pending decisions
  const buildPendingDecisionsTable = () => {
    const rows: TableRow[] = [
      new TableRow({ tableHeader: true, children: [mkHeader('DLRs Affected', 18), mkHeader('Issue Requiring Decision', 35), mkHeader('Background (from April 2026 MoM)', 47)] }),
    ];
    for (const pd of PENDING_DECISIONS) {
      rows.push(new TableRow({ children: [
        mkCell(pd.dlrs.join(', '), { bold: true, bg: C.pendingBg }),
        mkCell(pd.issue,           { bold: true, bg: C.pendingBg, color: 'b45309' }),
        mkCell(pd.background,      { bg: C.pendingBg, italic: true }),
      ]}));
    }
    return new Table({ layout: TableLayoutType.FIXED, width: { size: 100, type: WidthType.PERCENTAGE }, rows });
  };

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

  // ── Legend ─────────────────────────────────────────────────────────────────
  const legendBlock = [
    new Paragraph({ spacing: { before: 400, after: 120 }, children: [new TextRun({ text: 'Colour Legend', bold: true, size: 22, color: C.headerBg })] }),
    legend('d4a017', 'Amber — All verification tasks submitted; IVA Verification Report pending'),
    legend('ea580c', 'Orange — Partially submitted; one or more verification tasks still outstanding'),
    legend('94a3b8', 'Grey — No submissions yet'),
    legend('16a34a', 'Green — Fully verified'),
  ];

  // ── Footer ──────────────────────────────────────────────────────────────────
  const footerPara = new Paragraph({
    alignment: AlignmentType.CENTER,
    spacing: { before: 800 },
    children: [new TextRun({ text: 'Generated by Sikkim INSPIRES IVA System — CESI, IIM Kozhikode', size: 18, color: '94a3b8', italics: true })],
  });

  const doc = new Document({
    sections: [{
      children: [
        ...titleBlock,

        h1('1.  Overall Summary'),
        overallTable,
        ...legendBlock,

        h1('2.  Status by Department'),
        deptTable,

        h1('3.  DLRs — All Verification Tasks Submitted (IVA Report Pending)'),
        note(`${fullySubmittedDlrs.length} DLRs have all verification tasks marked Submitted and are awaiting the formal IVA Verification Report.`),
        fullySubmittedTable,

        h1('4.  DLRs — Partially Submitted (Reviews Incomplete)'),
        note(`${partialDlrs.length} DLR${partialDlrs.length !== 1 ? 's have' : ' has'} at least one verification task submitted but one or more tasks remain outstanding. These require follow-up before the IVA report can be issued.`),
        buildPartialTable(),

        h1('5.  Pending Decisions (from April 2026 Minutes of Meeting)'),
        note('The following DLRs have open protocol questions that were flagged in the April 2026 MoM and require a decision before verification work can proceed.'),
        buildPendingDecisionsTable(),

        h1('6.  DLRs Not Yet Started'),
        note(`${notStartedDlrs.length} DLRs have no submissions and remain fully unverified (broadly Year 3–5 targets).`),
        notStartedTable,

        footerPara,
      ],
    }],
  });

  const blob = await Packer.toBlob(doc);
  const filename = `Sikkim_INSPIRES_IVA_Status_Report_${new Date().toISOString().slice(0, 10)}.docx`;
  saveAs(blob, filename);
}
