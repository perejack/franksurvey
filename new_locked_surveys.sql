-- Create NEW locked surveys that are completely separate from the free 13 surveys
-- These will be displayed in ExtraSurveys page after users unlock a category

-- First, ensure category column exists
ALTER TABLE surveys ADD COLUMN IF NOT EXISTS category VARCHAR(50);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_surveys_category_locked ON surveys(category, is_locked);

-- Insert NEW locked surveys for "Data Entry" category (Unlock: 100 KSH, Earn: up to 1000 KSH per survey)
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Basic Data Entry Task 1', 'Simple data entry forms for beginners', 'data_entry', 180, '5-10 min', 8, false, true, 100, NOW()),
('Basic Data Entry Task 2', 'Copy information from documents to digital forms', 'data_entry', 190, '5-10 min', 10, false, true, 100, NOW()),
('Basic Data Entry Task 3', 'Enter customer information accurately', 'data_entry', 185, '5-10 min', 9, false, true, 100, NOW()),
('Basic Data Entry Task 4', 'Transcribe short audio to text', 'data_entry', 200, '8-12 min', 12, false, true, 100, NOW()),
('Basic Data Entry Task 5', 'Update spreadsheet with new data', 'data_entry', 195, '6-10 min', 11, false, true, 100, NOW());

-- Insert NEW locked surveys for "Market Research" category (Unlock: 150 KSH, Earn: up to 2000 KSH per survey)
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Market Research Survey 1', 'Analyze consumer preferences for products', 'market_research', 250, '10-15 min', 15, false, true, 150, NOW()),
('Market Research Survey 2', 'Study buying patterns and trends', 'market_research', 275, '10-15 min', 16, false, true, 150, NOW()),
('Market Research Survey 3', 'Evaluate competitor products', 'market_research', 260, '10-15 min', 14, false, true, 150, NOW()),
('Market Research Survey 4', 'Brand awareness study', 'market_research', 280, '12-18 min', 18, false, true, 150, NOW()),
('Market Research Survey 5', 'Pricing sensitivity analysis', 'market_research', 265, '10-15 min', 15, false, true, 150, NOW());

-- Insert NEW locked surveys for "Customer Feedback" category (Unlock: 200 KSH, Earn: up to 3000 KSH per survey)
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Customer Satisfaction Survey 1', 'Rate your experience with services', 'customer_feedback', 350, '12-18 min', 20, false, true, 200, NOW()),
('Customer Satisfaction Survey 2', 'Feedback on product quality', 'customer_feedback', 375, '12-18 min', 22, false, true, 200, NOW()),
('Customer Satisfaction Survey 3', 'Service improvement suggestions', 'customer_feedback', 360, '12-18 min', 21, false, true, 200, NOW()),
('Customer Satisfaction Survey 4', 'Post-purchase experience review', 'customer_feedback', 380, '15-20 min', 24, false, true, 200, NOW()),
('Customer Satisfaction Survey 5', 'Support team evaluation', 'customer_feedback', 365, '12-18 min', 20, false, true, 200, NOW());

-- Insert NEW locked surveys for "Product Review" category (Unlock: 250 KSH, Earn: up to 4000 KSH per survey)
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Product Review Task 1', 'Detailed review of electronic gadgets', 'product_review', 450, '15-20 min', 25, false, true, 250, NOW()),
('Product Review Task 2', 'Test and review household appliances', 'product_review', 475, '15-20 min', 26, false, true, 250, NOW()),
('Product Review Task 3', 'Beauty products evaluation', 'product_review', 460, '15-20 min', 24, false, true, 250, NOW()),
('Product Review Task 4', 'Software and app usability testing', 'product_review', 480, '18-25 min', 28, false, true, 250, NOW()),
('Product Review Task 5', 'Fashion items quality assessment', 'product_review', 465, '15-20 min', 25, false, true, 250, NOW());

-- Insert NEW locked surveys for "Opinion Poll" category (Unlock: 300 KSH, Earn: up to 5000 KSH per survey)
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Premium Opinion Poll 1', 'Share your views on current events', 'opinion_poll', 550, '20-25 min', 30, false, true, 300, NOW()),
('Premium Opinion Poll 2', 'Political and social trends survey', 'opinion_poll', 575, '20-25 min', 32, false, true, 300, NOW()),
('Premium Opinion Poll 3', 'Economic outlook questionnaire', 'opinion_poll', 560, '20-25 min', 31, false, true, 300, NOW()),
('Premium Opinion Poll 4', 'Technology adoption opinions', 'opinion_poll', 580, '22-28 min', 34, false, true, 300, NOW()),
('Premium Opinion Poll 5', 'Lifestyle and wellness survey', 'opinion_poll', 565, '20-25 min', 30, false, true, 300, NOW());

-- Summary of categories:
-- data_entry: 5 surveys, unlock 100 KSH, earn 180-200 KSH per survey (total potential: ~950 KSH)
-- market_research: 5 surveys, unlock 150 KSH, earn 250-280 KSH per survey (total potential: ~1330 KSH)
-- customer_feedback: 5 surveys, unlock 200 KSH, earn 350-380 KSH per survey (total potential: ~1830 KSH)
-- product_review: 5 surveys, unlock 250 KSH, earn 450-480 KSH per survey (total potential: ~2330 KSH)
-- opinion_poll: 5 surveys, unlock 300 KSH, earn 550-580 KSH per survey (total potential: ~2830 KSH)
