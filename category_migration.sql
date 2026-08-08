-- Add category column to surveys table
ALTER TABLE surveys ADD COLUMN IF NOT EXISTS category VARCHAR(50);

-- Create index for category queries
CREATE INDEX IF NOT EXISTS idx_surveys_category ON surveys(category);

-- Update existing surveys with sample categories
-- First 13 free surveys (is_locked = false) - these remain unlocked for new users
UPDATE surveys 
SET category = CASE 
  WHEN id IN (SELECT id FROM surveys WHERE is_locked = false AND is_premium = false ORDER BY created_at LIMIT 5) THEN 'free_beginner'
  WHEN id IN (SELECT id FROM surveys WHERE is_locked = false AND is_premium = false ORDER BY created_at OFFSET 5 LIMIT 4) THEN 'free_standard'
  WHEN id IN (SELECT id FROM surveys WHERE is_locked = false AND is_premium = false ORDER BY created_at OFFSET 9 LIMIT 4) THEN 'free_advanced'
  ELSE category
END
WHERE is_locked = false AND is_premium = false;

-- Locked surveys - these will be unlockable by category
UPDATE surveys 
SET category = CASE 
  WHEN (SELECT COUNT(*) FROM surveys WHERE category = 'data_entry') < 5 THEN 'data_entry'
  WHEN (SELECT COUNT(*) FROM surveys WHERE category = 'market_research') < 5 THEN 'market_research'
  WHEN (SELECT COUNT(*) FROM surveys WHERE category = 'customer_feedback') < 5 THEN 'customer_feedback'
  WHEN (SELECT COUNT(*) FROM surveys WHERE category = 'product_review') < 5 THEN 'product_review'
  WHEN (SELECT COUNT(*) FROM surveys WHERE category = 'opinion_poll') < 5 THEN 'opinion_poll'
  ELSE 'general'
END
WHERE is_locked = true AND is_premium = false AND category IS NULL;

-- Categories for locked surveys with their unlock prices and earning potential
-- data_entry: Unlock 100 KSH, earn up to 1000 KSH per survey
-- market_research: Unlock 150 KSH, earn up to 2000 KSH per survey
-- customer_feedback: Unlock 200 KSH, earn up to 3000 KSH per survey
-- product_review: Unlock 250 KSH, earn up to 4000 KSH per survey
-- opinion_poll: Unlock 300 KSH, earn up to 5000 KSH per survey

-- Update unlock prices based on category for locked surveys
UPDATE surveys 
SET unlock_price = CASE category
  WHEN 'data_entry' THEN 100
  WHEN 'market_research' THEN 150
  WHEN 'customer_feedback' THEN 200
  WHEN 'product_review' THEN 250
  WHEN 'opinion_poll' THEN 300
  ELSE 100
END
WHERE is_locked = true AND is_premium = false;
