-- Fix all invalid transaction types before adding constraint

-- First, see what invalid types exist
SELECT DISTINCT type, COUNT(*) as count 
FROM transactions 
WHERE type NOT IN ('activation', 'survey_earning', 'withdrawal', 'upgrade', 'category_unlock', 'deposit', 'referral', 'bonus', 'survey_completion', 'payment', 'unlock', 'task_completion')
   OR type IS NULL
GROUP BY type;

-- Update ALL invalid/NULL types to 'survey_earning' (safe default)
UPDATE transactions 
SET type = 'survey_earning' 
WHERE type IS NULL 
   OR type NOT IN ('activation', 'survey_earning', 'withdrawal', 'upgrade', 'category_unlock', 'deposit', 'referral', 'bonus');

-- Now safe to drop and recreate constraint
ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

ALTER TABLE transactions ADD CONSTRAINT transactions_type_check 
CHECK (type IN (
  'activation', 'survey_earning', 'withdrawal', 
  'upgrade', 'category_unlock', 'deposit', 'referral', 'bonus'
));

-- Verify
SELECT DISTINCT type, COUNT(*) as count FROM transactions GROUP BY type ORDER BY count DESC;
