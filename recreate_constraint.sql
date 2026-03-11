-- Completely recreate the type check constraint

-- First, see current constraint definition
SELECT conname, pg_get_constraintdef(oid) 
FROM pg_constraint 
WHERE conrelid = 'transactions'::regclass 
AND conname = 'transactions_type_check';

-- Drop the constraint completely
ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

-- Commit any pending changes
COMMIT;

-- Add the correct constraint
ALTER TABLE transactions ADD CONSTRAINT transactions_type_check 
CHECK (type IN ('survey_completion', 'withdrawal', 'deposit', 'referral', 'bonus', 'upgrade', 'category_unlock', 'payment', 'unlock', 'task_completion'));
