-- Create homepage surveys with proper categories and rewards
-- Part 1: Education surveys and questions

-- First, ensure category column exists
ALTER TABLE surveys ADD COLUMN IF NOT EXISTS category VARCHAR(50);

-- ============================================
-- INSERT SURVEYS (Homepage - Free, Not Locked)
-- ============================================

-- Education Surveys
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) VALUES
('Education Survey', 'Share your thoughts on the education system in Kenya', 'education', 200, '6 min', 9, false, false, 0, NOW()),
('Education Quality Review', 'Help us understand education quality in your area', 'education', 150, '5 min', 10, false, false, 0, NOW()),
('Online Learning Habits', 'Tell us about your online learning experiences', 'education', 150, '3 min', 8, false, false, 0, NOW());

-- ============================================
-- INSERT QUESTIONS FOR EDUCATION SURVEYS
-- ============================================

-- Education Survey (9 questions) - KSH 200 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What level of education have you completed?', 'single_choice', '["Primary", "Secondary", "Diploma", "Degree", "Postgraduate"]', 1
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Are you currently enrolled in any educational program?', 'single_choice', '["Yes, full-time", "Yes, part-time", "No, but planning to", "No"]', 2
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How do you rate the quality of education in Kenya?', 'single_choice', '["Excellent", "Good", "Average", "Poor", "Very Poor"]', 3
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What is the biggest challenge facing education today?', 'single_choice', '["Cost/Fees", "Quality of teaching", "Access to schools", "Learning materials", "Technology gap"]', 4
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Have you used online learning platforms?', 'single_choice', '["Yes, frequently", "Yes, sometimes", "Rarely", "Never"]', 5
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Which subject do you think needs more attention?', 'single_choice', '["Mathematics", "Science", "Languages", "Technology/ICT", "Arts"]', 6
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Would you recommend your school/university to others?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 7
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How important is education for success in Kenya?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not very important", "Not important"]', 8
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What would improve education quality most?', 'single_choice', '["Better teachers", "More funding", "Technology", "Infrastructure", "Curriculum reform"]', 9
FROM surveys WHERE title = 'Education Survey' LIMIT 1;

-- Education Quality Review (10 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How satisfied are you with current education quality?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 1
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do teachers have adequate resources?', 'single_choice', '["Yes, definitely", "Yes, mostly", "Sometimes", "Rarely", "Never"]', 2
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How often do students get practical experience?', 'single_choice', '["Very often", "Often", "Sometimes", "Rarely", "Never"]', 3
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Is the curriculum relevant to job market needs?', 'single_choice', '["Very relevant", "Somewhat relevant", "Neutral", "Not very relevant", "Not relevant"]', 4
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How would you rate school infrastructure?', 'single_choice', '["Excellent", "Good", "Fair", "Poor", "Very Poor"]', 5
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Are examination systems fair?', 'single_choice', '["Yes, very fair", "Mostly fair", "Neutral", "Somewhat unfair", "Very unfair"]', 6
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How accessible is quality education in your area?', 'single_choice', '["Very accessible", "Accessible", "Somewhat accessible", "Not very accessible", "Not accessible"]', 7
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do schools promote creativity enough?', 'single_choice', '["Yes, definitely", "Yes, somewhat", "Neutral", "Not really", "Not at all"]', 8
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How important are extra-curricular activities?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not important", "Not sure"]', 9
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Would you support more government funding for education?', 'single_choice', '["Strongly support", "Support", "Neutral", "Oppose", "Strongly oppose"]', 10
FROM surveys WHERE title = 'Education Quality Review' LIMIT 1;

-- Online Learning Habits (8 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Have you ever taken an online course?', 'single_choice', '["Yes, many", "Yes, a few", "Yes, one", "No, but interested", "No, not interested"]', 1
FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What platform do you use most for online learning?', 'single_choice', '["YouTube", "Coursera", "Udemy", "Zoom/Teams classes", "Other"]', 2
FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How do you prefer to learn online?', 'single_choice', '["Video lessons", "Live classes", "Reading materials", "Interactive quizzes", "All of above"]', 3
FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What is your biggest challenge with online learning?', 'single_choice', '["Internet connectivity", "Device access", "Time management", "Lack of interaction", "Self-discipline"]', 4
FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you think online learning is effective?', 'single_choice', '["Very effective", "Effective", "Neutral", "Not very effective", "Not effective"]', 5
FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How long can you focus during online learning?', 'single_choice', '["Less than 30 min", "30-60 min", "1-2 hours", "2-3 hours", "More than 3 hours"]', 6
FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Would you choose online over in-person classes?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 7
FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What would improve your online learning experience?', 'single_choice', '["Better internet", "More interactive content", "Lower costs", "Mobile-friendly platforms", "Certificates"]', 8
FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1;
