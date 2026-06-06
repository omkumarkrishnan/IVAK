-- Populate missing methodology for Year 0 / prior-result DLRs (desk-review only tasks)

UPDATE verifications
SET methodology = 'The IVA team will conduct a desk review of the Government Order (GO) on the establishment of the Employment and Entrepreneurship Promotion Facility. The document will be reviewed to confirm it was officially issued by the State Cabinet, covering the mandate, composition, and operational framework of the Facility.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 1.0.1')
  AND description = 'GO on the establishment of the Employment and Entrepreneurship Promotion Facility';

UPDATE verifications
SET methodology = 'The IVA team will conduct a desk review of the Government Order (GO) confirming official government approval and public notification of the Sikkim Industrial and Services Sector Development & Investment Policy 2023. The review will verify that the policy was disclosed on the GoS website as required.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 2.0.1')
  AND description = 'Notification of the Sikkim Industrial and Services Sector Development & Investment Policy 2023.';

UPDATE verifications
SET methodology = 'The IVA team will conduct a desk review of the official document issued by the International Montessori Foundation (IMF) confirming that the inspection of IHCAE was completed. The document will be reviewed to verify authenticity and confirmation of the inspection process.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 3.0.1')
  AND description = 'Review of the official document from the IMF conveying the completion of the inspection of IHCAE';

UPDATE verifications
SET methodology = 'The IVA team will conduct a desk review of the official document issued by the International Montessori Foundation (IMF) confirming that IHCAE has been granted recognition. The document will be reviewed to verify that formal IMF recognition has been awarded following the inspection.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 3.0.2')
  AND description = 'Review of the official document from the IMF conveying the completion of the inspection of IHCAE';

UPDATE verifications
SET methodology = 'The IVA team will conduct a desk review of (i) the official notification/GO for setting up the Expert Group convened by PDD in collaboration with H&FWD, and (ii) the report produced by the Expert Group on research priorities and roadmap for understanding socio-economic aspects of declining fertility rates in Sikkim. Both documents will be reviewed to confirm the meeting was organised and the report finalised.'
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 8.0.1')
  AND description = 'Review of the notification for setting up the Expert Group and report of the expert group';
