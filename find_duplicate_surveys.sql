-- List all surveys and identify duplicates (same titles)

-- Get all surveys ordered by category
SELECT 
    id,
    title,
    category,
    reward,
    duration,
    questions_count,
    is_premium,
    is_locked,
    unlock_price,
    created_at
FROM surveys 
ORDER BY category, title, created_at;

-- Find surveys with duplicate titles
SELECT 
    title,
    category,
    COUNT(*) as duplicate_count,
    STRING_AGG(id::text, ', ') as survey_ids,
    STRING_AGG(reward::text, ', ') as rewards
FROM surveys 
GROUP BY title, category
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Get survey questions to see which surveys share the same questions
SELECT 
    sq.survey_id,
    s.title as survey_title,
    s.category,
    COUNT(sq.id) as question_count
FROM survey_questions sq
JOIN surveys s ON s.id = sq.survey_id
GROUP BY sq.survey_id, s.title, s.category
ORDER BY s.category, s.title;
