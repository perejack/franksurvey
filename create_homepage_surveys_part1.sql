-- Create homepage surveys with proper categories and rewards
-- Then insert questions for each survey

-- First, ensure category column exists
ALTER TABLE surveys ADD COLUMN IF NOT EXISTS category VARCHAR(50);

-- Create a helper function to get survey ID by title
CREATE OR REPLACE FUNCTION get_survey_id(p_title TEXT) RETURNS INTEGER AS $$
DECLARE
    v_id INTEGER;
BEGIN
    SELECT id INTO v_id FROM surveys WHERE title = p_title ORDER BY created_at DESC LIMIT 1;
    RETURN v_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- INSERT SURVEYS (Homepage - Free, Not Locked)
-- ============================================

-- Education Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Education Survey', 'Share your thoughts on the education system in Kenya', 'education', 200, '6 min', 9, false, false, 0, NOW()),
('Education Quality Review', 'Help us understand education quality in your area', 'education', 150, '5 min', 10, false, false, 0, NOW()),
('Online Learning Habits', 'Tell us about your online learning experiences', 'education', 150, '3 min', 8, false, false, 0, NOW());

-- Sports Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Sports & Fitness', 'Share your fitness routine and sports interests', 'sports', 180, '5 min', 8, false, false, 0, NOW()),
('Premier League Fandom', 'Which Premier League team do you support?', 'sports', 150, '3 min', 7, false, false, 0, NOW());

-- Entertainment Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Entertainment Preferences', 'What do you watch and listen to for fun?', 'entertainment', 160, '4 min', 6, false, false, 0, NOW());

-- Finance Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Financial Habits', 'Share your saving and spending habits', 'finance', 220, '7 min', 10, false, false, 0, NOW());

-- Lifestyle Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Shopping Habits in Kenya', 'Tell us about your shopping preferences', 'lifestyle', 150, '3 min', 8, false, false, 0, NOW());

-- Tech Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Mobile App Usage Survey', 'Which apps do you use daily on your phone?', 'tech', 150, '5 min', 10, false, false, 0, NOW()),
('Social Media Trends', 'How do you use social media platforms?', 'tech', 150, '3 min', 8, false, false, 0, NOW());

-- Food Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Favourite Kenyan Foods', 'Share your favorite local dishes', 'food', 150, '2 min', 6, false, false, 0, NOW()),
('Food & Dining', 'Tell us about your dining habits', 'food', 170, '5 min', 7, false, false, 0, NOW());

-- Health Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Healthcare Access Survey', 'Share your experience with healthcare services', 'health', 150, '6 min', 12, false, false, 0, NOW());

-- ============================================
-- INSERT QUESTIONS FOR EACH SURVEY
-- ============================================

-- Education Survey (9 questions) - KSH 200 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Education Survey'), 'What level of education have you completed?', 'single_choice', '["Primary", "Secondary", "Diploma", "Degree", "Postgraduate"]', 1),
(get_survey_id('Education Survey'), 'Are you currently enrolled in any educational program?', 'single_choice', '["Yes, full-time", "Yes, part-time", "No, but planning to", "No"]', 2),
(get_survey_id('Education Survey'), 'How do you rate the quality of education in Kenya?', 'single_choice', '["Excellent", "Good", "Average", "Poor", "Very Poor"]', 3),
(get_survey_id('Education Survey'), 'What is the biggest challenge facing education today?', 'single_choice', '["Cost/Fees", "Quality of teaching", "Access to schools", "Learning materials", "Technology gap"]', 4),
(get_survey_id('Education Survey'), 'Have you used online learning platforms?', 'single_choice', '["Yes, frequently", "Yes, sometimes", "Rarely", "Never"]', 5),
(get_survey_id('Education Survey'), 'Which subject do you think needs more attention?', 'single_choice', '["Mathematics", "Science", "Languages", "Technology/ICT", "Arts"]', 6),
(get_survey_id('Education Survey'), 'Would you recommend your school/university to others?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 7),
(get_survey_id('Education Survey'), 'How important is education for success in Kenya?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not very important", "Not important"]', 8),
(get_survey_id('Education Survey'), 'What would improve education quality most?', 'single_choice', '["Better teachers", "More funding", "Technology", "Infrastructure", "Curriculum reform"]', 9);

-- Education Quality Review (10 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Education Quality Review'), 'How satisfied are you with current education quality?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 1),
(get_survey_id('Education Quality Review'), 'Do teachers have adequate resources?', 'single_choice', '["Yes, definitely", "Yes, mostly", "Sometimes", "Rarely", "Never"]', 2),
(get_survey_id('Education Quality Review'), 'How often do students get practical experience?', 'single_choice', '["Very often", "Often", "Sometimes", "Rarely", "Never"]', 3),
(get_survey_id('Education Quality Review'), 'Is the curriculum relevant to job market needs?', 'single_choice', '["Very relevant", "Somewhat relevant", "Neutral", "Not very relevant", "Not relevant"]', 4),
(get_survey_id('Education Quality Review'), 'How would you rate school infrastructure?', 'single_choice', '["Excellent", "Good", "Fair", "Poor", "Very Poor"]', 5),
(get_survey_id('Education Quality Review'), 'Are examination systems fair?', 'single_choice', '["Yes, very fair", "Mostly fair", "Neutral", "Somewhat unfair", "Very unfair"]', 6),
(get_survey_id('Education Quality Review'), 'How accessible is quality education in your area?', 'single_choice', '["Very accessible", "Accessible", "Somewhat accessible", "Not very accessible", "Not accessible"]', 7),
(get_survey_id('Education Quality Review'), 'Do schools promote creativity enough?', 'single_choice', '["Yes, definitely", "Yes, somewhat", "Neutral", "Not really", "Not at all"]', 8),
(get_survey_id('Education Quality Review'), 'How important are extra-curricular activities?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not important", "Not sure"]', 9),
(get_survey_id('Education Quality Review'), 'Would you support more government funding for education?', 'single_choice', '["Strongly support", "Support", "Neutral", "Oppose", "Strongly oppose"]', 10);

-- Online Learning Habits (8 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Online Learning Habits'), 'Have you ever taken an online course?', 'single_choice', '["Yes, many", "Yes, a few", "Yes, one", "No, but interested", "No, not interested"]', 1),
(get_survey_id('Online Learning Habits'), 'What platform do you use most for online learning?', 'single_choice', '["YouTube", "Coursera", "Udemy", "Zoom/Teams classes", "Other"]', 2),
(get_survey_id('Online Learning Habits'), 'How do you prefer to learn online?', 'single_choice', '["Video lessons", "Live classes", "Reading materials", "Interactive quizzes", "All of above"]', 3),
(get_survey_id('Online Learning Habits'), 'What is your biggest challenge with online learning?', 'single_choice', '["Internet connectivity", "Device access", "Time management", "Lack of interaction", "Self-discipline"]', 4),
(get_survey_id('Online Learning Habits'), 'Do you think online learning is effective?', 'single_choice', '["Very effective", "Effective", "Neutral", "Not very effective", "Not effective"]', 5),
(get_survey_id('Online Learning Habits'), 'How long can you focus during online learning?', 'single_choice', '["Less than 30 min", "30-60 min", "1-2 hours", "2-3 hours", "More than 3 hours"]', 6),
(get_survey_id('Online Learning Habits'), 'Would you choose online over in-person classes?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 7),
(get_survey_id('Online Learning Habits'), 'What would improve your online learning experience?', 'single_choice', '["Better internet", "More interactive content", "Lower costs", "Mobile-friendly platforms", "Certificates"]', 8);
