-- Update survey rewards to range from 100-150 KSH
-- Run this in Supabase SQL Editor

-- Update Lifestyle surveys (100-110 range)
UPDATE surveys SET reward = 100 WHERE title = 'Daily Transport Habits' AND category = 'lifestyle';
UPDATE surveys SET reward = 105 WHERE title = 'Phone Usage Survey' AND category = 'lifestyle';
UPDATE surveys SET reward = 110 WHERE title = 'Shopping Preferences' AND category = 'lifestyle';
UPDATE surveys SET reward = 100 WHERE title = 'Weekend Activities' AND category = 'lifestyle';
UPDATE surveys SET reward = 105 WHERE title = 'Food & Eating Habits' AND category = 'lifestyle';

-- Update Mobile Tech surveys (115-125 range)
UPDATE surveys SET reward = 115 WHERE title = 'M-Pesa Usage Survey' AND category = 'mobile_tech';
UPDATE surveys SET reward = 120 WHERE title = 'Mobile Banking Habits' AND category = 'mobile_tech';
UPDATE surveys SET reward = 115 WHERE title = 'Social Media Usage' AND category = 'mobile_tech';
UPDATE surveys SET reward = 125 WHERE title = 'Internet & Data Usage' AND category = 'mobile_tech';
UPDATE surveys SET reward = 120 WHERE title = 'Apps You Use Daily' AND category = 'mobile_tech';

-- Update Consumer surveys (125-135 range)
UPDATE surveys SET reward = 125 WHERE title = 'Supermarket Preferences' AND category = 'consumer';
UPDATE surveys SET reward = 130 WHERE title = 'Airtime Purchase Habits' AND category = 'consumer';
UPDATE surveys SET reward = 135 WHERE title = 'Brand Preferences' AND category = 'consumer';
UPDATE surveys SET reward = 130 WHERE title = 'Online Shopping Habits' AND category = 'consumer';
UPDATE surveys SET reward = 125 WHERE title = 'Product Choices' AND category = 'consumer';

-- Update Entertainment surveys (135-145 range)
UPDATE surveys SET reward = 135 WHERE title = 'TV & Movie Preferences' AND category = 'entertainment';
UPDATE surveys SET reward = 140 WHERE title = 'Music Preferences' AND category = 'entertainment';
UPDATE surveys SET reward = 135 WHERE title = 'Radio Listening Habits' AND category = 'entertainment';
UPDATE surveys SET reward = 145 WHERE title = 'Sports Interests' AND category = 'entertainment';
UPDATE surveys SET reward = 140 WHERE title = 'News Sources' AND category = 'entertainment';

-- Update Community surveys (140-150 range)
UPDATE surveys SET reward = 140 WHERE title = 'Neighborhood Survey' AND category = 'community';
UPDATE surveys SET reward = 145 WHERE title = 'Local Business Usage' AND category = 'community';
UPDATE surveys SET reward = 150 WHERE title = 'Community Services' AND category = 'community';
UPDATE surveys SET reward = 145 WHERE title = 'Religious Activities' AND category = 'community';
UPDATE surveys SET reward = 140 WHERE title = 'Social Gatherings' AND category = 'community';

-- Verify the updates
SELECT category, title, reward FROM surveys 
WHERE category IN ('lifestyle', 'mobile_tech', 'consumer', 'entertainment', 'community')
ORDER BY category, reward;
