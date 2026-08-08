-- Add category column to transactions table for category unlocks
ALTER TABLE transactions ADD COLUMN IF NOT EXISTS category TEXT;

-- Add index for faster queries
CREATE INDEX IF NOT EXISTS idx_transactions_category ON transactions(category) WHERE category IS NOT NULL;
