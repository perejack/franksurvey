-- Comprehensive fix for transactions_type_check constraint
-- Run this entire script in order

-- Step 1: Drop the constraint if it exists
ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

-- Step 2: Find all invalid types
SELECT DISTINCT type, COUNT(*) as count 
FROM transactions 
WHERE type NOT IN ('survey_completion', 'withdrawal', 'deposit', 'referral', 'bonus', 'upgrade', 'category_unlock', 'payment', 'unlock', 'task_completion')
   OR type IS NULL
GROUP BY type;

-- Step 3: Update all invalid/NULL types to 'survey_completion'
UPDATE transactions 
SET type = 'survey_completion' 
WHERE type IS NULL 
   OR type NOT IN ('survey_completion', 'withdrawal', 'deposit', 'referral', 'bonus', 'upgrade', 'category_unlock', 'payment', 'unlock', 'task_completion');

-- Step 4: Now add the constraint back with all valid types
ALTER TABLE transactions ADD CONSTRAINT transactions_type_check 
CHECK (type IN ('survey_completion', 'withdrawal', 'deposit', 'referral', 'bonus', 'upgrade', 'category_unlock', 'payment', 'unlock', 'task_completion'));

-- Step 5: Verify
SELECT DISTINCT type, COUNT(*) as count FROM transactions GROUP BY type;
