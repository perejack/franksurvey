-- Fix constraint with actual types that exist in the database
-- Based on query results: activation, survey_earning, withdrawal, upgrade

-- Step 1: Drop existing constraint
ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

-- Step 2: Add constraint with correct types from the database
ALTER TABLE transactions ADD CONSTRAINT transactions_type_check 
CHECK (type IN (
  'activation', 
  'survey_earning', 
  'withdrawal', 
  'upgrade',
  'category_unlock',
  'deposit',
  'referral',
  'bonus',
  'payment'
));

-- Verify
SELECT DISTINCT type, COUNT(*) as count FROM transactions GROUP BY type;
