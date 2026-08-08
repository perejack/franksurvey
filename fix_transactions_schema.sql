-- Ensure all columns needed for category unlocks exist in transactions table

-- Add category column if not exists
ALTER TABLE transactions ADD COLUMN IF NOT EXISTS category TEXT;

-- Add reference column if not exists (needed for M-Pesa tracking)
ALTER TABLE transactions ADD COLUMN IF NOT EXISTS reference TEXT;

-- Add description column if not exists
ALTER TABLE transactions ADD COLUMN IF NOT EXISTS description TEXT;

-- Add survey_id column (nullable, for backward compatibility)
ALTER TABLE transactions ADD COLUMN IF NOT EXISTS survey_id UUID REFERENCES surveys(id);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_transactions_category ON transactions(category) WHERE category IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_transactions_reference ON transactions(reference) WHERE reference IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_transactions_type_status ON transactions(type, status);

-- Verify columns exist
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'transactions' 
ORDER BY ordinal_position;
