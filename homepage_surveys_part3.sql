-- Part 3: Lifestyle, Tech, Food, and Health Surveys

-- Shopping Habits in Kenya (8 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Where do you shop most often?', 'single_choice', '["Supermarket", "Local market", "Online shops", "Small kiosks", "Wholesale shops"]', 1
FROM surveys WHERE title = 'Shopping Habits in Kenya' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How often do you go shopping?', 'single_choice', '["Daily", "Few times a week", "Once a week", "Few times a month", "Monthly or less"]', 2
FROM surveys WHERE title = 'Shopping Habits in Kenya' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What influences your buying decision most?', 'single_choice', '["Price", "Quality", "Brand reputation", "Recommendations", "Availability"]', 3
FROM surveys WHERE title = 'Shopping Habits in Kenya' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you compare prices before buying?', 'single_choice', '["Always", "Often", "Sometimes", "Rarely", "Never"]', 4
FROM surveys WHERE title = 'Shopping Habits in Kenya' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Which supermarket do you prefer?', 'single_choice', '["Naivas", "Quickmart", "Carrefour", "Chandarana", "Any local shop"]', 5
FROM surveys WHERE title = 'Shopping Habits in Kenya' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Have you shopped online in the last month?', 'single_choice', '["Yes, multiple times", "Yes, once", "No, but planning to", "No, prefer physical", "No, don''t trust online"]', 6
FROM surveys WHERE title = 'Shopping Habits in Kenya' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What do you spend most on monthly?', 'single_choice', '["Food/Groceries", "Clothing", "Electronics", "Household items", "Personal care"]', 7
FROM surveys WHERE title = 'Shopping Habits in Kenya' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you wait for sales/discounts?', 'single_choice', '["Yes, always", "Yes, for big items", "Sometimes", "Rarely", "No, buy when needed"]', 8
FROM surveys WHERE title = 'Shopping Habits in Kenya' LIMIT 1;

-- Mobile App Usage Survey (10 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How many apps do you have installed?', 'single_choice', '["Less than 20", "20-40", "40-60", "60-80", "More than 80"]', 1
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Which app do you use most daily?', 'single_choice', '["WhatsApp", "TikTok", "Instagram", "Facebook", "YouTube"]', 2
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How much time do you spend on apps daily?', 'single_choice', '["Less than 1 hour", "1-2 hours", "2-4 hours", "4-6 hours", "More than 6 hours"]', 3
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What type of apps do you use most?', 'single_choice', '["Social media", "Entertainment", "Productivity", "Finance", "Shopping"]', 4
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you pay for any app subscriptions?', 'single_choice', '["Yes, multiple", "Yes, one", "Used to but cancelled", "No, but considering", "No, never"]', 5
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How do you discover new apps?', 'single_choice', '["Friends/family", "Social media ads", "App store featured", "Google search", "I don''t look for new apps"]', 6
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What frustrates you most about apps?', 'single_choice', '["Too many ads", "Battery drain", "Data usage", "Complex interface", "Privacy concerns"]', 7
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you read app reviews before downloading?', 'single_choice', '["Always", "Usually", "Sometimes", "Rarely", "Never"]', 8
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Have you ever paid for an app?', 'single_choice', '["Yes, many times", "Yes, a few times", "Once", "Never", "Didn''t know apps cost money"]', 9
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What phone do you currently use?', 'single_choice', '["iPhone", "Samsung", "Tecno", "Infinix", "Other"]', 10
FROM surveys WHERE title = 'Mobile App Usage Survey' LIMIT 1;

-- Social Media Trends (8 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Which platform do you use most?', 'single_choice', '["TikTok", "Instagram", "Facebook", "Twitter/X", "WhatsApp Status"]', 1
FROM surveys WHERE title = 'Social Media Trends' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How many hours daily on social media?', 'single_choice', '["Less than 1 hour", "1-2 hours", "2-3 hours", "3-4 hours", "More than 4 hours"]', 2
FROM surveys WHERE title = 'Social Media Trends' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What content do you engage with most?', 'single_choice', '["Videos/Reels", "Memes", "News", "Celebrity gossip", "Educational"]', 3
FROM surveys WHERE title = 'Social Media Trends' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you post your own content regularly?', 'single_choice', '["Yes, daily", "Yes, few times a week", "Yes, occasionally", "Rarely", "Never, just browse"]', 4
FROM surveys WHERE title = 'Social Media Trends' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Have you made purchases from social media ads?', 'single_choice', '["Yes, multiple times", "Yes, once", "No, but interested", "No, don''t trust", "Never seen relevant ads"]', 5
FROM surveys WHERE title = 'Social Media Trends' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What do you like least about social media?', 'single_choice', '["Too much negativity", "Fake news", "Privacy issues", "Time wasting", "Pressure to look perfect"]', 6
FROM surveys WHERE title = 'Social Media Trends' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you follow influencers/celebrities?', 'single_choice', '["Yes, many", "Yes, a few", "Rarely", "Only news accounts", "No, don''t care"]', 7
FROM surveys WHERE title = 'Social Media Trends' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Which trend are you following now?', 'single_choice', '["Dance challenges", "Cooking/recipes", "Fitness", "Fashion", "Tech/Gadgets"]', 8
FROM surveys WHERE title = 'Social Media Trends' LIMIT 1;

-- Favourite Kenyan Foods (6 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What is your favorite Kenyan dish?', 'single_choice', '["Ugali & Sukuma", "Nyama Choma", "Pilau", "Githeri", "Chapati & Beans"]', 1
FROM surveys WHERE title = 'Favourite Kenyan Foods' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How often do you eat traditional foods?', 'single_choice', '["Daily", "Few times a week", "Once a week", "Occasionally", "Rarely"]', 2
FROM surveys WHERE title = 'Favourite Kenyan Foods' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Where do you usually eat out?', 'single_choice', '["Local kibanda", "Restaurant", "Fast food", "Food court", "I rarely eat out"]', 3
FROM surveys WHERE title = 'Favourite Kenyan Foods' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What is your favorite snack?', 'single_choice', '["Mandazi", "Samosa", "Mutura", "Chipo", "Sausage/ Smokie"]', 4
FROM surveys WHERE title = 'Favourite Kenyan Foods' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you prefer cooking at home or buying?', 'single_choice', '["Always cook at home", "Mostly cook", "Mix of both", "Mostly buy", "Always buy ready"]', 5
FROM surveys WHERE title = 'Favourite Kenyan Foods' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Which drink pairs best with your meal?', 'single_choice', '["Chai", "Soda", "Water", "Mursik", "Beer"]', 6
FROM surveys WHERE title = 'Favourite Kenyan Foods' LIMIT 1;

-- Food & Dining (7 questions) - KSH 170 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How many meals do you eat daily?', 'single_choice', '["1 meal", "2 meals", "3 meals", "3+ with snacks", "Irregular"]', 1
FROM surveys WHERE title = 'Food & Dining' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What cuisine do you prefer most?', 'single_choice', '["Kenyan/African", "Indian", "Chinese", "Italian", "Fast food"]', 2
FROM surveys WHERE title = 'Food & Dining' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How often do you order food delivery?', 'single_choice', '["Multiple times a week", "Once a week", "Few times a month", "Rarely", "Never"]', 3
FROM surveys WHERE title = 'Food & Dining' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Which food delivery app do you use?', 'single_choice', '["Bolt Food", "Glovo", "Uber Eats", "Jumia Food", "I don''t use apps"]', 4
FROM surveys WHERE title = 'Food & Dining' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How much do you spend on food weekly?', 'single_choice', '["Under KSH 1000", "KSH 1000-2000", "KSH 2000-4000", "KSH 4000-6000", "Over KSH 6000"]', 5
FROM surveys WHERE title = 'Food & Dining' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you have any dietary restrictions?', 'single_choice', '["Vegetarian", "Halal only", "No restrictions", "Avoiding sugar", "Doctor recommended diet"]', 6
FROM surveys WHERE title = 'Food & Dining' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What matters most when choosing a restaurant?', 'single_choice', '["Price", "Food quality", "Location", "Hygiene", "Portion size"]', 7
FROM surveys WHERE title = 'Food & Dining' LIMIT 1;

-- Healthcare Access Survey (12 questions) - KSH 150 total
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'When did you last visit a hospital?', 'single_choice', '["Last month", "2-3 months ago", "6 months ago", "Over a year", "Can''t remember"]', 1
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How do you usually access healthcare?', 'single_choice', '["Public hospital", "Private hospital", "Pharmacy/clinic", "NHIF facility", "Traditional healer"]', 2
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Are you registered with NHIF?', 'single_choice', '["Yes, active", "Yes, but inactive", "No, planning to", "No, too expensive", "No, not interested"]', 3
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How far is the nearest hospital?', 'single_choice', '["Walking distance", "Under 5km", "5-10km", "10-20km", "Over 20km"]', 4
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Have you delayed treatment due to cost?', 'single_choice', '["Yes, often", "Yes, sometimes", "Yes, once", "No, never", "Not applicable"]', 5
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How would you rate healthcare quality?', 'single_choice', '["Excellent", "Good", "Fair", "Poor", "Very Poor"]', 6
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What healthcare issue concerns you most?', 'single_choice', '["Cost", "Long waiting times", "Drug availability", "Doctor attitude", "Cleanliness"]', 7
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you have a regular doctor?', 'single_choice', '["Yes, family doctor", "Yes, at one facility", "No, any available", "No, self-medicate", "Rarely need doctor"]', 8
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Have you used telemedicine services?', 'single_choice', '["Yes, regularly", "Yes, a few times", "Yes, once", "No, but interested", "No, prefer in-person"]', 9
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'How do you get medicines?', 'single_choice', '["Hospital pharmacy", "Private pharmacy", "Chemist", "Online pharmacy", "Friends/family"]', 10
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'Do you do regular health checkups?', 'single_choice', '["Yes, annually", "Yes, when sick", "Rarely", "Never", "Planning to start"]', 11
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;

INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number)
SELECT id, 'What would improve healthcare most?', 'single_choice', '["Lower costs", "More facilities", "Better equipment", "More doctors", "Shorter queues"]', 12
FROM surveys WHERE title = 'Healthcare Access Survey' LIMIT 1;
