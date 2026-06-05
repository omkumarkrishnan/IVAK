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
  PageBreak,
} from 'docx';
import { saveAs } from 'file-saver';
import { supabase } from './supabase';

interface DLRStatus {
  department: string;
  dlr: string;
  description: string;
  state: string;
}

interface DeptSummary {
  department: string;
  totalDlrs: number;
  verified: number;
  submitted: number;
  notVerified: number;
}

const HEADER_COLOR = '1e293b';
const SUBMITTED_COLOR = 'fef3c7';
const NOT_VERIFIED_COLOR = 'f8fafc';
const VERIFIED_COLOR = 'd1fae5';

function cell(text: string, bold = false, bg?: string, color?: string, width?: number): TableCell {
  return new TableCell({
    shading: bg ? { type: ShadingType.SOLID, color: bg, fill: bg } : undefined,
    width: width ? { size: width, type: WidthType.PERCENTAGE } : undefined,
    children: [
      new Paragraph({
        children: [
          new TextRun({
            text,
            bold,
            color: color ?? '000000',
            size: 20,
          }),
        ],
        spacing: { before: 60, after: 60 },
      }),
    ],
  });
}

function headerCell(text: string, width?: number): TableCell {
  return new TableCell({
    shading: { type: ShadingType.SOLID, color: HEADER_COLOR, fill: HEADER_COLOR },
    width: width ? { size: width, type: WidthType.PERCENTAGE } : undefined,
    children: [
      new Paragraph({
        children: [new TextRun({ text, bold: true, color: 'FFFFFF', size: 20 })],
        spacing: { before: 60, after: 60 },
      }),
    ],
  });
}

function stateLabel(state: string): string {
  if (state === 'verified') return 'Verified';
  if (state === 'submitted') return 'Submitted';
  return 'Not Verified';
}

function stateBg(state: string): string {
  if (state === 'verified') return VERIFIED_COLOR.replace('#', '');
  if (state === 'submitted') return SUBMITTED_COLOR.replace('#', '');
  return NOT_VERIFIED_COLOR.replace('#', '');
}

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
  const dlisArray = dlis ?? [];
  const verificationsArray = verifications ?? [];

  const today = new Date().toLocaleDateString('en-GB', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  });

  // Overall counts
  const totalVerifications = verificationsArray.length;
  const totalVerified = verificationsArray.filter(v => v.state === 'verified').length;
  const totalSubmitted = verificationsArray.filter(v => v.state === 'submitted').length;
  const totalNotVerified = verificationsArray.filter(v => v.state === 'non-verified').length;

  // Department summaries
  const deptSummaries: DeptSummary[] = deptsArray.map(dept => {
    const deptDlis = dlisArray.filter(d => d.department_id === dept.id);
    const deptVerifs = verificationsArray.filter(v => deptDlis.some(d => d.id === v.dli_id));
    return {
      department: dept.name,
      totalDlrs: deptDlis.length,
      verified: deptVerifs.filter(v => v.state === 'verified').length,
      submitted: deptVerifs.filter(v => v.state === 'submitted').length,
      notVerified: deptVerifs.filter(v => v.state === 'non-verified').length,
    };
  });

  // DLR-level detail: group by DLR with unique states
  const dlrRows: DLRStatus[] = dlisArray.flatMap(dli => {
    const dept = deptsArray.find(d => d.id === dli.department_id);
    const dliVerifs = verificationsArray.filter(v => v.dli_id === dli.id);
    if (dliVerifs.length === 0) {
      return [{
        department: dept?.name ?? '',
        dlr: dli.code,
        description: dli.description,
        state: 'non-verified',
      }];
    }
    // Use the "worst" state — if any not-verified, show not-verified; else if any submitted, show submitted; else verified
    let state = 'verified';
    if (dliVerifs.some(v => v.state === 'submitted')) state = 'submitted';
    if (dliVerifs.some(v => v.state === 'non-verified')) state = 'non-verified';
    return [{
      department: dept?.name ?? '',
      dlr: dli.code,
      description: dli.description,
      state,
    }];
  });

  // DLRs with at least one submission but NOT fully verified
  const pendingDlrs = dlrRows.filter(r => r.state === 'submitted');
  // DLRs fully not started
  const notStartedDlrs = dlrRows.filter(r => r.state === 'non-verified');

  // ── Build the document ──────────────────────────────────────────────────────

  const titlePara = new Paragraph({
    heading: HeadingLevel.TITLE,
    alignment: AlignmentType.CENTER,
    spacing: { after: 200 },
    children: [
      new TextRun({
        text: 'Sikkim INSPIRES IVA',
        bold: true,
        size: 52,
        color: HEADER_COLOR,
      }),
    ],
  });

  const subtitlePara = new Paragraph({
    alignment: AlignmentType.CENTER,
    spacing: { after: 120 },
    children: [
      new TextRun({
        text: 'Programme Verification Status Report',
        size: 36,
        color: '475569',
      }),
    ],
  });

  const datePara = new Paragraph({
    alignment: AlignmentType.CENTER,
    spacing: { after: 600 },
    children: [
      new TextRun({ text: `As of: ${today}`, size: 24, color: '64748b', italics: true }),
    ],
  });

  // Section 1 heading
  const sec1Heading = new Paragraph({
    heading: HeadingLevel.HEADING_1,
    spacing: { before: 400, after: 200 },
    children: [new TextRun({ text: '1. Overall Summary', bold: true, size: 28, color: HEADER_COLOR })],
  });

  const overallTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({
        tableHeader: true,
        children: [
          headerCell('Status', 50),
          headerCell('Verification Tasks', 25),
          headerCell('% of Total', 25),
        ],
      }),
      new TableRow({
        children: [
          cell('Verified', false, VERIFIED_COLOR.replace('#', '')),
          cell(String(totalVerified), true, VERIFIED_COLOR.replace('#', '')),
          cell(`${totalVerifications ? Math.round((totalVerified / totalVerifications) * 100) : 0}%`, false, VERIFIED_COLOR.replace('#', '')),
        ],
      }),
      new TableRow({
        children: [
          cell('Submitted (pending IVA sign-off)', false, 'fef3c7'),
          cell(String(totalSubmitted), true, 'fef3c7'),
          cell(`${totalVerifications ? Math.round((totalSubmitted / totalVerifications) * 100) : 0}%`, false, 'fef3c7'),
        ],
      }),
      new TableRow({
        children: [
          cell('Not Yet Verified', false, 'f1f5f9'),
          cell(String(totalNotVerified), true, 'f1f5f9'),
          cell(`${totalVerifications ? Math.round((totalNotVerified / totalVerifications) * 100) : 0}%`, false, 'f1f5f9'),
        ],
      }),
      new TableRow({
        children: [
          cell('Total', true),
          cell(String(totalVerifications), true),
          cell('100%', false),
        ],
      }),
    ],
  });

  // Section 2 heading
  const sec2Heading = new Paragraph({
    heading: HeadingLevel.HEADING_1,
    spacing: { before: 600, after: 200 },
    children: [new TextRun({ text: '2. Status by Department', bold: true, size: 28, color: HEADER_COLOR })],
  });

  const deptTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({
        tableHeader: true,
        children: [
          headerCell('Department', 40),
          headerCell('DLRs', 12),
          headerCell('Verified', 16),
          headerCell('Submitted', 16),
          headerCell('Not Verified', 16),
        ],
      }),
      ...deptSummaries.map(s =>
        new TableRow({
          children: [
            cell(s.department),
            cell(String(s.totalDlrs), true),
            cell(String(s.verified), false, s.verified > 0 ? VERIFIED_COLOR.replace('#', '') : undefined),
            cell(String(s.submitted), false, s.submitted > 0 ? 'fef3c7' : undefined),
            cell(String(s.notVerified), false, s.notVerified > 0 ? 'fef2f2' : undefined),
          ],
        })
      ),
    ],
  });

  // Section 3 heading
  const sec3Heading = new Paragraph({
    heading: HeadingLevel.HEADING_1,
    spacing: { before: 600, after: 200 },
    children: [new TextRun({ text: '3. DLRs with Submissions Pending IVA Verification', bold: true, size: 28, color: HEADER_COLOR })],
  });

  const pendingNote = new Paragraph({
    spacing: { after: 200 },
    children: [new TextRun({ text: `${pendingDlrs.length} DLRs have at least one verification task submitted and are awaiting IVA sign-off.`, size: 22, color: '475569', italics: true })],
  });

  const pendingTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({
        tableHeader: true,
        children: [
          headerCell('DLR', 12),
          headerCell('Description', 60),
          headerCell('Department', 28),
        ],
      }),
      ...pendingDlrs.map(r =>
        new TableRow({
          children: [
            cell(r.dlr, true, 'fef3c7'),
            cell(r.description, false, 'fef3c7'),
            cell(r.department, false, 'fef3c7'),
          ],
        })
      ),
    ],
  });

  // Section 4 heading
  const sec4Heading = new Paragraph({
    heading: HeadingLevel.HEADING_1,
    spacing: { before: 600, after: 200 },
    children: [new TextRun({ text: '4. DLRs Not Yet Started', bold: true, size: 28, color: HEADER_COLOR })],
  });

  const notStartedNote = new Paragraph({
    spacing: { after: 200 },
    children: [new TextRun({ text: `${notStartedDlrs.length} DLRs have no submissions and remain fully unverified (broadly Year 3–5 DLRs).`, size: 22, color: '475569', italics: true })],
  });

  const notStartedTable = new Table({
    layout: TableLayoutType.FIXED,
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [
      new TableRow({
        tableHeader: true,
        children: [
          headerCell('DLR', 12),
          headerCell('Description', 60),
          headerCell('Department', 28),
        ],
      }),
      ...notStartedDlrs.map(r =>
        new TableRow({
          children: [
            cell(r.dlr, true, 'f1f5f9'),
            cell(r.description, false, 'f1f5f9'),
            cell(r.department, false, 'f1f5f9'),
          ],
        })
      ),
    ],
  });

  const footerPara = new Paragraph({
    alignment: AlignmentType.CENTER,
    spacing: { before: 800 },
    children: [
      new TextRun({
        text: 'Generated by Sikkim INSPIRES IVA System — CESI, IIM Kozhikode',
        size: 18,
        color: '94a3b8',
        italics: true,
      }),
    ],
  });

  const doc = new Document({
    sections: [
      {
        children: [
          titlePara,
          subtitlePara,
          datePara,
          sec1Heading,
          overallTable,
          sec2Heading,
          deptTable,
          sec3Heading,
          pendingNote,
          pendingTable,
          sec4Heading,
          notStartedNote,
          notStartedTable,
          footerPara,
        ],
      },
    ],
  });

  const blob = await Packer.toBlob(doc);
  const filename = `Sikkim_INSPIRES_IVA_Status_Report_${new Date().toISOString().slice(0, 10)}.docx`;
  saveAs(blob, filename);
}
