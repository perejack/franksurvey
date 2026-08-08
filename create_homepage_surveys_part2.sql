-- Continue: Sports, Entertainment, and Finance Surveys

-- Sports & Fitness (8 questions) - KSH 180 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Sports & Fitness'), 'How often do you exercise?', 'single_choice', '["Daily", "Few times a week", "Once a week", "Few times a month", "Rarely/Never"]', 1),
(get_survey_id('Sports & Fitness'), 'What type of exercise do you prefer?', 'single_choice', '["Running/Jogging", "Gym/Weights", "Team sports", "Home workouts", "Outdoor activities"]', 2),
(get_survey_id('Sports & Fitness'), 'Do you follow any sports regularly?', 'single_choice', '["Yes, multiple sports", "Yes, one sport", "Occasionally", "Only major events", "Not at all"]', 3),
(get_survey_id('Sports & Fitness'), 'Which sport do you watch most?', 'single_choice', '["Football/Soccer", "Rugby", "Athletics", "Basketball", "Other"]', 4),
(get_survey_id('Sports & Fitness'), 'Do you have a gym membership?', 'single_choice', '["Yes, currently", "Had before", "Planning to get", "No, too expensive", "No, not interested"]', 5),
(get_survey_id('Sports & Fitness'), 'What prevents you from exercising more?', 'single_choice', '["Lack of time", "No facilities nearby", "Too expensive", "No motivation", "Health issues"]', 6),
(get_survey_id('Sports & Fitness'), 'How important is fitness to your lifestyle?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not very important", "Not important"]', 7),
(get_survey_id('Sports & Fitness'), 'Would you participate in local sports competitions?', 'single_choice', '["Yes, definitely", "Probably", "Not sure", "Probably not", "No"]', 8);

-- Premier League Fandom (7 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Premier League Fandom'), 'Do you watch Premier League matches?', 'single_choice', '["Every matchday", "Most weekends", "Occasionally", "Only big games", "Never"]', 1),
(get_survey_id('Premier League Fandom'), 'Which team do you support?', 'single_choice', '["Manchester United", "Liverpool", "Arsenal", "Chelsea", "Manchester City", "Other/None"]', 2),
(get_survey_id('Premier League Fandom'), 'How do you usually watch matches?', 'single_choice', '["TV at home", "Sports bar", "Streaming online", "Radio", "Match highlights only"]', 3),
(get_survey_id('Premier League Fandom'), 'Who is your favorite current player?', 'single_choice', '["Salah", "Saka", "Rashford", "De Bruyne", "Other"]', 4),
(get_survey_id('Premier League Fandom'), 'How long have you been following the Premier League?', 'single_choice', '["Over 10 years", "5-10 years", "2-5 years", "1-2 years", "Less than a year"]', 5),
(get_survey_id('Premier League Fandom'), 'Do you buy team merchandise?', 'single_choice', '["Yes, frequently", "Yes, occasionally", "Rarely", "Never, too expensive", "Never, not interested"]', 6),
(get_survey_id('Premier League Fandom'), 'Do you discuss matches with friends/family?', 'single_choice', '["Yes, always", "Yes, often", "Sometimes", "Rarely", "Never"]', 7);

-- Entertainment Preferences (6 questions) - KSH 160 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Entertainment Preferences'), 'What type of movies do you prefer?', 'single_choice', '["Action", "Comedy", "Drama", "Horror", "Documentary"]', 1),
(get_survey_id('Entertainment Preferences'), 'Which streaming platform do you use most?', 'single_choice', '["Netflix", "Showmax", "YouTube", "Amazon Prime", "None"]', 2),
(get_survey_id('Entertainment Preferences'), 'How do you prefer to listen to music?', 'single_choice', '["Spotify/Boomplay", "YouTube", "Radio", "Downloads", "I don''t listen to music much"]', 3),
(get_survey_id('Entertainment Preferences'), 'What do you do for fun on weekends?', 'single_choice', '["Watch movies/TV", "Go out with friends", "Read books", "Play games", "Outdoor activities"]', 4),
(get_survey_id('Entertainment Preferences'), 'Do you follow local Kenyan shows?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "Rarely", "Never", "What local shows?"]', 5),
(get_survey_id('Entertainment Preferences'), 'How many hours daily do you spend on entertainment?', 'single_choice', '["Less than 1 hour", "1-2 hours", "2-3 hours", "3-4 hours", "More than 4 hours"]', 6);

-- Financial Habits (10 questions) - KSH 220 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Financial Habits'), 'Do you have a monthly budget?', 'single_choice', '["Yes, detailed budget", "Yes, rough estimate", "I try to track", "No, but should", "No, not interested"]', 1),
(get_survey_id('Financial Habits'), 'How much do you save monthly (percentage)?', 'single_choice', '["Over 30%", "20-30%", "10-20%", "5-10%", "Nothing/I spend all"]', 2),
(get_survey_id('Financial Habits'), 'What do you use most for payments?', 'single_choice', '["M-Pesa", "Bank card", "Cash", "Bank transfer", "Other mobile money"]', 3),
(get_survey_id('Financial Habits'), 'Do you have any investments?', 'single_choice', '["Yes, multiple", "Yes, one type", "Planning to start", "No, don''t know how", "No money to invest"]', 4),
(get_survey_id('Financial Habits'), 'What is your biggest expense category?', 'single_choice', '["Rent/Housing", "Food", "Transport", "Utilities", "Entertainment"]', 5),
(get_survey_id('Financial Habits'), 'Do you have an emergency fund?', 'single_choice', '["Yes, 6+ months", "Yes, 3-6 months", "Yes, less than 3 months", "No, but saving", "No emergency fund"]', 6),
(get_survey_id('Financial Habits'), 'How do you track your spending?', 'single_choice', '["Mobile app", "Spreadsheet", "Notebook", "M-Pesa statements", "I don''t track"]', 7),
(get_survey_id('Financial Habits'), 'What is your biggest financial goal?', 'single_choice', '["Buy property", "Start business", "Travel", "Education", "Retirement savings"]', 8),
(get_survey_id('Financial Habits'), 'Have you taken a loan before?', 'single_choice', '["Yes, bank loan", "Yes, mobile app loan", "Yes, from friends/family", "No, never", "Currently paying one"]', 9),
(get_survey_id('Financial Habits'), 'How financially secure do you feel?', 'single_choice', '["Very secure", "Secure", "Somewhat secure", "Not very secure", "Not secure at all"]', 10);
