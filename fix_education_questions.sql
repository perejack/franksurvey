-- Force insert questions for Education Quality Review and Online Learning Habits
-- Run this if surveys exist but have no questions

-- Education Quality Review (10 questions) - KSH 150
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'How satisfied are you with current education quality?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 1),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'Do teachers have adequate resources?', 'single_choice', '["Yes, definitely", "Yes, mostly", "Sometimes", "Rarely", "Never"]', 2),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'How often do students get practical experience?', 'single_choice', '["Very often", "Often", "Sometimes", "Rarely", "Never"]', 3),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'Is the curriculum relevant to job market needs?', 'single_choice', '["Very relevant", "Somewhat relevant", "Neutral", "Not very relevant", "Not relevant"]', 4),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'How would you rate school infrastructure?', 'single_choice', '["Excellent", "Good", "Fair", "Poor", "Very Poor"]', 5),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'Are examination systems fair?', 'single_choice', '["Yes, very fair", "Mostly fair", "Neutral", "Somewhat unfair", "Very unfair"]', 6),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'How accessible is quality education in your area?', 'single_choice', '["Very accessible", "Accessible", "Somewhat accessible", "Not very accessible", "Not accessible"]', 7),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'Do schools promote creativity enough?', 'single_choice', '["Yes, definitely", "Yes, somewhat", "Neutral", "Not really", "Not at all"]', 8),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'How important are extra-curricular activities?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not important", "Not sure"]', 9),
((SELECT id FROM surveys WHERE title = 'Education Quality Review' LIMIT 1), 'Would you support more government funding for education?', 'single_choice', '["Strongly support", "Support", "Neutral", "Oppose", "Strongly oppose"]', 10);

-- Online Learning Habits (8 questions) - KSH 150
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
((SELECT id FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1), 'Have you ever taken an online course?', 'single_choice', '["Yes, many", "Yes, a few", "Yes, one", "No, but interested", "No, not interested"]', 1),
((SELECT id FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1), 'What platform do you use most for online learning?', 'single_choice', '["YouTube", "Coursera", "Udemy", "Zoom/Teams classes", "Other"]', 2),
((SELECT id FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1), 'How do you prefer to learn online?', 'single_choice', '["Video lessons", "Live classes", "Reading materials", "Interactive quizzes", "All of above"]', 3),
((SELECT id FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1), 'What is your biggest challenge with online learning?', 'single_choice', '["Internet connectivity", "Device access", "Time management", "Lack of interaction", "Self-discipline"]', 4),
((SELECT id FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1), 'Do you think online learning is effective?', 'single_choice', '["Very effective", "Effective", "Neutral", "Not very effective", "Not effective"]', 5),
((SELECT id FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1), 'How long can you focus during online learning?', 'single_choice', '["Less than 30 min", "30-60 min", "1-2 hours", "2-3 hours", "More than 3 hours"]', 6),
((SELECT id FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1), 'Would you choose online over in-person classes?', 'single_choice', '["Definitely yes", "Probably yes", "Not sure", "Probably no", "Definitely no"]', 7),
((SELECT id FROM surveys WHERE title = 'Online Learning Habits' LIMIT 1), 'What would improve your online learning experience?', 'single_choice', '["Better internet", "More interactive content", "Lower costs", "Mobile-friendly platforms", "Certificates"]', 8);
