-- Fix existing invalid transaction types before applying constraint

-- First, see what types exist
SELECT DISTINCT type FROM transactions;

-- Update any rows with NULL or invalid types to 'survey_completion'
UPDATE transactions 
SET type = 'survey_completion' 
WHERE type IS NULL 
   OR type NOT IN ('survey_completion', 'withdrawal', 'deposit', 'referral', 'bonus', 'upgrade', 'category_unlock');

-- Now drop and recreate the constraint
ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

ALTER TABLE transactions ADD CONSTRAINT transactions_type_check 
CHECK (type IN ('survey_completion', 'withdrawal', 'deposit', 'referral', 'bonus', 'upgrade', 'category_unlock'));
