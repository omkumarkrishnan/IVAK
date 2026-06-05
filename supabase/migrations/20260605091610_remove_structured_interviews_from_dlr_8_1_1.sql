-- Per minutes: "Structured interviews" task removed from DLR 8.1.1
DELETE FROM verifications
WHERE dli_id = (SELECT id FROM dlis WHERE code = 'DLR 8.1.1')
  AND description = 'Structured interviews';
