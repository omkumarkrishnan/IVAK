export interface Department {
  id: string;
  name: string;
  created_at: string;
  updated_at: string;
}

export interface Period {
  id: string;
  name: string;
  created_at: string;
  updated_at: string;
}

export interface DLI {
  id: string;
  code: string;
  description: string;
  period_id: string;
  department_id: string;
  verification_method?: string;
  verification_heading?: string;
  data_requirements?: string[];
  created_at: string;
  updated_at: string;
  period?: Period;
  verifications?: Verification[];
  files?: DLIFile[];
  iva_reports?: IVAReport[];
}

export type VerificationState = 'non-verified' | 'submitted' | 'verified';

export interface Verification {
  id: string;
  dli_id: string;
  description: string;
  state: VerificationState;
  methodology?: string;
  created_at: string;
  updated_at: string;
}

export interface DLIFile {
  id: string;
  dli_id: string;
  file_name: string;
  file_path: string;
  file_size: number | null;
  mime_type: string | null;
  uploaded_by: string | null;
  created_at: string;
}

export interface IVAReport {
  id: string;
  dli_id: string;
  report_name: string;
  file_name: string;
  file_path: string;
  file_size: number | null;
  mime_type: string | null;
  uploaded_by: string | null;
  uploaded_at: string;
  created_at: string;
}

export interface DepartmentWithDLIs extends Department {
  dlis: DLI[];
}
