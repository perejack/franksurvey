-- Survey Questions for Simple Multiple Choice Surveys (Kenyan Context)
-- All questions are option-based - no typing required!

-- First ensure the questions table exists with options column
CREATE TABLE IF NOT EXISTS survey_questions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    survey_id UUID REFERENCES surveys(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    question_type VARCHAR(50) DEFAULT 'single_choice',
    options JSONB NOT NULL,
    order_number INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Helper function to get survey ID by title
CREATE OR REPLACE FUNCTION get_survey_id(title_text TEXT) RETURNS UUID AS $$
DECLARE
    survey_uuid UUID;
BEGIN
    SELECT id INTO survey_uuid FROM surveys WHERE title = title_text LIMIT 1;
    RETURN survey_uuid;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- LIFESTYLE CATEGORY QUESTIONS
-- ============================================

-- Survey 1: Daily Transport Habits
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Daily Transport Habits'), 'How do you usually get to work/school?', 'single_choice', '["Matatu", "Boda boda", "Private car", "Walking", "Bus", "Uber/Bolt"]',
 1),
(get_survey_id('Daily Transport Habits'), 'How much do you spend on transport daily?', 'single_choice', '["Less than 100 KSH", "100-200 KSH", "200-500 KSH", "500-1000 KSH", "Over 1000 KSH"]',
 2),
(get_survey_id('Daily Transport Habits'), 'What time do you usually leave home?', 'single_choice', '["Before 6 AM", "6-7 AM", "7-8 AM", "8-9 AM", "After 9 AM"]',
 3),
(get_survey_id('Daily Transport Habits'), 'Which matatu route do you use most?', 'single_choice', '["CBD to Estate", "CBD to Industrial Area", "Estate to Town", "Town to Airport", "Other route"]',
 4),
(get_survey_id('Daily Transport Habits'), 'How do you pay for transport?', 'single_choice', '["Cash", "M-Pesa", "Card", "Both cash and M-Pesa"]',
 5);

-- Survey 2: Phone Usage Survey  
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Phone Usage Survey'), 'Which phone brand do you use?', 'single_choice', '["Samsung", "Tecno", "Infinix", "iPhone", "Huawei", "Nokia", "Other"]',
 1),
(get_survey_id('Phone Usage Survey'), 'How many hours daily do you use your phone?', 'single_choice', '["Less than 2 hours", "2-4 hours", "4-6 hours", "6-8 hours", "Over 8 hours"]',
 2),
(get_survey_id('Phone Usage Survey'), 'What do you use your phone for most?', 'single_choice', '["Social media", "Calls and texts", "Work/Business", "Entertainment", "Reading news"]',
 3),
(get_survey_id('Phone Usage Survey'), 'Which mobile network do you use?', 'single_choice', '["Safaricom", "Airtel", "Telkom", "Faiba", "Multiple networks"]',
 4),
(get_survey_id('Phone Usage Survey'), 'How much do you spend on data per week?', 'single_choice', '["Less than 50 KSH", "50-100 KSH", "100-200 KSH", "200-500 KSH", "Over 500 KSH"]',
 5);

-- Survey 3: Shopping Preferences
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Shopping Preferences'), 'Where do you buy most groceries?', 'single_choice', '["Supermarket", "Local kiosk/duka", "Open air market", "Online shops", "Wholesale shops"]',
 1),
(get_survey_id('Shopping Preferences'), 'How often do you go shopping?', 'single_choice', '["Daily", "2-3 times per week", "Once per week", "Twice per month", "Once per month"]',
 2),
(get_survey_id('Shopping Preferences'), 'What day do you usually shop?', 'single_choice', '["Monday-Friday", "Saturday", "Sunday", "Any day", "End of month"]',
 3),
(get_survey_id('Shopping Preferences'), 'How do you pay when shopping?', 'single_choice', '["Cash only", "M-Pesa only", "Card", "Mix of cash and M-Pesa"]',
 4),
(get_survey_id('Shopping Preferences'), 'What influences where you shop?', 'single_choice', '["Price", "Quality", "Distance/Location", "Variety", "Customer service"]',
 5);

-- Survey 4: Weekend Activities
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Weekend Activities'), 'What do you usually do on Saturdays?', 'single_choice', '["Stay at home", "Visit friends/family", "Go to church/mosque", "Shopping", "Entertainment/outings", "Work"]',
 1),
(get_survey_id('Weekend Activities'), 'Where do you spend most weekend time?', 'single_choice', '["At home", "In town/CBD", "Residential estate", "Village/Upcountry", "Malls/Supermarkets"]',
 2),
(get_survey_id('Weekend Activities'), 'Who do you spend weekends with?', 'single_choice', '["Alone", "Family", "Friends", "Spouse/Partner", "Colleagues"]',
 3),
(get_survey_id('Weekend Activities'), 'How much do you spend on weekend outings?', 'single_choice', '["Nothing - stay home", "Under 500 KSH", "500-1000 KSH", "1000-3000 KSH", "Over 3000 KSH"]',
 4),
(get_survey_id('Weekend Activities'), 'What is your favorite weekend activity?', 'single_choice', '["Watching movies/TV", "Eating out", "Visiting friends", "Church activities", "Sports/exercise", "Sleeping/Resting"]',
 5);

-- Survey 5: Food & Eating Habits
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Food & Eating Habits'), 'How many meals do you eat daily?', 'single_choice', '["1 meal", "2 meals", "3 meals", "More than 3 meals", "It varies"]',
 1),
(get_survey_id('Food & Eating Habits'), 'Where do you eat most of your meals?', 'single_choice', '["At home", "At work", "Restaurants/hotels", "Street food vendors", "Takeaway/Delivery"]',
 2),
(get_survey_id('Food & Eating Habits'), 'What type of food do you prefer?', 'single_choice', '["Traditional Kenyan", "Fast food", "Healthy/Organic", "Mixed/International", "Street food"]',
 3),
(get_survey_id('Food & Eating Habits'), 'How much do you spend on food daily?', 'single_choice', '["Under 100 KSH", "100-300 KSH", "300-500 KSH", "500-1000 KSH", "Over 1000 KSH"]',
 4),
(get_survey_id('Food & Eating Habits'), 'Where do you buy food most often?', 'single_choice', '["Open market", "Supermarket", "Local kiosk", "Direct from farm", "Online delivery"]',
 5);

-- ============================================
-- MOBILE TECH CATEGORY QUESTIONS
-- ============================================

-- Survey 6: M-Pesa Usage Survey
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('M-Pesa Usage Survey'), 'How often do you use M-Pesa?', 'single_choice', '["Daily", "Several times a week", "Once a week", "Few times a month", "Rarely/Never"]',
 1),
(get_survey_id('M-Pesa Usage Survey'), 'What do you use M-Pesa for most?', 'single_choice', '["Send money", "Receive money", "Pay bills", "Buy Goods and Services"]', 2),
(get_survey_id('M-Pesa Usage Survey'), 'Where do you usually transact M-Pesa?', 'single_choice', '["Agent shop", "Through phone directly", "Bank ATM", "Supermarket", "Online app"]',
 3),
(get_survey_id('M-Pesa Usage Survey'), 'How much do you typically transact?', 'single_choice', '["Under 1000 KSH", "1000-5000 KSH", "5000-10000 KSH", "10000-50000 KSH", "Over 50000 KSH"]',
 4),
(get_survey_id('M-Pesa Usage Survey'), 'Have you used M-Pesa Global?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "No, but aware", "No, never heard"]',
 5),
(get_survey_id('M-Pesa Usage Survey'), 'Which M-Pesa feature do you use most?', 'single_choice', '["Send to another number", "Withdraw cash", "Buy airtime", "Pay Bill", "Buy Goods", "Fuliza"]',
 6);

-- Survey 7: Mobile Banking Habits
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Mobile Banking Habits'), 'Which bank do you use?', 'single_choice', '["KCB", "Equity", "Cooperative", "Absa", "Standard Chartered", "NCBA", "Other", "No bank account"]',
 1),
(get_survey_id('Mobile Banking Habits'), 'Do you use mobile banking app?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "No, use USSD only", "No, go to branch", "No bank account"]',
 2),
(get_survey_id('Mobile Banking Habits'), 'What do you use mobile banking for?', 'single_choice', '["Check balance", "Transfer money", "Pay bills", "Apply for loans", "Buy airtime", "All of these"]',
 3),
(get_survey_id('Mobile Banking Habits'), 'How often do you visit a bank branch?', 'single_choice', '["Weekly", "Monthly", "Few times a year", "Only when forced", "Never - all digital"]',
 4),
(get_survey_id('Mobile Banking Habits'), 'Which loan service have you used?', 'single_choice', '["M-Shwari", "KCB M-Pesa", "Fuliza", "Branch", "Tala", "None", "Multiple"]',
 5),
(get_survey_id('Mobile Banking Habits'), 'What worries you about mobile banking?', 'single_choice', '["Security/Hacking", "Network issues", "Transaction fees", "Complex to use", "Nothing - love it"]',
 6);

-- Survey 8: Social Media Usage
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Social Media Usage'), 'Which social media app do you use most?', 'single_choice', '["WhatsApp", "Facebook", "Instagram", "TikTok", "Twitter/X", "Telegram", "LinkedIn"]',
 1),
(get_survey_id('Social Media Usage'), 'How many hours daily on social media?', 'single_choice', '["Less than 1 hour", "1-2 hours", "2-4 hours", "4-6 hours", "Over 6 hours"]',
 2),
(get_survey_id('Social Media Usage'), 'What do you use social media for?', 'single_choice', '["Chatting friends", "News/Information", "Business/Marketing", "Entertainment", "Dating/Socializing", "All of above"]',
 3),
(get_survey_id('Social Media Usage'), 'Do you buy things via social media?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "No, just browse", "No, don''t trust it", "I sell on social media"]',
 4),
(get_survey_id('Social Media Usage'), 'Which platform influences you most?', 'single_choice', '["WhatsApp status", "Facebook", "Instagram", "TikTok", "Influencers", "None"]',
 5),
(get_survey_id('Social Media Usage'), 'Have you made friends online?', 'single_choice', '["Yes, many", "Yes, a few", "No, never", "Prefer not to say", "Only business contacts"]',
 6);

-- Survey 9: Internet & Data Usage
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Internet & Data Usage'), 'How do you access internet mostly?', 'single_choice', '["Mobile data", "WiFi at home", "WiFi at work", "Public WiFi", "Cyber cafe"]',
 1),
(get_survey_id('Internet & Data Usage'), 'Which data bundle do you buy most?', 'single_choice', '["Daily bundle", "Weekly bundle", "Monthly bundle", "Tunukiwa/Custom", "I don''t buy data"]',
 2),
(get_survey_id('Internet & Data Usage'), 'What uses most of your data?', 'single_choice', '["Social media", "Videos/YouTube", "Music streaming", "Downloads", "Work/Email", "Gaming"]',
 3),
(get_survey_id('Internet & Data Usage'), 'Which network has best internet?', 'single_choice', '["Safaricom", "Airtel", "Telkom", "Faiba", "Depends on area"]',
 4),
(get_survey_id('Internet & Data Usage'), 'Do you use unlimited data plans?', 'single_choice', '["Yes, home fiber", "Yes, unlimited mobile", "No, too expensive", "No, not available", "What''s that?"]',
 5),
(get_survey_id('Internet & Data Usage'), 'Have you tried 5G internet?', 'single_choice', '["Yes, have it", "Yes, tried once", "No, too expensive", "No, not available", "What is 5G?"]',
 6);

-- Survey 10: Apps You Use Daily
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Apps You Use Daily'), 'Which app do you open first daily?', 'single_choice', '["WhatsApp", "Facebook", "Instagram", "Email", "News app", "Work app"]',
 1),
(get_survey_id('Apps You Use Daily'), 'How many apps do you have installed?', 'single_choice', '["Under 20", "20-50", "50-100", "100-200", "Over 200"]',
 2),
(get_survey_id('Apps You Use Daily'), 'Which ride-hailing app do you use?', 'single_choice', '["Uber", "Bolt", "Little", "Faras", "None of these", "Don''t use any"]',
 3),
(get_survey_id('Apps You Use Daily'), 'Which food delivery app do you use?', 'single_choice', '["Jumia Food", "Glovo", "Bolt Food", "Uber Eats", "None", "Other"]',
 4),
(get_survey_id('Apps You Use Daily'), 'Which shopping app do you use?', 'single_choice', '["Jumia", "Kilimall", "Copia", "Sky.Garden", "None", "Multiple"]',
 5),
(get_survey_id('Apps You Use Daily'), 'Do you use money lending apps?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "No, but aware", "No, never", "Never heard of them"]',
 6);

-- ============================================
-- CONSUMER CHOICES CATEGORY QUESTIONS
-- ============================================

-- Survey 11: Supermarket Preferences
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Supermarket Preferences'), 'Which supermarket do you visit most?', 'single_choice', '["Naivas", "Carrefour", "Quickmart", "Chandarana", "Tusky''s", "Other"]',
 1),
(get_survey_id('Supermarket Preferences'), 'How often do you visit supermarkets?', 'single_choice', '["Daily", "Weekly", "Bi-weekly", "Monthly", "Rarely"]',
 2),
(get_survey_id('Supermarket Preferences'), 'What do you buy most at supermarkets?', 'single_choice', '["Food/Groceries", "Household items", "Personal care", "Electronics", "Clothing", "Mix of everything"]',
 3),
(get_survey_id('Supermarket Preferences'), 'Why do you choose your supermarket?', 'single_choice', '["Low prices", "Near home/work", "Product variety", "Quality products", "Good service"]',
 4),
(get_survey_id('Supermarket Preferences'), 'Do you use supermarket loyalty cards?', 'single_choice', '["Yes, always", "Yes, sometimes", "No, don''t have", "No, not interested", "What loyalty cards?"]',
 5),
(get_survey_id('Supermarket Preferences'), 'Which day do you prefer shopping?', 'single_choice', '["Weekday morning", "Weekday evening", "Saturday", "Sunday", "Any day - when needed"]',
 6);

-- Survey 12: Airtime Purchase Habits
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Airtime Purchase Habits'), 'How do you buy airtime most?', 'single_choice', '["M-Pesa", "Scratch card", "Bank app", "Supermarket/Shop", "Someone buys for me"]',
 1),
(get_survey_id('Airtime Purchase Habits'), 'How much airtime per week?', 'single_choice', '["Under 100 KSH", "100-200 KSH", "200-500 KSH", "500-1000 KSH", "Over 1000 KSH"]',
 2),
(get_survey_id('Airtime Purchase Habits'), 'What do you use airtime for?', 'single_choice', '["Calls only", "Data only", "Both calls and data", "SMS", "Mixed usage"]',
 3),
(get_survey_id('Airtime Purchase Habits'), 'Do you use airtime advance (Okoa)?', 'single_choice', '["Yes, regularly", "Yes, sometimes", "No, never needed", "No, don''t like debt", "What''s Okoa?"]',
 4),
(get_survey_id('Airtime Purchase Habits'), 'How do you check airtime balance?', 'single_choice', '["USSD code (*144#)", "SMS", "App notification", "I never check", "Call customer care"]',
 5),
(get_survey_id('Airtime Purchase Habits'), 'Which bundle type do you prefer?', 'single_choice', '["All-net (any network)", "Same network only", "Data only", "Call minutes only", "Mixed bundles"]',
 6);

-- Survey 13: Data Entry Task 1
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Data Entry Task 1'), 'What type of data do you prefer entering?', 'single_choice', '["Numbers", "Text", "Mixed data", "Customer records", "Product information"]', 1),
(get_survey_id('Data Entry Task 1'), 'How fast can you type?', 'single_choice', '["Very fast", "Average speed", "Slow but accurate", "I use voice typing", "I prefer handwriting"]', 2),
(get_survey_id('Data Entry Task 1'), 'Which software do you use most?', 'single_choice', '["Microsoft Excel", "Google Sheets", "Notepad", "Database software", "Mobile apps"]', 3),
(get_survey_id('Data Entry Task 1'), 'How do you check your work?', 'single_choice', '["Double-check immediately", "Review at end", "Use spell check", "Ask someone else", "I trust my first entry"]', 4),
(get_survey_id('Data Entry Task 1'), 'What time do you work best?', 'single_choice', '["Early morning", "Mid-morning", "Afternoon", "Evening", "Late night"]', 5);

-- Survey 14: Market Research 1
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Market Research 1'), 'Which brands do you notice most?', 'single_choice', '["Local Kenyan brands", "International brands", "Both equally", "Premium brands", "Budget brands"]', 1),
(get_survey_id('Market Research 1'), 'What influences your purchases?', 'single_choice', '["Price", "Quality", "Brand reputation", "Friends recommendations", "Social media ads"]', 2),
(get_survey_id('Market Research 1'), 'Where do you see most ads?', 'single_choice', '["TV", "Radio", "Social media", "Billboards", "WhatsApp groups"]', 3),
(get_survey_id('Market Research 1'), 'How often do you try new products?', 'single_choice', '["Always", "Often", "Sometimes", "Rarely", "Never - stick to what I know"]', 4),
(get_survey_id('Market Research 1'), 'What products interest you most?', 'single_choice', '["Food and drinks", "Electronics", "Clothing", "Beauty products", "Home appliances"]', 5);

-- Survey 15: Customer Feedback 1
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Customer Feedback 1'), 'How do you rate service in Kenya?', 'single_choice', '["Excellent", "Good", "Average", "Poor", "Very poor"]', 1),
(get_survey_id('Customer Feedback 1'), 'What annoys you most as customer?', 'single_choice', '["Long queues", "Rude staff", "High prices", "Poor quality", "Slow service"]', 2),
(get_survey_id('Customer Feedback 1'), 'How do you complain about service?', 'single_choice', '["Talk to manager", "Post on social media", "Tell friends only", "Never complain", "Call customer care"]', 3),
(get_survey_id('Customer Feedback 1'), 'What makes you return to a shop?', 'single_choice', '["Good prices", "Friendly staff", "Quality products", "Near my home", "Loyalty rewards"]', 4),
(get_survey_id('Customer Feedback 1'), 'How important is customer service?', 'single_choice', '["Very important", "Important", "Somewhat important", "Not very important", "Only price matters"]', 5);

-- Survey 16: Product Review 1
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Product Review 1'), 'What do you check before buying?', 'single_choice', '["Price", "Reviews online", "Ask friends", "Brand name", "Expiry date"]', 1),
(get_survey_id('Product Review 1'), 'Where do you read product reviews?', 'single_choice', '["Google reviews", "Social media", "Jumia reviews", "Ask friends", "I don''t read reviews"]', 2),
(get_survey_id('Product Review 1'), 'Have you written a product review?', 'single_choice', '["Yes, many times", "Yes, sometimes", "Only when bad", "Only when excellent", "Never"]', 3),
(get_survey_id('Product Review 1'), 'What products need better quality?', 'single_choice', '["Electronics", "Clothing/shoes", "Food items", "Beauty products", "Household items"]', 4),
(get_survey_id('Product Review 1'), 'Do you trust online reviews?', 'single_choice', '["Yes, completely", "Mostly yes", "Sometimes", "Rarely", "Not at all"]', 5);

-- Survey 17: Opinion Poll 1
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Opinion Poll 1'), 'Are you hopeful about Kenya''s future?', 'single_choice', '["Very hopeful", "Somewhat hopeful", "Neutral", "Somewhat pessimistic", "Very pessimistic"]', 1),
(get_survey_id('Opinion Poll 1'), 'What should government focus on?', 'single_choice', '["Jobs", "Healthcare", "Education", "Security", "Cost of living"]', 2),
(get_survey_id('Opinion Poll 1'), 'How do you follow news?', 'single_choice', '["TV news", "Radio", "Social media", "Newspapers", "Word of mouth"]', 3),
(get_survey_id('Opinion Poll 1'), 'What affects you most daily?', 'single_choice', '["High prices", "Traffic", "Power outages", "Water shortage", "Job stress"]', 4),
(get_survey_id('Opinion Poll 1'), 'Would you recommend living in Kenya?', 'single_choice', '["Yes, strongly", "Yes", "Neutral", "No, but manageable", "No, want to leave"]', 5);

-- Survey 18: Data Entry Task 2
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Data Entry Task 2'), 'Do you prefer working alone or team?', 'single_choice', '["Alone", "Small team", "Large team", "Doesn''t matter", "Prefer supervision"]', 1),
(get_survey_id('Data Entry Task 2'), 'How do you organize your files?', 'single_choice', '["By date", "By name", "By category", "By client", "I don''t organize"]', 2),
(get_survey_id('Data Entry Task 2'), 'What keyboard do you use?', 'single_choice', '["Laptop built-in", "External keyboard", "Phone touch", "Tablet", "Cyber cafe"]', 3),
(get_survey_id('Data Entry Task 2'), 'Do you use keyboard shortcuts?', 'single_choice', '["Yes, many", "A few basic ones", "Copy-paste only", "No, I click everything", "What are shortcuts?"]', 4),
(get_survey_id('Data Entry Task 2'), 'How do you handle errors?', 'single_choice', '["Fix immediately", "Note and fix later", "Ask for help", "Leave them", "Restart everything"]', 5);

-- Survey 19: Market Research 2
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Market Research 2'), 'What time do you shop most?', 'single_choice', '["Morning", "Midday", "Evening", "Weekends only", "End of month"]', 1),
(get_survey_id('Market Research 2'), 'Who makes buying decisions at home?', 'single_choice', '["Me", "Spouse/partner", "Parents", "Children", "Joint decision"]', 2),
(get_survey_id('Market Research 2'), 'How do you discover new products?', 'single_choice', '["Social media", "TV ads", "Friends tell me", "In shops", "Online search"]', 3),
(get_survey_id('Market Research 2'), 'What payment method prefer?', 'single_choice', '["M-Pesa", "Cash", "Bank card", "Buy now pay later", "Mix of methods"]', 4),
(get_survey_id('Market Research 2'), 'Do you compare prices before buying?', 'single_choice', '["Always", "Often", "Sometimes", "Rarely", "Never - just buy"]', 5);

-- Survey 20: Customer Feedback 2
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Customer Feedback 2'), 'How long will you wait in queue?', 'single_choice', '["5 minutes max", "10-15 minutes", "20-30 minutes", "Up to 1 hour", "As long as needed"]', 1),
(get_survey_id('Customer Feedback 2'), 'What improves your shopping experience?', 'single_choice', '["Fast checkout", "Good lighting", "Music playing", "Clean environment", "Helpful staff"]', 2),
(get_survey_id('Customer Feedback 2'), 'Have you switched brands recently?', 'single_choice', '["Yes, found better", "Yes, price too high", "No, very loyal", "No, but considering", "Use multiple brands"]', 3),
(get_survey_id('Customer Feedback 2'), 'What loyalty programs do you use?', 'single_choice', '["Supermarket cards", "Airline miles", "M-Pesa rewards", "None", "Multiple programs"]', 4),
(get_survey_id('Customer Feedback 2'), 'How do you prefer to shop?', 'single_choice', '["In-store only", "Online only", "Mix of both", "Phone orders", "WhatsApp orders"]', 5);

-- Survey 21: Product Review 2
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Product Review 2'), 'What brand phone do you have?', 'single_choice', '["Samsung", "Tecno", "Infinix", "iPhone", "Huawei/Nokia/Other"]', 1),
(get_survey_id('Product Review 2'), 'How long do phones last you?', 'single_choice', '["Less than 1 year", "1-2 years", "2-3 years", "3-4 years", "Over 4 years"]', 2),
(get_survey_id('Product Review 2'), 'What feature matters most?', 'single_choice', '["Camera quality", "Battery life", "Storage space", "Screen size", "Price"]', 3),
(get_survey_id('Product Review 2'), 'Where do you buy electronics?', 'single_choice', '["Jumia/Online", "Physical shops", "Import myself", "Second hand", "Gifts from abroad"]', 4),
(get_survey_id('Product Review 2'), 'Would you buy Kenyan brand phone?', 'single_choice', '["Yes, proudly", "Yes if good quality", "Maybe", "No, prefer foreign", "Depends on price"]', 5);

-- Survey 22: Opinion Poll 2
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Opinion Poll 2'), 'Do you feel safe in your area?', 'single_choice', '["Very safe", "Mostly safe", "Sometimes worried", "Often worried", "Never feel safe"]', 1),
(get_survey_id('Opinion Poll 2'), 'What''s biggest challenge youth face?', 'single_choice', '["No jobs", "Drug abuse", "Education costs", "Peer pressure", "Mental health"]', 2),
(get_survey_id('Opinion Poll 2'), 'How do you feel about cost of living?', 'single_choice', '["Very worried", "Somewhat worried", "Managing fine", "Not worried", "It''s improving"]', 3),
(get_survey_id('Opinion Poll 2'), 'What should improve in education?', 'single_choice', '["Lower fees", "Better teachers", "More schools", "Technology", "Practical skills"]', 4),
(get_survey_id('Opinion Poll 2'), 'Are you satisfied with healthcare?', 'single_choice', '["Very satisfied", "Satisfied", "Neutral", "Dissatisfied", "Very dissatisfied"]', 5);

-- Survey 23: Data Entry Task 3
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Data Entry Task 3'), 'How many hours can you work daily?', 'single_choice', '["1-2 hours", "3-4 hours", "5-6 hours", "7-8 hours", "As needed"]', 1),
(get_survey_id('Data Entry Task 3'), 'What internet speed do you have?', 'single_choice', '["Very fast", "Good", "Average", "Slow", "No home internet"]', 2),
(get_survey_id('Data Entry Task 3'), 'Do you have backup power?', 'single_choice', '["Solar", "Generator", "Power bank", "No backup", "Multiple backups"]', 3),
(get_survey_id('Data Entry Task 3'), 'How do you backup your work?', 'single_choice', '["Cloud storage", "External drive", "Email to myself", "USB flash", "I don''t backup"]', 4),
(get_survey_id('Data Entry Task 3'), 'What motivates you to work?', 'single_choice', '["Money", "Learning skills", "Career growth", "Flexible hours", "Remote work"]', 5);

-- Survey 24: Market Research 3
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Market Research 3'), 'What''s your monthly shopping budget?', 'single_choice', '["Under 5,000", "5,000-10,000", "10,000-20,000", "20,000-50,000", "Over 50,000"]', 1),
(get_survey_id('Market Research 3'), 'What do you spend most on?', 'single_choice', '["Food", "Rent", "Transport", "Clothes", "Entertainment"]', 2),
(get_survey_id('Market Research 3'), 'Do you use buy-now-pay-later?', 'single_choice', '["Yes, often", "Yes, sometimes", "No, but interested", "No, avoid debt", "Never heard of it"]', 3),
(get_survey_id('Market Research 3'), 'What makes you buy immediately?', 'single_choice', '["Discount", "Limited stock", "Free gift", "End of month salary", "Urgent need"]', 4),
(get_survey_id('Market Research 3'), 'How do you save money on shopping?', 'single_choice', '["Buy in bulk", "Wait for sales", "Compare prices", "Use coupons", "I don''t save"]', 5);

-- Survey 25: Customer Feedback 3
INSERT INTO survey_questions (survey_id, question_text, question_type, options, order_number) VALUES
(get_survey_id('Customer Feedback 3'), 'Do you tip service providers?', 'single_choice', '["Always", "Often", "Sometimes", "Rarely", "Never"]', 1),
(get_survey_id('Customer Feedback 3'), 'What service needs most improvement?', 'single_choice', '["Banking", "Government offices", "Hospitals", "Shops", "Transport"]', 2),
(get_survey_id('Customer Feedback 3'), 'How do you reward good service?', 'single_choice', '["Tip money", "Say thank you", "Recommend to friends", "Online review", "I don''t"]', 3),
(get_survey_id('Customer Feedback 3'), 'What frustrates you in queues?', 'single_choice', '["Slow staff", "People cutting line", "System failures", "Wrong information", "Long waits"]', 4),
(get_survey_id('Customer Feedback 3'), 'Would you pay more for better service?', 'single_choice', '["Yes, definitely", "Yes, slightly more", "Maybe", "No, same price only", "No, cheaper is better"]', 5);

-- Clean up helper function
DROP FUNCTION IF EXISTS get_survey_id;

-- Note: All questions are designed for easy answering - just select from options!
-- No typing, no writing, no long answers required!
