-- Create NEW locked surveys with simple multiple choice questions for Kenyans
-- These are easy option-based surveys - no typing required!

-- First, ensure category column exists
ALTER TABLE surveys ADD COLUMN IF NOT EXISTS category VARCHAR(50);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_surveys_category_locked ON surveys(category, is_locked);

-- Insert NEW locked surveys for "Lifestyle & Habits" category (Unlock: 2 KSH for testing)
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Daily Transport Habits', 'Quick survey about how you move around - just select options!', 'lifestyle', 40, '2-3 min', 5, false, true, 2, NOW()),
('Phone Usage Survey', 'Tell us about your mobile habits - all multiple choice!', 'lifestyle', 45, '2-3 min', 5, false, true, 2, NOW()),
('Shopping Preferences', 'Where and how you shop - simple option selection!', 'lifestyle', 42, '2-3 min', 5, false, true, 2, NOW()),
('Weekend Activities', 'What do you do on weekends? Just pick options!', 'lifestyle', 38, '2-3 min', 5, false, true, 2, NOW()),
('Food & Eating Habits', 'Quick questions about what you eat - multiple choice!', 'lifestyle', 40, '2-3 min', 5, false, true, 2, NOW());

-- Insert NEW locked surveys for "Mobile & Technology" category
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('M-Pesa Usage Survey', 'How you use mobile money - select your answers!', 'mobile_tech', 50, '3-4 min', 6, false, true, 2, NOW()),
('Mobile Banking Habits', 'Your banking preferences - all multiple choice!', 'mobile_tech', 48, '3-4 min', 6, false, true, 2, NOW()),
('Social Media Usage', 'Which platforms you use - just select options!', 'mobile_tech', 45, '3-4 min', 6, false, true, 2, NOW()),
('Internet & Data Usage', 'How you use the internet - quick multiple choice!', 'mobile_tech', 52, '3-4 min', 6, false, true, 2, NOW()),
('Apps You Use Daily', 'Your favorite mobile apps - select from options!', 'mobile_tech', 47, '3-4 min', 6, false, true, 2, NOW());

-- Insert NEW locked surveys for "Consumer Choices" category
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Supermarket Preferences', 'Where you buy groceries - simple selection!', 'consumer', 55, '3-4 min', 6, false, true, 2, NOW()),
('Airtime Purchase Habits', 'How you buy credit - just pick options!', 'consumer', 50, '3-4 min', 6, false, true, 2, NOW()),
('Brand Preferences', 'Which brands you prefer - multiple choice!', 'consumer', 58, '3-4 min', 6, false, true, 2, NOW()),
('Online Shopping Habits', 'Do you shop online? Quick option survey!', 'consumer', 52, '3-4 min', 6, false, true, 2, NOW()),
('Product Choices', 'What influences your buying - select answers!', 'consumer', 55, '3-4 min', 6, false, true, 2, NOW());

-- Insert NEW locked surveys for "Entertainment & Media" category
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('TV & Movie Preferences', 'What you watch - simple option survey!', 'entertainment', 60, '3-4 min', 6, false, true, 2, NOW()),
('Music Preferences', 'Your music taste - just select options!', 'entertainment', 58, '3-4 min', 6, false, true, 2, NOW()),
('Radio Listening Habits', 'Which stations you listen to - multiple choice!', 'entertainment', 55, '3-4 min', 6, false, true, 2, NOW()),
('Sports Interests', 'Sports you follow - quick selection survey!', 'entertainment', 62, '3-4 min', 6, false, true, 2, NOW()),
('News Sources', 'Where you get news - simple option survey!', 'entertainment', 57, '3-4 min', 6, false, true, 2, NOW());

-- Insert NEW locked surveys for "Community & Society" category
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Neighborhood Survey', 'About your area - just select options!', 'community', 45, '2-3 min', 5, false, true, 2, NOW()),
('Local Business Usage', 'Shops near you - multiple choice survey!', 'community', 48, '2-3 min', 5, false, true, 2, NOW()),
('Community Services', 'Services you use - simple option selection!', 'community', 50, '2-3 min', 5, false, true, 2, NOW()),
('Religious Activities', 'Your religious participation - select options!', 'community', 42, '2-3 min', 5, false, true, 2, NOW()),
('Social Gatherings', 'How you socialize - quick multiple choice!', 'community', 47, '2-3 min', 5, false, true, 2, NOW());

-- All surveys are simple multiple choice - no typing or long answers needed!
-- Each survey pays between 38-62 KSH
-- Total potential: 25 surveys × avg 50 KSH = ~1250 KSH
-- All unlock prices set to 2 KSH for testing
