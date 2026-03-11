-- Add questions to ALL premium/locked surveys (extra-surveys page)
-- These are surveys that users unlock by paying

-- ============================================
-- PREMIUM LIFESTYLE SURVEYS
-- ============================================

-- Daily Transport Habits (KSH 100)
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What is your main mode of daily transport?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Personal car", "Walking"]', 1
FROM surveys WHERE title = 'Daily Transport Habits' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 1);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How long is your typical commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 2
FROM surveys WHERE title = 'Daily Transport Habits' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 2);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What time do you usually travel?', 'single_choice', '["Early morning (5-7am)", "Morning rush (7-9am)", "Midday", "Evening rush (5-7pm)", "Night"]', 3
FROM surveys WHERE title = 'Daily Transport Habits' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 3);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How much do you spend on transport daily?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 4
FROM surveys WHERE title = 'Daily Transport Habits' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 4);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you use ride-hailing apps?', 'single_choice', '["Daily", "Few times a week", "Occasionally", "Rarely", "Never"]', 5
FROM surveys WHERE title = 'Daily Transport Habits' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 5);

-- Phone Usage Survey (KSH 105)
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How many hours daily on your phone?', 'single_choice', '["Less than 1 hour", "1-3 hours", "3-5 hours", "5-8 hours", "Over 8 hours"]', 1
FROM surveys WHERE title = 'Phone Usage Survey' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 1);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What do you use your phone for most?', 'single_choice', '["Social media", "Calls/SMS", "Work", "Entertainment", "Shopping"]', 2
FROM surveys WHERE title = 'Phone Usage Survey' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 2);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Which social media app do you use most?', 'single_choice', '["WhatsApp", "TikTok", "Instagram", "Facebook", "Twitter/X"]', 3
FROM surveys WHERE title = 'Phone Usage Survey' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 3);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you use your phone for mobile money?', 'single_choice', '["Daily", "Few times a week", "Weekly", "Rarely", "Never"]', 4
FROM surveys WHERE title = 'Phone Usage Survey' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 4);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What phone brand do you use?', 'single_choice', '["Samsung", "iPhone", "Tecno", "Infinix", "Other"]', 5
FROM surveys WHERE title = 'Phone Usage Survey' AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 5);

-- ============================================
-- CHECK ALL SURVEYS AND THEIR QUESTION COUNTS
-- ============================================

SELECT 
    s.id,
    s.title,
    s.category,
    s.reward,
    s.questions_count,
    COUNT(sq.id) as actual_questions,
    CASE WHEN COUNT(sq.id) = 0 THEN 'MISSING QUESTIONS' ELSE 'OK' END as status
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE s.is_locked = true OR s.is_premium = true
GROUP BY s.id, s.title, s.category, s.reward, s.questions_count
ORDER BY s.category, s.title;
