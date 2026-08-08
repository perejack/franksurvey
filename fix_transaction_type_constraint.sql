-- Update the transactions_type_check constraint to include 'category_unlock'

-- First, drop the existing constraint
ALTER TABLE transactions DROP CONSTRAINT IF EXISTS transactions_type_check;

-- Add the new constraint with all valid transaction types
ALTER TABLE transactions ADD CONSTRAINT transactions_type_check 
CHECK (type IN ('survey_completion', 'withdrawal', 'deposit', 'referral', 'bonus', 'upgrade', 'category_unlock'));
