-- Transportation Habits and Home and Living questions

-- ============================================
-- TRANSPORTATION HABITS (8 questions) - KSH 160 total
-- ============================================

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What is your main mode of transportation?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Personal car", "Walking"]', 1
FROM surveys WHERE title = 'Transportation Habits';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How long is your daily commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 2
FROM surveys WHERE title = 'Transportation Habits';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How much do you spend on transport daily?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 3
FROM surveys WHERE title = 'Transportation Habits';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you use ride-hailing apps like Uber/Bolt?', 'single_choice', '["Daily", "Few times a week", "Occasionally", "Rarely", "Never"]', 4
FROM surveys WHERE title = 'Transportation Habits';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What is your biggest transport challenge?', 'single_choice', '["Traffic jams", "High cost", "Unreliable matatus", "Safety concerns", "Long distances"]', 5
FROM surveys WHERE title = 'Transportation Habits';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Would you use public transport more if improved?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably not", "No"]', 6
FROM surveys WHERE title = 'Transportation Habits';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you own a personal vehicle?', 'single_choice', '["Yes, car", "Yes, motorcycle", "Planning to buy", "No, too expensive", "No, not needed"]', 7
FROM surveys WHERE title = 'Transportation Habits';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How safe do you feel using boda bodas?', 'single_choice', '["Very safe", "Safe", "Neutral", "Unsafe", "Very unsafe"]', 8
FROM surveys WHERE title = 'Transportation Habits';

-- ============================================
-- HOME AND LIVING (7 questions) - KSH 150 total
-- ============================================

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What type of home do you live in?', 'single_choice', '["Rental apartment", "Owned apartment", "Rental house", "Owned house", "Family home"]', 1
FROM surveys WHERE title = 'Home and Living';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How many people live in your household?', 'single_choice', '["Just me", "2 people", "3-4 people", "5-6 people", "More than 6"]', 2
FROM surveys WHERE title = 'Home and Living';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How much do you pay for rent/month?', 'single_choice', '["Under KSH 5000", "KSH 5000-10000", "KSH 10000-20000", "KSH 20000-40000", "Over KSH 40000"]', 3
FROM surveys WHERE title = 'Home and Living';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What utilities do you have at home?', 'single_choice', '["All (water, power, internet)", "Water and power only", "Power only", "Water only", "None/limited"]', 4
FROM surveys WHERE title = 'Home and Living';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How satisfied are you with your living space?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 5
FROM surveys WHERE title = 'Home and Living';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What would you improve about your home?', 'single_choice', '["More space", "Better location", "Lower rent", "Better security", "Modern amenities"]', 6
FROM surveys WHERE title = 'Home and Living';

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you plan to move in the next year?', 'single_choice', '["Yes, definitely", "Probably", "Not sure", "Probably not", "No, I am settled"]', 7
FROM surveys WHERE title = 'Home and Living';
