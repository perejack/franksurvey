-- DIRECT INSERT for Transportation and Home questions
-- Uses direct VALUES with subquery - no NOT EXISTS check

-- ============================================
-- TRANSPORTATION HABITS - 8 QUESTIONS
-- ============================================

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1), 'What is your main mode of transportation?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Personal car", "Walking"]', 1);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1), 'How long is your daily commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 2);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1), 'How much do you spend on transport daily?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 3);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1), 'Do you use ride-hailing apps like Uber/Bolt?', 'single_choice', '["Daily", "Few times a week", "Occasionally", "Rarely", "Never"]', 4);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1), 'What is your biggest transport challenge?', 'single_choice', '["Traffic jams", "High cost", "Unreliable matatus", "Safety concerns", "Long distances"]', 5);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1), 'Would you use public transport more if improved?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably not", "No"]', 6);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1), 'Do you own a personal vehicle?', 'single_choice', '["Yes, car", "Yes, motorcycle", "Planning to buy", "No, too expensive", "No, not needed"]', 7);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Transportation Habits' LIMIT 1), 'How safe do you feel using boda bodas?', 'single_choice', '["Very safe", "Safe", "Neutral", "Unsafe", "Very unsafe"]', 8);

-- ============================================
-- HOME AND LIVING - 7 QUESTIONS
-- ============================================

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Home and Living' LIMIT 1), 'What type of home do you live in?', 'single_choice', '["Rental apartment", "Owned apartment", "Rental house", "Owned house", "Family home"]', 1);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Home and Living' LIMIT 1), 'How many people live in your household?', 'single_choice', '["Just me", "2 people", "3-4 people", "5-6 people", "More than 6"]', 2);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Home and Living' LIMIT 1), 'How much do you pay for rent/month?', 'single_choice', '["Under KSH 5000", "KSH 5000-10000", "KSH 10000-20000", "KSH 20000-40000", "Over KSH 40000"]', 3);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Home and Living' LIMIT 1), 'What utilities do you have at home?', 'single_choice', '["All (water, power, internet)", "Water and power only", "Power only", "Water only", "None/limited"]', 4);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Home and Living' LIMIT 1), 'How satisfied are you with your living space?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 5);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Home and Living' LIMIT 1), 'What would you improve about your home?', 'single_choice', '["More space", "Better location", "Lower rent", "Better security", "Modern amenities"]', 6);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Home and Living' LIMIT 1), 'Do you plan to move in the next year?', 'single_choice', '["Yes, definitely", "Probably", "Not sure", "Probably not", "No, I am settled"]', 7);

-- Verify
SELECT s.title, COUNT(sq.id) as question_count
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE s.title IN ('Transportation Habits', 'Home and Living')
GROUP BY s.id, s.title;
