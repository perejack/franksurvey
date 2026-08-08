-- Fix transaction type constraint to include survey_earning
-- Run this in Supabase SQL Editor

-- Drop existing constraint
ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

-- Add constraint with ALL valid types including survey_earning
ALTER TABLE transactions ADD CONSTRAINT transactions_type_check 
CHECK (type IN (
  'activation', 
  'survey_earning', 
  'withdrawal', 
  'upgrade',
  'category_unlock',
  'deposit',
  'referral',
  'bonus'
));

-- Verify
SELECT DISTINCT type, COUNT(*) as count FROM transactions GROUP BY type;
