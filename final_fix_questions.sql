-- Insert questions for the CORRECT survey UUIDs
-- Transportation Habits: 99ff28a0-52b5-42bb-bc4d-f2052e780ee2
-- Home and Living: f6beb6b2-d460-4a85-861b-d0fa4957e615

-- ============================================
-- TRANSPORTATION HABITS - 8 QUESTIONS (KSH 160)
-- ============================================

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'What is your main mode of transportation?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Personal car", "Walking"]', 1),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'How long is your daily commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 2),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'How much do you spend on transport daily?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 3),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'Do you use ride-hailing apps like Uber/Bolt?', 'single_choice', '["Daily", "Few times a week", "Occasionally", "Rarely", "Never"]', 4),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'What is your biggest transport challenge?', 'single_choice', '["Traffic jams", "High cost", "Unreliable matatus", "Safety concerns", "Long distances"]', 5),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'Would you use public transport more if improved?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably not", "No"]', 6),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'Do you own a personal vehicle?', 'single_choice', '["Yes, car", "Yes, motorcycle", "Planning to buy", "No, too expensive", "No, not needed"]', 7),
('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'How safe do you feel using boda bodas?', 'single_choice', '["Very safe", "Safe", "Neutral", "Unsafe", "Very unsafe"]', 8);

-- ============================================
-- HOME AND LIVING - 7 QUESTIONS (KSH 150)
-- ============================================

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('f6beb6b2-d460-4a85-861b-d0fa4957e615', 'What type of home do you live in?', 'single_choice', '["Rental apartment", "Owned apartment", "Rental house", "Owned house", "Family home"]', 1),
('f6beb6b2-d460-4a85-861b-d0fa4957e615', 'How many people live in your household?', 'single_choice', '["Just me", "2 people", "3-4 people", "5-6 people", "More than 6"]', 2),
('f6beb6b2-d460-4a85-861b-d0fa4957e615', 'How much do you pay for rent/month?', 'single_choice', '["Under KSH 5000", "KSH 5000-10000", "KSH 10000-20000", "KSH 20000-40000", "Over KSH 40000"]', 3),
('f6beb6b2-d460-4a85-861b-d0fa4957e615', 'What utilities do you have at home?', 'single_choice', '["All (water, power, internet)", "Water and power only", "Power only", "Water only", "None/limited"]', 4),
('f6beb6b2-d460-4a85-861b-d0fa4957e615', 'How satisfied are you with your living space?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 5),
('f6beb6b2-d460-4a85-861b-d0fa4957e615', 'What would you improve about your home?', 'single_choice', '["More space", "Better location", "Lower rent", "Better security", "Modern amenities"]', 6),
('f6beb6b2-d460-4a85-861b-d0fa4957e615', 'Do you plan to move in the next year?', 'single_choice', '["Yes, definitely", "Probably", "Not sure", "Probably not", "No, I am settled"]', 7);

-- Verify both surveys now have questions
SELECT 
    s.title,
    s.id,
    COUNT(sq.id) as question_count
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE s.id IN ('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'f6beb6b2-d460-4a85-861b-d0fa4957e615')
GROUP BY s.id, s.title;
