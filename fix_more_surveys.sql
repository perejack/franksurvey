-- Fix additional survey titles and ensure correct rewards
-- Home & Living and Technology Adoption

-- Search for surveys with similar names and update them
-- Home & Living (was "Home and Living")
UPDATE surveys 
SET title = 'Home & Living',
    duration = '5 min',
    questions_count = 7,
    reward = 160,
    category = 'lifestyle'
WHERE title ILIKE '%home%' AND title ILIKE '%living%';

-- Technology Adoption
UPDATE surveys 
SET title = 'Technology Adoption',
    duration = '6 min',
    questions_count = 9,
    reward = 170,
    category = 'tech'
WHERE title ILIKE '%technology%' OR title ILIKE '%tech%adoption%';

-- Verify all homepage surveys
SELECT id, title, category, reward, duration, questions_count,
       (SELECT COUNT(*) FROM survey_questions sq WHERE sq.survey_id = surveys.id) as actual_questions
FROM surveys 
WHERE is_locked = false AND is_premium = false
ORDER BY category, title;
