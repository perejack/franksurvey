-- Create Transportation and Home & Living surveys with ALL their questions
-- This creates surveys if missing AND inserts questions in one script

-- ============================================
-- CREATE SURVEYS IF THEY DON'T EXIST
-- ============================================

-- Transportation Habits
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at)
SELECT 'Transportation Habits', 'How you move around Kenya', 'transport', 160, '4 min', 8, false, false, 0, NOW()
WHERE NOT EXISTS (SELECT 1 FROM surveys WHERE title = 'Transportation Habits');

-- Home and Living
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at)
SELECT 'Home and Living', 'Your living situation and preferences', 'lifestyle', 150, '4 min', 7, false, false, 0, NOW()
WHERE NOT EXISTS (SELECT 1 FROM surveys WHERE title = 'Home and Living');

-- ============================================
-- TRANSPORTATION HABITS - 8 QUESTIONS
-- ============================================

DO $$
DECLARE
    v_survey_id INTEGER;
BEGIN
    SELECT id INTO v_survey_id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1;
    
    IF v_survey_id IS NOT NULL THEN
        INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
        (v_survey_id, 'What is your main mode of transportation?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Personal car", "Walking"]', 1),
        (v_survey_id, 'How long is your daily commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 2),
        (v_survey_id, 'How much do you spend on transport daily?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 3),
        (v_survey_id, 'Do you use ride-hailing apps like Uber/Bolt?', 'single_choice', '["Daily", "Few times a week", "Occasionally", "Rarely", "Never"]', 4),
        (v_survey_id, 'What is your biggest transport challenge?', 'single_choice', '["Traffic jams", "High cost", "Unreliable matatus", "Safety concerns", "Long distances"]', 5),
        (v_survey_id, 'Would you use public transport more if improved?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably not", "No"]', 6),
        (v_survey_id, 'Do you own a personal vehicle?', 'single_choice', '["Yes, car", "Yes, motorcycle", "Planning to buy", "No, too expensive", "No, not needed"]', 7),
        (v_survey_id, 'How safe do you feel using boda bodas?', 'single_choice', '["Very safe", "Safe", "Neutral", "Unsafe", "Very unsafe"]', 8);
    END IF;
END $$;

-- ============================================
-- HOME AND LIVING - 7 QUESTIONS
-- ============================================

DO $$
DECLARE
    v_survey_id INTEGER;
BEGIN
    SELECT id INTO v_survey_id FROM surveys WHERE title = 'Home and Living' LIMIT 1;
    
    IF v_survey_id IS NOT NULL THEN
        INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
        (v_survey_id, 'What type of home do you live in?', 'single_choice', '["Rental apartment", "Owned apartment", "Rental house", "Owned house", "Family home"]', 1),
        (v_survey_id, 'How many people live in your household?', 'single_choice', '["Just me", "2 people", "3-4 people", "5-6 people", "More than 6"]', 2),
        (v_survey_id, 'How much do you pay for rent/month?', 'single_choice', '["Under KSH 5000", "KSH 5000-10000", "KSH 10000-20000", "KSH 20000-40000", "Over KSH 40000"]', 3),
        (v_survey_id, 'What utilities do you have at home?', 'single_choice', '["All (water, power, internet)", "Water and power only", "Power only", "Water only", "None/limited"]', 4),
        (v_survey_id, 'How satisfied are you with your living space?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 5),
        (v_survey_id, 'What would you improve about your home?', 'single_choice', '["More space", "Better location", "Lower rent", "Better security", "Modern amenities"]', 6),
        (v_survey_id, 'Do you plan to move in the next year?', 'single_choice', '["Yes, definitely", "Probably", "Not sure", "Probably not", "No, I am settled"]', 7);
    END IF;
END $$;

-- Verify the questions were added
SELECT 
    s.title,
    s.category,
    s.reward,
    COUNT(sq.id) as question_count
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE s.title IN ('Transportation Habits', 'Home and Living')
GROUP BY s.id, s.title, s.category, s.reward;
