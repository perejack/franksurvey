-- Comprehensive fix for all transaction types
-- Run this entire script in Supabase SQL Editor

-- Step 1: Drop the constraint temporarily
ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

-- Step 2: Find and see all current types
SELECT DISTINCT type, COUNT(*) as count 
FROM transactions 
GROUP BY type 
ORDER BY count DESC;

-- Step 3: Update any NULL or invalid types to a valid one
-- (Update this list based on what types you actually want to keep)
UPDATE transactions 
SET type = 'survey_earning' 
WHERE type IS NULL;

-- Step 4: Add the constraint back with comprehensive list
-- Include ALL types that exist in your database
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
  'survey_completion',
  'payment',
  'unlock'
));
