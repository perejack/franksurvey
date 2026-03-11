-- Add questions to all surveys with 0 questions
-- Based on the user's survey list

-- ============================================
-- EDUCATION SURVEY (9b9c144b-b227-46d4-9211-41948053b53d) - 9 questions, KSH 200
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('9b9c144b-b227-46d4-9211-41948053b53d', 'What level of education have you completed?', 'single_choice', '["Primary", "Secondary", "Diploma", "Degree", "Postgraduate"]', 1),
('9b9c144b-b227-46d4-9211-41948053b53d', 'Are you currently enrolled in any educational program?', 'single_choice', '["Yes, full-time", "Yes, part-time", "No, but planning to", "No"]', 2),
('9b9c144b-b227-46d4-9211-41948053b53d', 'How do you rate the quality of education in Kenya?', 'single_choice', '["Excellent", "Good", "Average", "Poor", "Very Poor"]', 3),
('9b9c144b-b227-46d4-9211-41948053b53d', 'What is the biggest challenge facing education today?', 'single_choice', '["Cost/Fees", "Quality of teaching", "Access to schools", "Learning materials", "Technology gap"]', 4),
('9b9c144b-b227-46d4-9211-41948053b53d', 'Have you used online learning platforms?', 'single_choice', '["Yes, frequently", "Yes, sometimes", "Rarely", "Never"]', 5),
('9b9c144b-b227-46d4-9211-41948053b53d', 'Which subject do you think needs more attention?', 'single_choice', '["Mathematics", "Science", "Languages", "Technology/ICT", "Arts"]', 6),
('9b9c144b-b227-46d4-9211-41948053b53d', 'Would you recommend your school/university to others?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 7),
('9b9c144b-b227-46d4-9211-41948053b53d', 'How important is education for success in Kenya?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not very important", "Not important"]', 8),
('9b9c144b-b227-46d4-9211-41948053b53d', 'What would improve education quality most?', 'single_choice', '["Better teachers", "More funding", "Technology", "Infrastructure", "Curriculum reform"]', 9);

-- ============================================
-- BANKING SERVICES (2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12) - 8 questions, KSH 190
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Which bank do you primarily use?', 'single_choice', '["KCB", "Equity", "Cooperative", "Absa", "Other"]', 1),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'How often do you visit a bank branch?', 'single_choice', '["Weekly", "Monthly", "Few times a year", "Rarely", "Never"]', 2),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Do you use mobile banking apps?', 'single_choice', '["Daily", "Few times a week", "Weekly", "Rarely", "Never"]', 3),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'What banking service do you use most?', 'single_choice', '["Savings", "Loans", "Money transfer", "Bill payments", "Investment"]', 4),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Are you satisfied with your bank''s services?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 5),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'What frustrates you most about banking?', 'single_choice', '["Long queues", "High fees", "Poor customer service", "ATM issues", "App problems"]', 6),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'Have you taken a bank loan before?', 'single_choice', '["Yes, personal loan", "Yes, business loan", "Yes, multiple", "No, but considering", "No"]', 7),
('2795d8d7-b27a-4d05-8ddf-b5bbb2dd9e12', 'How do you prefer to receive bank notifications?', 'single_choice', '["SMS", "Email", "App push", "WhatsApp", "I don''t want notifications"]', 8);

-- ============================================
-- HEALTHCARE FEEDBACK (294109c8-3316-4565-91f6-8824fcd63bcf) - 10 questions, KSH 200
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('294109c8-3316-4565-91f6-8824fcd63bcf', 'When did you last visit a healthcare facility?', 'single_choice', '["Last week", "Last month", "2-3 months ago", "6 months ago", "Over a year"]', 1),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'How satisfied are you with healthcare services?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 2),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Do you have health insurance?', 'single_choice', '["Yes, NHIF", "Yes, private", "Yes, both", "No, planning to", "No"]', 3),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'What is your biggest healthcare concern?', 'single_choice', '["Cost", "Quality of care", "Long waiting times", "Doctor availability", "Drug shortages"]', 4),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'How far is your nearest hospital/clinic?', 'single_choice', '["Walking distance", "Under 5km", "5-10km", "10-20km", "Over 20km"]', 5),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Have you used telemedicine/virtual consultations?', 'single_choice', '["Yes, regularly", "Yes, once", "No, but interested", "No, don''t trust", "Never heard of it"]', 6),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'How do you rate medical staff professionalism?', 'single_choice', '["Excellent", "Good", "Fair", "Poor", "Very poor"]', 7),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Do you prefer public or private healthcare?', 'single_choice', '["Public - more affordable", "Private - better quality", "Both depending on need", "Only public", "Only private"]', 8),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'What would improve healthcare for you?', 'single_choice', '["Lower costs", "Shorter waits", "Better facilities", "More specialists", "24/7 services"]', 9),
('294109c8-3316-4565-91f6-8824fcd63bcf', 'Would you recommend your healthcare provider?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 10);

-- ============================================
-- HOME & LIVING (9f096760-e160-4ca3-b80a-cd8d281826ed) - 7 questions, KSH 160
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
-- SHOPPING HABITS SURVEY (472879ae-c8f3-473c-9330-a9dc9ac88070) - 8 questions, KSH 150
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Where do you shop most often?', 'single_choice', '["Supermarket", "Local market", "Online shops", "Small kiosks", "Wholesale shops"]', 1),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'How often do you go shopping?', 'single_choice', '["Daily", "Few times a week", "Once a week", "Few times a month", "Monthly or less"]', 2),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'What influences your buying decision most?', 'single_choice', '["Price", "Quality", "Brand reputation", "Recommendations", "Availability"]', 3),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Do you compare prices before buying?', 'single_choice', '["Always", "Often", "Sometimes", "Rarely", "Never"]', 4),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Which supermarket do you prefer?', 'single_choice', '["Naivas", "Quickmart", "Carrefour", "Chandarana", "Any local shop"]', 5),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Have you shopped online in the last month?', 'single_choice', '["Yes, multiple times", "Yes, once", "No, but planning to", "No, prefer physical", "No, don''t trust online"]', 6),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'What do you spend most on monthly?', 'single_choice', '["Food/Groceries", "Clothing", "Electronics", "Household items", "Personal care"]', 7),
('472879ae-c8f3-473c-9330-a9dc9ac88070', 'Do you wait for sales/discounts?', 'single_choice', '["Yes, always", "Yes, for big items", "Sometimes", "Rarely", "No, buy when needed"]', 8);

-- ============================================
-- TRAVEL PREFERENCES (42234473-09c0-4e7b-bc06-ee39f02d722e) - 7 questions, KSH 180
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'How often do you travel outside your city?', 'single_choice', '["Weekly", "Monthly", "Few times a year", "Once a year", "Rarely/Never"]', 1),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'What is your preferred mode of long-distance travel?', 'single_choice', '["Flight", "SGR train", "Bus", "Private car", "I don''t travel long distance"]', 2),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'Do you travel for leisure or work more?', 'single_choice', '["Only leisure", "Mostly leisure", "Both equally", "Mostly work", "Only work"]', 3),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'What is your biggest travel expense?', 'single_choice', '["Transport", "Accommodation", "Food", "Activities", "Shopping"]', 4),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'How do you book your travel?', 'single_choice', '["Online apps", "Travel agent", "Direct with company", "Through friends", "I don''t book myself"]', 5),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'What destination type do you prefer?', 'single_choice', '["Beach/Coastal", "Wildlife/Safari", "City/Urban", "Rural/Village", "International"]', 6),
('42234473-09c0-4e7b-bc06-ee39f02d722e', 'What would improve your travel experience?', 'single_choice', '["Lower costs", "Better transport", "More attractions", "Safer destinations", "Better hotels"]', 7);

-- ============================================
-- MOBILE APP USAGE (7a832f37-14a7-44ea-a238-42c196cf9e1f) - 6 questions, KSH 150
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'How many apps do you have installed?', 'single_choice', '["Less than 20", "20-40", "40-60", "60-80", "More than 80"]', 1),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'Which app do you use most daily?', 'single_choice', '["WhatsApp", "TikTok", "Instagram", "Facebook", "YouTube"]', 2),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'How much time do you spend on apps daily?', 'single_choice', '["Less than 1 hour", "1-2 hours", "2-4 hours", "4-6 hours", "More than 6 hours"]', 3),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'What type of apps do you use most?', 'single_choice', '["Social media", "Entertainment", "Productivity", "Finance", "Shopping"]', 4),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'Do you pay for any app subscriptions?', 'single_choice', '["Yes, multiple", "Yes, one", "Used to but cancelled", "No, but considering", "No, never"]', 5),
('7a832f37-14a7-44ea-a238-42c196cf9e1f', 'What frustrates you most about apps?', 'single_choice', '["Too many ads", "Battery drain", "Data usage", "Complex interface", "Privacy concerns"]', 6);

-- ============================================
-- TECHNOLOGY ADOPTION (e338ec4f-48e1-4d55-a28e-e23d9b7e6a3f) - 9 questions, KSH 170
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

-- ============================================
-- TRANSPORTATION HABITS (9f6ae800-ded7-44e5-a29b-3cc4cce9cc91) - 8 questions, KSH 160
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'What is your main mode of transportation?', 'single_choice', '["Matatu", "Bus", "Boda boda", "Personal car", "Walking"]', 1),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'How long is your daily commute?', 'single_choice', '["Under 15 min", "15-30 min", "30-60 min", "1-2 hours", "Over 2 hours"]', 2),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'How much do you spend on transport daily?', 'single_choice', '["Under KSH 100", "KSH 100-200", "KSH 200-500", "KSH 500-1000", "Over KSH 1000"]', 3),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'Do you use ride-hailing apps like Uber/Bolt?', 'single_choice', '["Daily", "Few times a week", "Occasionally", "Rarely", "Never"]', 4),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'What is your biggest transport challenge?', 'single_choice', '["Traffic jams", "High cost", "Unreliable matatus", "Safety concerns", "Long distances"]', 5),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'Would you use public transport more if improved?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably not", "No"]', 6),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'Do you own a personal vehicle?', 'single_choice', '["Yes, car", "Yes, motorcycle", "Planning to buy", "No, too expensive", "No, not needed"]', 7),
('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'How safe do you feel using boda bodas?', 'single_choice', '["Very safe", "Safe", "Neutral", "Unsafe", "Very unsafe"]', 8);
