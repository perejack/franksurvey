-- Add missing surveys and their questions
-- Transportation and Home & Living surveys

-- ============================================
-- INSERT MISSING SURVEYS
-- ============================================

-- Transportation Survey
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) 
SELECT 'Transportation Habits', 'How you move around Kenya', 'transport', 160, '4 min', 8, false, false, 0, NOW()
WHERE NOT EXISTS (SELECT 1 FROM surveys WHERE title = 'Transportation Habits');

-- Home and Living Survey  
INSERT INTO surveys (title, description, category, reward, duration, questions_count, is_premium, is_locked, unlock_price, created_at) 
SELECT 'Home and Living', 'Your living situation and preferences', 'lifestyle', 150, '4 min', 7, false, false, 0, NOW()
WHERE NOT EXISTS (SELECT 1 FROM surveys WHERE title = 'Home and Living');

-- ============================================
-- QUESTIONS FOR EXISTING EDUCATION SURVEYS (if missing)
-- ============================================

-- Education Quality Review questions (if not present)
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How satisfied are you with current education quality?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 1
FROM surveys WHERE title = 'Education Quality Review' 
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id LIMIT 1);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do teachers have adequate resources?', 'single_choice', '["Yes, definitely", "Yes, mostly", "Sometimes", "Rarely", "Never"]', 2
FROM surveys WHERE title = 'Education Quality Review' 
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 2);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How often do students get practical experience?', 'single_choice', '["Very often", "Often", "Sometimes", "Rarely", "Never"]', 3
FROM surveys WHERE title = 'Education Quality Review'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 3);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Is the curriculum relevant to job market needs?', 'single_choice', '["Very relevant", "Somewhat relevant", "Neutral", "Not very relevant", "Not relevant"]', 4
FROM surveys WHERE title = 'Education Quality Review'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 4);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How would you rate school infrastructure?', 'single_choice', '["Excellent", "Good", "Fair", "Poor", "Very Poor"]', 5
FROM surveys WHERE title = 'Education Quality Review'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 5);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Are examination systems fair?', 'single_choice', '["Yes, very fair", "Mostly fair", "Neutral", "Somewhat unfair", "Very unfair"]', 6
FROM surveys WHERE title = 'Education Quality Review'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 6);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How accessible is quality education in your area?', 'single_choice', '["Very accessible", "Accessible", "Somewhat accessible", "Not very accessible", "Not accessible"]', 7
FROM surveys WHERE title = 'Education Quality Review'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 7);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do schools promote creativity enough?', 'single_choice', '["Yes, definitely", "Yes, somewhat", "Neutral", "Not really", "Not at all"]', 8
FROM surveys WHERE title = 'Education Quality Review'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 8);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How important are extra-curricular activities?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not important", "Not sure"]', 9
FROM surveys WHERE title = 'Education Quality Review'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 9);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Would you support more government funding for education?', 'single_choice', '["Strongly support", "Support", "Neutral", "Oppose", "Strongly oppose"]', 10
FROM surveys WHERE title = 'Education Quality Review'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 10);

-- Online Learning Habits questions (if not present)
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Have you ever taken an online course?', 'single_choice', '["Yes, many", "Yes, a few", "Yes, one", "No, but interested", "No, not interested"]', 1
FROM surveys WHERE title = 'Online Learning Habits'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id LIMIT 1);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What platform do you use most for online learning?', 'single_choice', '["YouTube", "Coursera", "Udemy", "Zoom/Teams classes", "Other"]', 2
FROM surveys WHERE title = 'Online Learning Habits'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 2);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How do you prefer to learn online?', 'single_choice', '["Video lessons", "Live classes", "Reading materials", "Interactive quizzes", "All of above"]', 3
FROM surveys WHERE title = 'Online Learning Habits'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 3);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What is your biggest challenge with online learning?', 'single_choice', '["Internet connectivity", "Device access", "Time management", "Lack of interaction", "Self-discipline"]', 4
FROM surveys WHERE title = 'Online Learning Habits'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 4);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you think online learning is effective?', 'single_choice', '["Very effective", "Effective", "Neutral", "Not very effective", "Not effective"]', 5
FROM surveys WHERE title = 'Online Learning Habits'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 5);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How long can you focus during online learning?', 'single_choice', '["Less than 30 min", "30-60 min", "1-2 hours", "2-3 hours", "More than 3 hours"]', 6
FROM surveys WHERE title = 'Online Learning Habits'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 6);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Would you choose online over in-person classes?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 7
FROM surveys WHERE title = 'Online Learning Habits'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 7);

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What would improve your online learning experience?', 'single_choice', '["Better internet", "More interactive content", "Lower costs", "Mobile-friendly platforms", "Certificates"]', 8
FROM surveys WHERE title = 'Online Learning Habits'
AND NOT EXISTS (SELECT 1 FROM survey_questions sq WHERE sq.survey_id = surveys.id AND order_number = 8);
