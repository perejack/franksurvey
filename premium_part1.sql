-- Add questions to ALL 13 premium surveys missing questions
-- Based on the exact UUIDs from the check

-- ============================================
-- 1. NEIGHBORHOOD SURVEY (d04e2ce6-346b-4afa-96aa-be18fe84934b) - 5 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('d04e2ce6-346b-4afa-96aa-be18fe84934b', 'How long have you lived in your neighborhood?', 'single_choice', '["Less than 1 year", "1-2 years", "3-5 years", "5-10 years", "Over 10 years"]', 1),
('d04e2ce6-346b-4afa-96aa-be18fe84934b', 'How safe do you feel in your neighborhood?', 'single_choice', '["Very safe", "Safe", "Neutral", "Unsafe", "Very unsafe"]', 2),
('d04e2ce6-346b-4afa-96aa-be18fe84934b', 'What is the best thing about your neighborhood?', 'single_choice', '["Safety", "Location", "Community", "Amenities", "Affordability"]', 3),
('d04e2ce6-346b-4afa-96aa-be18fe84934b', 'What would you like to improve?', 'single_choice', '["Security", "Roads", "Water/Electricity", "Shops", "Healthcare"]', 4),
('d04e2ce6-346b-4afa-96aa-be18fe84934b', 'Would you recommend living here?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 5);

-- ============================================
-- 2. SUPERMARKET PREFERENCES (a558b0aa-c625-43a5-b72f-fc156efcc570) - 6 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('a558b0aa-c625-43a5-b72f-fc156efcc570', 'Which supermarket do you visit most?', 'single_choice', '["Naivas", "Quickmart", "Carrefour", "Chandarana", "Local shop"]', 1),
('a558b0aa-c625-43a5-b72f-fc156efcc570', 'How often do you shop at supermarkets?', 'single_choice', '["Daily", "Few times a week", "Weekly", "Monthly", "Rarely"]', 2),
('a558b0aa-c625-43a5-b72f-fc156efcc570', 'What matters most when choosing a supermarket?', 'single_choice', '["Price", "Quality", "Location", "Variety", "Cleanliness"]', 3),
('a558b0aa-c625-43a5-b72f-fc156efcc570', 'Do you use supermarket loyalty cards?', 'single_choice', '["Yes, multiple", "Yes, one", "No, but interested", "No, not interested", "Did not know they exist"]', 4),
('a558b0aa-c625-43a5-b72f-fc156efcc570', 'How much do you spend per visit?', 'single_choice', '["Under KSH 500", "KSH 500-1000", "KSH 1000-2000", "KSH 2000-5000", "Over KSH 5000"]', 5),
('a558b0aa-c625-43a5-b72f-fc156efcc570', 'Do you prefer branded or generic products?', 'single_choice', '["Always branded", "Mostly branded", "Both equally", "Mostly generic", "Always generic"]', 6);

-- ============================================
-- 3. STREAMING SERVICES SURVEY (1bccd19b-e640-45a7-848c-33de5365835b) - 9 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('1bccd19b-e640-45a7-848c-33de5365835b', 'Which streaming service do you use most?', 'single_choice', '["Netflix", "Showmax", "YouTube Premium", "Amazon Prime", "None"]', 1),
('1bccd19b-e640-45a7-848c-33de5365835b', 'How many hours daily on streaming?', 'single_choice', '["Less than 1 hour", "1-2 hours", "2-3 hours", "3-5 hours", "Over 5 hours"]', 2),
('1bccd19b-e640-45a7-848c-33de5365835b', 'What content do you watch most?', 'single_choice', '["Movies", "Series/Drama", "Documentaries", "Reality shows", "Local content"]', 3),
('1bccd19b-e640-45a7-848c-33de5365835b', 'Do you share your streaming account?', 'single_choice', '["Yes, with family", "Yes, with friends", "No, solo use", "Thinking about it", "No subscription"]', 4),
('1bccd19b-e640-45a7-848c-33de5365835b', 'What device do you stream on?', 'single_choice', '["Phone", "TV", "Laptop", "Tablet", "Multiple devices"]', 5),
('1bccd19b-e640-45a7-848c-33de5365835b', 'How much do you pay for streaming monthly?', 'single_choice', '["Under KSH 500", "KSH 500-1000", "KSH 1000-2000", "KSH 2000-3000", "Over KSH 3000"]', 6),
('1bccd19b-e640-45a7-848c-33de5365835b', 'Do you prefer local or international content?', 'single_choice', '["Local only", "Mostly local", "Both equally", "Mostly international", "International only"]', 7),
('1bccd19b-e640-45a7-848c-33de5365835b', 'Have you cancelled a subscription recently?', 'single_choice', '["Yes, too expensive", "Yes, not enough content", "Yes, switched services", "No, but considering", "No, happy with all"]', 8),
('1bccd19b-e640-45a7-848c-33de5365835b', 'What would improve streaming for you?', 'single_choice', '["Lower prices", "More local content", "Better quality", "More variety", "Offline downloads"]', 9);

-- ============================================
-- 4. TV & MOVIE PREFERENCES (e515dba2-95d0-40f5-a9de-3310816a4d13) - 6 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('e515dba2-95d0-40f5-a9de-3310816a4d13', 'How often do you watch TV/movies?', 'single_choice', '["Daily", "Few times a week", "Weekly", "Monthly", "Rarely"]', 1),
('e515dba2-95d0-40f5-a9de-3310816a4d13', 'What is your favorite movie genre?', 'single_choice', '["Action", "Comedy", "Drama", "Romance", "Horror"]', 2),
('e515dba2-95d0-40f5-a9de-3310816a4d13', 'Where do you watch most content?', 'single_choice', '["Cinema", "Home TV", "Streaming", "Phone", "With friends"]', 3),
('e515dba2-95d0-40f5-a9de-3310816a4d13', 'Do you prefer local or Hollywood movies?', 'single_choice', '["Local only", "Mostly local", "Both equally", "Mostly Hollywood", "Hollywood only"]', 4),
('e515dba2-95d0-40f5-a9de-3310816a4d13', 'How much monthly on entertainment?', 'single_choice', '["Under KSH 500", "KSH 500-1000", "KSH 1000-2000", "KSH 2000-3000", "Over KSH 3000"]', 5),
('e515dba2-95d0-40f5-a9de-3310816a4d13', 'What time do you usually watch?', 'single_choice', '["Morning", "Afternoon", "Evening", "Night", "Weekends only"]', 6);

-- ============================================
-- 5. INVESTMENT PREFERENCES (b76758a8-833d-490b-a2d4-ab8bb873fea6) - 15 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'Have you ever invested money?', 'single_choice', '["Yes, multiple times", "Yes, once", "No, but planning", "No, too risky", "No, no money"]', 1),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'What is your preferred investment type?', 'single_choice', '["Stocks/Shares", "Real estate", "SACCOs", "Government bonds", "Crypto"]', 2),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'How much have you invested total?', 'single_choice', '["Under KSH 10000", "KSH 10000-50000", "KSH 50000-100000", "KSH 100000-500000", "Over KSH 500000"]', 3),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'What is your investment goal?', 'single_choice', '["Retirement", "Buy property", "Education", "Business", "Wealth building"]', 4),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'How do you research investments?', 'single_choice', '["Financial advisor", "Online research", "Friends/Family", "Social media", "I don''t research"]', 5),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'Are you satisfied with your returns?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 6),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'What prevents you from investing more?', 'single_choice', '["Lack of capital", "Fear of loss", "No knowledge", "No time", "Don''t trust markets"]', 7),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'How long do you hold investments?', 'single_choice', '["Less than 1 year", "1-2 years", "3-5 years", "5-10 years", "Over 10 years"]', 8),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'Do you use a broker or invest directly?', 'single_choice', '["Licensed broker", "Investment app", "Bank", "Direct with company", "No broker needed"]', 9),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'What is your risk tolerance?', 'single_choice', '["Very high", "High", "Moderate", "Low", "Very low"]', 10),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'Have you lost money investing?', 'single_choice', '["Yes, significantly", "Yes, small amount", "No, but broke even", "No, always profited", "Never invested"]', 11),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'Do you diversify your investments?', 'single_choice', '["Yes, many types", "Yes, a few types", "Somewhat", "No, one type", "Not sure what that means"]', 12),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'How often do you check investments?', 'single_choice', '["Daily", "Weekly", "Monthly", "Few times a year", "Rarely"]', 13),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'Would you invest in a startup?', 'single_choice', '["Yes, definitely", "Yes, if promising", "Maybe", "Probably not", "No, too risky"]', 14),
('b76758a8-833d-490b-a2d4-ab8bb873fea6', 'What would improve investment in Kenya?', 'single_choice', '["Lower fees", "Better regulation", "More education", "Easier access", "More options"]', 15);

-- Continue in next file - too long
