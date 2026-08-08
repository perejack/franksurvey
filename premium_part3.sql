-- Part 3: Final premium surveys

-- ============================================
-- 11. WEEKEND ACTIVITIES (18ed52dc-a281-4c4a-ae66-8a8c49f843ea) - 5 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('18ed52dc-a281-4c4a-ae66-8a8c49f843ea', 'What do you usually do on weekends?', 'single_choice', '["Rest at home", "Visit friends/family", "Go out", "Work/Study", "Exercise"]', 1),
('18ed52dc-a281-4c4a-ae66-8a8c49f843ea', 'How much spend on weekend activities?', 'single_choice', '["Under KSH 500", "KSH 500-1000", "KSH 1000-2000", "KSH 2000-5000", "Over KSH 5000"]', 2),
('18ed52dc-a281-4c4a-ae66-8a8c49f843ea', 'Do you prefer staying home or going out?', 'single_choice', '["Always home", "Mostly home", "Both equally", "Mostly out", "Always out"]', 3),
('18ed52dc-a281-4c4a-ae66-8a8c49f843ea', 'Who do you spend weekends with?', 'single_choice', '["Alone", "Family", "Friends", "Partner", "Varies"]', 4),
('18ed52dc-a281-4c4a-ae66-8a8c49f843ea', 'What is your ideal weekend?', 'single_choice', '["Sleeping in", "Outdoor activities", "Social events", "Hobbies", "Travel"]', 5);

-- ============================================
-- 12. M-PESA USAGE SURVEY (4251a288-6f9e-41dd-bed9-b2d324bbd882) - 6 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('4251a288-6f9e-41dd-bed9-b2d324bbd882', 'When did you start using M-Pesa?', 'single_choice', '["Over 10 years ago", "5-10 years", "3-5 years", "1-3 years", "Less than 1 year"]', 1),
('4251a288-6f9e-41dd-bed9-b2d324bbd882', 'What is your favorite M-Pesa feature?', 'single_choice', '["Send money", "Withdraw", "Pay bills", "Buy airtime", "Fuliza"]', 2),
('4251a288-6f9e-41dd-bed9-b2d324bbd882', 'How much daily on M-Pesa transactions?', 'single_choice', '["Under KSH 100", "KSH 100-500", "KSH 500-1000", "KSH 1000-5000", "Over KSH 5000"]', 3),
('4251a288-6f9e-41dd-bed9-b2d324bbd882', 'Do you use M-Pesa for business?', 'single_choice', '["Yes, main payment", "Yes, sometimes", "No, personal only", "No, but considering", "No business"]', 4),
('4251a288-6f9e-41dd-bed9-b2d324bbd882', 'Have you had issues with M-Pesa?', 'single_choice', '["Many times", "Few times", "Rarely", "Never", "Don''t use much"]', 5),
('4251a288-6f9e-41dd-bed9-b2d324bbd882', 'Would you switch to another service?', 'single_choice', '["Yes, immediately", "Yes, if better", "Maybe", "Probably not", "Never"]', 6);

-- ============================================
-- 13. MOBILE BANKING HABITS (13d8e9c1-a669-42b6-a45c-c1ab718dd26e) - 6 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('13d8e9c1-a669-42b6-a45c-c1ab718dd26e', 'Which mobile banking app do you use?', 'single_choice', '["KCB", "Equity", "Coop", "Absa", "I don''t use"]', 1),
('13d8e9c1-a669-42b6-a45c-c1ab718dd26e', 'How often use mobile banking?', 'single_choice', '["Daily", "Few times a week", "Weekly", "Monthly", "Rarely"]', 2),
('13d8e9c1-a669-42b6-a45c-c1ab718dd26e', 'What do you use it for most?', 'single_choice', '["Check balance", "Transfer", "Pay bills", "Buy airtime", "Apply for loans"]', 3),
('13d8e9c1-a669-42b6-a45c-c1ab718dd26e', 'How satisfied with the app?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 4),
('13d8e9c1-a669-42b6-a45c-c1ab718dd26e', 'Have you had security issues?', 'single_choice', '["Yes, fraud", "Yes, login issues", "No, but worried", "No, feels safe", "Don''t use"]', 5),
('13d8e9c1-a669-42b6-a45c-c1ab718dd26e', 'What feature would you add?', 'single_choice', '["Better UI", "Lower fees", "More services", "Faster loading", "Nothing"]', 6);

-- ============================================
-- 14. PREMIUM TECH REVIEW (2659017a-2191-4219-9991-193f0b0d4269) - 15 questions
-- ============================================
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
('2659017a-2191-4219-9991-193f0b0d4269', 'What is your primary tech device?', 'single_choice', '["Smartphone", "Laptop", "Tablet", "Desktop", "Smart TV"]', 1),
('2659017a-2191-4219-9991-193f0b0d4269', 'How much did your most expensive device cost?', 'single_choice', '["Under KSH 10000", "KSH 10000-30000", "KSH 30000-50000", "KSH 50000-100000", "Over KSH 100000"]', 2),
('2659017a-2191-4219-9991-193f0b0d4269', 'Do you research before buying tech?', 'single_choice', '["Extensively", "Somewhat", "Read reviews", "Ask friends", "Impulse buy"]', 3),
('2659017a-2191-4219-9991-193f0b0d4269', 'What brand do you trust most?', 'single_choice', '["Apple", "Samsung", "Sony", "Huawei", "Local brands"]', 4),
('2659017a-2191-4219-9991-193f0b0d4269', 'How often upgrade devices?', 'single_choice', '["Every year", "Every 2 years", "Every 3-4 years", "Until broken", "Rarely"]', 5),
('2659017a-2191-4219-9991-193f0b0d4269', 'Do you own smart home devices?', 'single_choice', '["Many", "Few", "Planning", "No, expensive", "Not interested"]', 6),
('2659017a-2191-4219-9991-193f0b0d4269', 'What tech trend excites you?', 'single_choice', '["AI", "VR/AR", "5G", "Electric vehicles", "Blockchain"]', 7),
('2659017a-2191-4219-9991-193f0b0d4269', 'How do you protect your devices?', 'single_choice', '["Insurance", "Cases/screen guards", "Security apps", "Nothing", "Don''t worry"]', 8),
('2659017a-2191-4219-9991-193f0b0d4269', 'Have you bought refurbished tech?', 'single_choice', '["Yes, regularly", "Yes, once", "No, but would", "No, don''t trust", "Didn''t know"]', 9),
('2659017a-2191-4219-9991-193f0b0d4269', 'What frustrates you about tech?', 'single_choice', '["Battery life", "Price", "Complexity", "Updates", "Nothing"]', 10),
('2659017a-2191-4219-9991-193f0b0d4269', 'Do you use cloud storage?', 'single_choice', '["Yes, multiple", "Yes, one", "No, but interested", "No, privacy concerns", "Don''t know"]', 11),
('2659017a-2191-4219-9991-193f0b0d4269', 'How do you learn new tech?', 'single_choice', '["YouTube", "Courses", "Friends", "Manuals", "Trial/error"]', 12),
('2659017a-2191-4219-9991-193f0b0d4269', 'Would you pay for premium tech support?', 'single_choice', '["Yes, definitely", "Yes, if needed", "Maybe", "No, too expensive", "No, DIY"]', 13),
('2659017a-2191-4219-9991-193f0b0d4269', 'What is your next tech purchase?', 'single_choice', '["Phone", "Laptop", "TV", "Smart watch", "None planned"]', 14),
('2659017a-2191-4219-9991-193f0b0d4269', 'How important is tech in your life?', 'single_choice', '["Essential", "Very important", "Somewhat", "Not very", "Could live without"]', 15);

-- Verify all premium surveys now have questions
SELECT 
    s.title,
    COUNT(sq.id) as actual_questions
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE s.is_locked = true OR s.is_premium = true
GROUP BY s.id, s.title
ORDER BY s.title;
