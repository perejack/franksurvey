-- Fix survey titles to match what the user expects
-- Also update rewards and question counts

-- Fix Wellness & Mental Health -> Transportation Habits
UPDATE surveys 
SET title = 'Transportation Habits', 
    description = 'How you move around Kenya',
    category = 'transport',
    reward = 160,
    duration = '4 min',
    questions_count = 8
WHERE id = '99ff28a0-52b5-42bb-bc4d-f2052e780ee2';

-- Fix Transportation Survey -> Home and Living  
UPDATE surveys 
SET title = 'Home and Living', 
    description = 'Your living situation and preferences',
    category = 'lifestyle',
    reward = 150,
    duration = '4 min',
    questions_count = 7
WHERE id = 'f6beb6b2-d460-4a85-861b-d0fa4957e615';

-- Clean up any duplicate questions that might have wrong survey_ids
-- Keep only questions for our two target surveys with correct order_numbers
DELETE FROM survey_questions 
WHERE survey_id = '99ff28a0-52b5-42bb-bc4d-f2052e780ee2' 
AND order_number > 8;

DELETE FROM survey_questions 
WHERE survey_id = 'f6beb6b2-d460-4a85-861b-d0fa4957e615' 
AND order_number > 7;

-- Verify the fixes
SELECT id, title, category, reward, questions_count
FROM surveys 
WHERE id IN ('99ff28a0-52b5-42bb-bc4d-f2052e780ee2', 'f6beb6b2-d460-4a85-861b-d0fa4957e615');
