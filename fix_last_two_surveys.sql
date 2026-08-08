-- Fix remaining surveys with no questions
-- Home & Living and Technology Adoption only

-- ============================================
-- HOME & LIVING - 7 questions, KSH 160
-- ID: 9f096760-e160-4ca3-b80a-cd8d281826ed
-- ============================================

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('9f096760-e160-4ca3-b80a-cd8d281826ed', 'What type of home do you live in?', 'single_choice', '["Rental apartment", "Owned apartment", "Rental house", "Owned house", "Family home"]', 1),
('9f096760-e160-4ca3-b80a-cd8d281826ed', 'How many people live in your household?', 'single_choice', '["Just me", "2 people", "3-4 people", "5-6 people", "More than 6"]', 2),
('9f096760-e160-4ca3-b80a-cd8d281826ed', 'How much do you pay for rent/month?', 'single_choice', '["Under KSH 5000", "KSH 5000-10000", "KSH 10000-20000", "KSH 20000-40000", "Over KSH 40000"]', 3),
('9f096760-e160-4ca3-b80a-cd8d281826ed', 'What utilities do you have at home?', 'single_choice', '["All (water, power, internet)", "Water and power only", "Power only", "Water only", "None/limited"]', 4),
('9f096760-e160-4ca3-b80a-cd8d281826ed', 'How satisfied are you with your living space?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 5),
('9f096760-e160-4ca3-b80a-cd8d281826ed', 'What would you improve about your home?', 'single_choice', '["More space", "Better location", "Lower rent", "Better security", "Modern amenities"]', 6),
('9f096760-e160-4ca3-b80a-cd8d281826ed', 'Do you plan to move in the next year?', 'single_choice', '["Yes, definitely", "Probably", "Not sure", "Probably not", "No, I am settled"]', 7);

-- ============================================
-- TECHNOLOGY ADOPTION - 9 questions, KSH 170
-- ID: e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f
-- ============================================

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'How comfortable are you with new technology?', 'single_choice', '["Very comfortable", "Comfortable", "Neutral", "Uncomfortable", "Very uncomfortable"]', 1),
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'What new technology interests you most?', 'single_choice', '["AI/Chatbots", "Virtual Reality", "Smart home devices", "Electric vehicles", "5G networks"]', 2),
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'Do you consider yourself an early adopter?', 'single_choice', '["Yes, always first", "Yes, usually early", "Wait for reviews", "Wait until mainstream", "Avoid new tech"]', 3),
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'What prevents you from adopting new tech?', 'single_choice', '["Cost", "Complexity", "Privacy concerns", "No need/interest", "Lack of skills"]', 4),
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'Have you used AI tools like ChatGPT?', 'single_choice', '["Use daily", "Use weekly", "Tried once", "Heard of it", "Never heard of it"]', 5),
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'How do you learn about new technology?', 'single_choice', '["Social media", "Friends/family", "News/TV", "Online courses", "I don''t actively learn"]', 6),
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'Would you buy a smart home device?', 'single_choice', '["Already have several", "Planning to buy", "Interested but unsure", "Too expensive", "Not interested"]', 7),
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'Do you think technology improves life?', 'single_choice', '["Significantly", "Somewhat", "Neutral", "Not really", "Makes it worse"]', 8),
('e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f', 'What tech skill would you like to learn?', 'single_choice', '["Coding/Programming", "Data analysis", "Digital marketing", "Graphic design", "Cybersecurity"]', 9);

-- Verify
SELECT 
    s.title,
    COUNT(sq.id) as question_count
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE s.id IN ('9f096760-e160-4ca3-b80a-cd8d281826ed', 'e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f')
GROUP BY s.id, s.title;
