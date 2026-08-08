-- Part 2: Remaining premium surveys

-- ============================================
-- 6. INVESTMENT SURVEY (29965cc2-20e2-416e-bd7a-3b1be16eda19) - 12 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'Do you currently have any investments?', 'single_choice', '["Yes, multiple", "Yes, one type", "No, planning to", "No, too risky", "No, no money"]', 1),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'What is your primary investment?', 'single_choice', '["Land/Property", "Stocks", "SACCO", "Business", "None"]', 2),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'How long have you been investing?', 'single_choice', '["Less than 1 year", "1-3 years", "3-5 years", "5-10 years", "Over 10 years"]', 3),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'What is your monthly investment amount?', 'single_choice', '["Under KSH 1000", "KSH 1000-5000", "KSH 5000-10000", "KSH 10000-50000", "Over KSH 50000"]', 4),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'Who advised you on investments?', 'single_choice', '["Financial advisor", "Family/Friends", "Online research", "Bank", "Self-taught"]', 5),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'Are your investments performing well?', 'single_choice', '["Very well", "Well", "Average", "Poorly", "Very poorly"]', 6),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'Do you reinvest your profits?', 'single_choice', '["Always", "Usually", "Sometimes", "Rarely", "Never"]', 7),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'What is your biggest investment fear?', 'single_choice', '["Losing everything", "Scams", "Market crash", "Inflation", "Liquidity issues"]', 8),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'Have you sold investments recently?', 'single_choice', '["Yes, for profit", "Yes, for loss", "Yes, needed cash", "No, holding", "Never invested"]', 9),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'Do you track your portfolio?', 'single_choice', '["Daily", "Weekly", "Monthly", "Rarely", "Never"]', 10),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'Would you recommend investing to others?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 11),
('29965cc2-20e2-416e-bd7a-3b1be16eda19', 'What investment education do you want?', 'single_choice', '["Basics for beginners", "Advanced strategies", "Risk management", "Market analysis", "No need"]', 12);

-- ============================================
-- 7. M-PESA USAGE PATTERNS (963f64c9-d108-4cb9-8a4f-c40a38f59202) - 8 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('963f64c9-d108-4cb9-8a4f-c40a38f59202', 'How often do you use M-Pesa?', 'single_choice', '["Multiple times daily", "Daily", "Few times a week", "Weekly", "Rarely"]', 1),
('963f64c9-d108-4cb9-8a4f-c40a38f59202', 'What do you use M-Pesa for most?', 'single_choice', '["Send money", "Receive money", "Pay bills", "Buy goods", "Withdraw cash"]', 2),
('963f64c9-d108-4cb9-8a4f-c40a38f59202', 'How much monthly through M-Pesa?', 'single_choice', '["Under KSH 1000", "KSH 1000-5000", "KSH 5000-10000", "KSH 10000-50000", "Over KSH 50000"]', 3),
('963f64c9-d108-4cb9-8a4f-c40a38f59202', 'Do you use M-Pesa app or USSD?', 'single_choice', '["App only", "Mostly app", "Both equally", "Mostly USSD", "USSD only"]', 4),
('963f64c9-d108-4cb9-8a4f-c40a38f59202', 'Have you tried M-Pesa Global?', 'single_choice', '["Use regularly", "Tried once", "No, but interested", "No, don''t need", "Never heard of it"]', 5),
('963f64c9-d108-4cb9-8a4f-c40a38f59202', 'What frustrates you about M-Pesa?', 'single_choice', '["Transaction fees", "Network issues", "Agent availability", "Limits", "No issues"]', 6),
('963f64c9-d108-4cb9-8a4f-c40a38f59202', 'Do you use M-Pesa for savings?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "No, but interested", "No, use bank", "No savings"]', 7),
('963f64c9-d108-4cb9-8a4f-c40a38f59202', 'Would you recommend M-Pesa?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 8);

-- ============================================
-- 8. FITNESS & WELLNESS (ccb131ac-9997-4476-83a3-a23c69c38174) - 10 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('ccb131ac-9997-4476-83a3-a23c69c38174', 'How often do you exercise?', 'single_choice', '["Daily", "Few times a week", "Weekly", "Monthly", "Rarely/Never"]', 1),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'What exercise do you prefer?', 'single_choice', '["Running/Jogging", "Gym/Weights", "Sports", "Yoga", "Walking"]', 2),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'How many hours weekly on fitness?', 'single_choice', '["Less than 1 hour", "1-3 hours", "3-5 hours", "5-10 hours", "Over 10 hours"]', 3),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'Do you have a gym membership?', 'single_choice', '["Yes, active", "Yes, but not using", "No, home workout", "No, outdoor only", "No, don''t exercise"]', 4),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'What is your main fitness goal?', 'single_choice', '["Weight loss", "Muscle gain", "General health", "Stress relief", "Athletic performance"]', 5),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'How do you track your fitness?', 'single_choice', '["Fitness app", "Smartwatch", "Journal", "Mental tracking", "Don''t track"]', 6),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'What prevents you from exercising?', 'single_choice', '["No time", "Too expensive", "No motivation", "No facilities", "Health issues"]', 7),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'Do you follow a diet plan?', 'single_choice', '["Strict diet", "Loose diet", "Eat healthy", "No plan", "Don''t care"]', 8),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'How important is mental wellness?', 'single_choice', '["Very important", "Important", "Somewhat", "Not very", "Not at all"]', 9),
('ccb131ac-9997-4476-83a3-a23c69c38174', 'Do you use wellness apps?', 'single_choice', '["Yes, multiple", "Yes, one", "No, but interested", "No, not interested", "Never heard"]', 10);

-- ============================================
-- 9. FOOD & EATING HABITS (9fa53d26-4ee5-41d1-9555-f6afadf3cdfe) - 5 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('9fa53d26-4ee5-41d1-9555-f6afadf3cdfe', 'How many meals daily?', 'single_choice', '["1 meal", "2 meals", "3 meals", "3+ snacks", "Irregular"]', 1),
('9fa53d26-4ee5-41d1-9555-f6afadf3cdfe', 'Do you cook at home or eat out?', 'single_choice', '["Always cook", "Mostly cook", "Half/Half", "Mostly eat out", "Always eat out"]', 2),
('9fa53d26-4ee5-41d1-9555-f6afadf3cdfe', 'What cuisine do you prefer?', 'single_choice', '["Kenyan", "Indian", "Chinese", "Western", "Mixed"]', 3),
('9fa53d26-4ee5-41d1-9555-f6afadf3cdfe', 'How much daily on food?', 'single_choice', '["Under KSH 200", "KSH 200-500", "KSH 500-1000", "KSH 1000-2000", "Over KSH 2000"]', 4),
('9fa53d26-4ee5-41d1-9555-f6afadf3cdfe', 'Do you follow any diet?', 'single_choice', '["Vegetarian", "Vegan", "Keto", "Religious", "No diet"]', 5);

-- ============================================
-- 10. SHOPPING PREFERENCES (63725c84-b68d-4ba3-ab1e-315506ea949a) - 5 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('63725c84-b68d-4ba3-ab1e-315506ea949a', 'Where do you shop most?', 'single_choice', '["Supermarket", "Online", "Local market", "Mall", "Small shops"]', 1),
('63725c84-b68d-4ba3-ab1e-315506ea949a', 'How often do you shop?', 'single_choice', '["Daily", "Weekly", "Monthly", "Few times a year", "Rarely"]', 2),
('63725c84-b68d-4ba3-ab1e-315506ea949a', 'What matters most when shopping?', 'single_choice', '["Price", "Quality", "Brand", "Location", "Variety"]', 3),
('63725c84-b68d-4ba3-ab1e-315506ea949a', 'Do you shop online?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "Rarely", "Never tried", "Never will"]', 4),
('63725c84-b68d-4ba3-ab1e-315506ea949a', 'How much monthly on shopping?', 'single_choice', '["Under KSH 1000", "KSH 1000-5000", "KSH 5000-10000", "KSH 10000-20000", "Over KSH 20000"]', 5);

-- Continue in part 3
