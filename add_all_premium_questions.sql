-- Add questions to ALL premium/locked surveys
-- This handles all categories: lifestyle, tech, transport, etc.

-- ============================================
-- GENERIC QUESTIONS BY CATEGORY
-- ============================================

-- LIFESTYLE PREMIUM SURVEYS
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'How often do you go shopping?', 'single_choice', '["Daily", "Weekly", "Monthly", "Rarely", "Never"]', 1
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 1
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'lifestyle'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'What is your preferred shopping method?', 'single_choice', '["Online", "Supermarket", "Local market", "Mall", "Small shops"]', 2
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 2
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'lifestyle'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'How much do you spend on lifestyle monthly?', 'single_choice', '["Under KSH 1000", "KSH 1000-5000", "KSH 5000-10000", "KSH 10000-20000", "Over KSH 20000"]', 3
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 3
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'lifestyle'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'Do you prefer local or international brands?', 'single_choice', '["Local only", "Mostly local", "Both equally", "Mostly international", "International only"]', 4
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 4
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'lifestyle'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'What influences your lifestyle choices?', 'single_choice', '["Price", "Quality", "Trends", "Friends/Family", "Social media"]', 5
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 5
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'lifestyle'
AND sq.id IS NULL;

-- TECH PREMIUM SURVEYS
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'What device do you use most?', 'single_choice', '["Smartphone", "Laptop", "Tablet", "Desktop", "Smart TV"]', 1
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 1
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'tech'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'How many hours daily on tech devices?', 'single_choice', '["Less than 2 hours", "2-4 hours", "4-6 hours", "6-8 hours", "Over 8 hours"]', 2
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 2
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'tech'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'What tech feature matters most to you?', 'single_choice', '["Speed", "Battery life", "Camera", "Storage", "Price"]', 3
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 3
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'tech'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'Do you upgrade devices frequently?', 'single_choice', '["Every year", "Every 2 years", "Every 3-4 years", "Only when broken", "Rarely"]', 4
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 4
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'tech'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'What is your tech budget monthly?', 'single_choice', '["Under KSH 1000", "KSH 1000-3000", "KSH 3000-5000", "KSH 5000-10000", "Over KSH 10000"]', 5
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 5
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'tech'
AND sq.id IS NULL;

-- TRANSPORT PREMIUM SURVEYS
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'What is your main transport mode?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Car", "Walking"]', 1
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 1
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'transport'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'How much daily on transport?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 2
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 2
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'transport'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'Do you use Uber/Bolt?', 'single_choice', '["Daily", "Weekly", "Monthly", "Rarely", "Never"]', 3
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 3
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'transport'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'How long is your commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 4
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 4
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'transport'
AND sq.id IS NULL;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT s.id, 'What is your biggest transport issue?', 'single_choice', '["Cost", "Traffic", "Safety", "Availability", "Comfort"]', 5
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id AND sq.order_number = 5
WHERE (s.is_locked = true OR s.is_premium = true) 
AND s.category = 'transport'
AND sq.id IS NULL;

-- Verify all premium surveys now have questions
SELECT 
    s.category,
    COUNT(DISTINCT s.id) as total_surveys,
    COUNT(DISTINCT CASE WHEN sq.id IS NOT NULL THEN s.id END) as surveys_with_questions,
    COUNT(sq.id) as total_questions
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE s.is_locked = true OR s.is_premium = true
GROUP BY s.category
ORDER BY s.category;
