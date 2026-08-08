-- Fix: Insert questions directly using the correct survey UUIDs
-- Transportation Habits: 99ff28a0-52b5-42bb-bc4d-f2052e780ee2
-- Home and Living: (need to get from console when you click it)

-- Transportation Habits - 8 questions
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'What is your main mode of transportation?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Personal car", "Walking"]', 1),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'How long is your daily commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 2),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'How much do you spend on transport daily?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 3),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'Do you use ride-hailing apps like Uber/Bolt?', 'single_choice', '["Daily", "Few times a week", "Occasionally", "Rarely", "Never"]', 4),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'What is your biggest transport challenge?', 'single_choice', '["Traffic jams", "High cost", "Unreliable matatus", "Safety concerns", "Long distances"]', 5),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'Would you use public transport more if improved?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably not", "No"]', 6),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'Do you own a personal vehicle?', 'single_choice', '["Yes, car", "Yes, motorcycle", "Planning to buy", "No, too expensive", "No, not needed"]', 7),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'How safe do you feel using boda bodas?', 'single_choice', '["Very safe", "Safe", "Neutral", "Unsafe", "Very unsafe"]', 8);

-- Also clean up duplicate questions that were inserted for wrong IDs
-- First find and delete duplicates
DELETE FROM survey_questions 
WHERE survey_id IN (
    SELECT id FROM surveys 
    WHERE title = 'Transportation Habits' 
    AND id != '99ff28a0-52b5-42bb-bc4d-f2052e780ee2'
);

-- Delete duplicates for Home and Living too (will add correct ones after you provide ID)
DELETE FROM survey_questions 
WHERE survey_id IN (
    SELECT id FROM surveys 
    WHERE title = 'Home and Living' 
    AND id NOT IN ('d1f581be-edbb-4b11-82b8-997ea0f2e9bb') -- keep the verified one
);

-- Verify
SELECT 'Transportation Habits' as survey, COUNT(*) as questions 
FROM survey_questions 
WHERE survey_id = '99ff28a0-52b5-42bb-bc4d-f2052e780ee2';
