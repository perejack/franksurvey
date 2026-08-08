-- Add questions to remaining surveys with 0 questions
-- 7 surveys total

-- ============================================
-- 1. Education Survey (9b9c144b-b227-46d4-9211-41948053b53d) - 9 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('9b9c144b-b227-46d4-9211-41948053b53d', 'What level of education have you completed?', 'single_choice', '["Primary", "Secondary", "Diploma", "Degree", "Postgraduate"]', 1),
('9b9c144b-b227-46d4-9211-41948053b53d', 'Are you currently studying?', 'single_choice', '["Yes, full-time", "Yes, part-time", "No, but planning to", "No, finished", "No, dropped out"]', 2),
('9b9c144b-b227-46d4-9211-41948053b53d', 'What is your field of study?', 'single_choice', '["Business", "Technology", "Medicine", "Education", "Other"]', 3),
('9b9c144b-b227-46d4-9211-41948053b53d', 'How do you prefer to learn?', 'single_choice', '["Online", "In-person", "Hybrid", "Self-study", "Group study"]', 4),
('9b9c144b-b227-46d4-9211-41948053b53d', 'What challenges do you face in education?', 'single_choice', '["Cost", "Time", "Access", "Quality", "None"]', 5),
('9b9c144b-b227-46d4-9211-41948053b53d', 'Have you taken online courses?', 'single_choice', '["Yes, many", "Yes, few", "No, but interested", "No, not interested", "Never heard"]', 6),
('9b9c144b-b227-46d4-9211-41948053b53d', 'What skills would you like to learn?', 'single_choice', '["Coding", "Marketing", "Design", "Finance", "Languages"]', 7),
('9b9c144b-b227-46d4-9211-41948053b53d', 'How important is education to you?', 'single_choice', '["Very important", "Important", "Somewhat", "Not very", "Not at all"]', 8),
('9b9c144b-b227-46d4-9211-41948053b53d', 'Would you pursue further education?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 9);

-- ============================================
-- 2. Banking Services (2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12) - 8 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Which bank do you use?', 'single_choice', '["KCB", "Equity", "Cooperative", "Absa", "Other"]', 1),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'How often do you visit your bank?', 'single_choice', '["Weekly", "Monthly", "Few times a year", "Rarely", "Never"]', 2),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Do you use mobile banking?', 'single_choice', '["Yes, daily", "Yes, weekly", "Yes, monthly", "Rarely", "Never"]', 3),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'What banking service do you use most?', 'single_choice', '["Savings", "Loans", "Transfers", "Payments", "Investments"]', 4),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Are you satisfied with your bank?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 5),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'What frustrates you about banking?', 'single_choice', '["Long queues", "Fees", "Poor service", "App issues", "Nothing"]', 6),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Have you applied for a loan?', 'single_choice', '["Yes, approved", "Yes, rejected", "Yes, pending", "No, but planning", "No, never"]', 7),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Would you recommend your bank?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 8);

-- ============================================
-- 3. Healthcare Feedback (294109c8-3316-4565-91f6-8824fcd63bcf) - 10 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('294109c8-3316-4565-91f6-8824fcd63bcf', 'How often do you visit a doctor?', 'single_choice', '["Monthly", "Few times a year", "Yearly", "Only when sick", "Never"]', 1),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Where do you seek healthcare?', 'single_choice', '["Public hospital", "Private hospital", "Clinic", "Pharmacy", "Traditional healer"]', 2),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Do you have health insurance?', 'single_choice', '["Yes, NHIF", "Yes, private", "Yes, both", "No, but planning", "No"]', 3),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'How satisfied with healthcare quality?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 4),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'What is your biggest health concern?', 'single_choice', '["Cost", "Access", "Quality", "Wait times", "Medicine availability"]', 5),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Do you use private healthcare?', 'single_choice', '["Always", "Mostly", "Sometimes", "Rarely", "Never"]', 6),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'How much monthly on healthcare?', 'single_choice', '["Under KSH 1000", "KSH 1000-5000", "KSH 5000-10000", "KSH 10000-20000", "Over KSH 20000"]', 7),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Have you used telemedicine?', 'single_choice', '["Yes, regularly", "Yes, once", "No, but interested", "No, don''t trust", "Never heard"]', 8),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Do you get regular checkups?', 'single_choice', '["Yes, annually", "Yes, every 2 years", "Rarely", "Only when sick", "Never"]', 9),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Would you pay for better healthcare?', 'single_choice', '["Yes, definitely", "Yes, if affordable", "Maybe", "Probably not", "No, current is fine"]', 10);

-- ============================================
-- 4. Shopping Habits Survey (472879ae-c8f3-473c-9330-a9dc9ac88070) - 8 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'How often do you go shopping?', 'single_choice', '["Daily", "Weekly", "Monthly", "Few times a year", "Rarely"]', 1),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Where do you shop most?', 'single_choice', '["Supermarket", "Online", "Local market", "Mall", "Small shops"]', 2),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'What influences your purchases?', 'single_choice', '["Price", "Quality", "Brand", "Reviews", "Recommendations"]', 3),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Do you compare prices before buying?', 'single_choice', '["Always", "Usually", "Sometimes", "Rarely", "Never"]', 4),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'How much monthly on shopping?', 'single_choice', '["Under KSH 5000", "KSH 5000-10000", "KSH 10000-20000", "KSH 20000-50000", "Over KSH 50000"]', 5),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Do you shop online?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "Rarely", "Never tried", "Never will"]', 6),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'What payment method do you prefer?', 'single_choice', '["Cash", "M-Pesa", "Card", "Bank transfer", "Mobile app"]', 7),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Do you follow shopping trends?', 'single_choice', '["Always", "Often", "Sometimes", "Rarely", "Never"]', 8);

-- ============================================
-- 5. Travel Preferences (42234473-09c0-4e7b-bc06-ee39f02d722e) - 7 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'How often do you travel?', 'single_choice', '["Monthly", "Few times a year", "Yearly", "Rarely", "Never"]', 1),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'What is your preferred travel type?', 'single_choice', '["Local", "Domestic", "International", "Adventure", "Relaxation"]', 2),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'How do you usually travel?', 'single_choice', '["Flight", "Bus", "Train", "Car", "Boda"]', 3),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'How much spend on travel yearly?', 'single_choice', '["Under KSH 10000", "KSH 10000-50000", "KSH 50000-100000", "KSH 100000-500000", "Over KSH 500000"]', 4),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'Do you book travel online?', 'single_choice', '["Always", "Usually", "Sometimes", "Rarely", "Never"]', 5),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'What matters most when traveling?', 'single_choice', '["Cost", "Safety", "Comfort", "Destination", "Company"]', 6),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'Do you travel for business or leisure?', 'single_choice', '["Business only", "Mostly business", "Both equally", "Mostly leisure", "Leisure only"]', 7);

-- ============================================
-- 6. Mobile App Usage (7a832f37-14a7-44ea-a238-42c196cf9e1f) - 6 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'How many apps do you have?', 'single_choice', '["Less than 10", "10-20", "20-50", "50-100", "Over 100"]', 1),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'What type of apps do you use most?', 'single_choice', '["Social", "Gaming", "Productivity", "Shopping", "Finance"]', 2),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'How much daily on apps?', 'single_choice', '["Less than 1 hour", "1-2 hours", "2-3 hours", "3-5 hours", "Over 5 hours"]', 3),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'Do you pay for premium apps?', 'single_choice', '["Yes, many", "Yes, few", "No, but would", "No, free only", "Never"]', 4),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'What app feature matters most?', 'single_choice', '["Speed", "Design", "Features", "Security", "Free"]', 5),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'How often delete unused apps?', 'single_choice', '["Weekly", "Monthly", "Few times a year", "Rarely", "Never"]', 6);

-- ============================================
-- 7. Transportation Habits (9f6ae800-ded7-44e5-a29b-3cc4cce9cc91) - 8 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'What is your main transport mode?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Car", "Walking"]', 1),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'How much daily on transport?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 2),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'How long is your commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 3),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'Do you use ride-hailing apps?', 'single_choice', '["Daily", "Weekly", "Monthly", "Rarely", "Never"]', 4),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'What is your biggest transport issue?', 'single_choice', '["Cost", "Traffic", "Safety", "Availability", "Comfort"]', 5),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'Do you own a vehicle?', 'single_choice', '["Yes, car", "Yes, motorcycle", "Yes, both", "No, but planning", "No"]', 6),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'What time do you usually travel?', 'single_choice', '["Early morning", "Morning rush", "Midday", "Evening rush", "Night"]', 7),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'Would you use public transport more if improved?', 'single_choice', '["Definitely yes", "Probably yes", "Maybe", "Probably no", "Definitely no"]', 8);

-- Verify all surveys now have questions
SELECT 
    s.title,
    s.questions_count,
    COUNT(sq.id) as actual_questions
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE s.id IN (
    '9b9c144b-b227-46d4-9211-41948053b53d',
    '2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12',
    '294109c8-3316-4565-91f6-8824fcd63bcf',
    '472879ae-c8f3-473c-9330-a9dc9ac88070',
    '42234473-09c0-4e7b-bc06-ee39f02d722e',
    '7a832f37-14a7-44ea-a238-42c196cf9e1f',
    '9f6ae800-ded7-44e5-a29b-3cc4cce9cc91'
)
GROUP BY s.id, s.title, s.questions_count;
