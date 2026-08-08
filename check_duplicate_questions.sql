-- Find duplicate questions across different surveys
-- This identifies questions that appear in multiple surveys (not supposed to happen)

-- First, see all survey questions grouped by survey
SELECT 
    s.title as survey_title,
    s.category,
    s.is_locked,
    s.is_premium,
    sq.question_text,
    sq.question_type
FROM survey_questions sq
JOIN surveys s ON s.id = sq.survey_id
ORDER BY s.category, s.title, sq.order_number;

-- Find questions that appear in MULTIPLE surveys (duplicates)
SELECT 
    sq.question_text,
    COUNT(DISTINCT sq.survey_id) as survey_count,
    STRING_AGG(DISTINCT s.title, ' | ') as survey_titles,
    STRING_AGG(DISTINCT s.category, ' | ') as categories
FROM survey_questions sq
JOIN surveys s ON s.id = sq.survey_id
GROUP BY sq.question_text
HAVING COUNT(DISTINCT sq.survey_id) > 1
ORDER BY survey_count DESC;

-- Check if first 13 surveys (home page) share questions with category surveys
WITH home_surveys AS (
    SELECT id, title, category 
    FROM surveys 
    WHERE is_locked = false AND is_premium = false
    ORDER BY created_at 
    LIMIT 13
),
category_surveys AS (
    SELECT id, title, category 
    FROM surveys 
    WHERE category IN ('lifestyle', 'mobile_tech', 'consumer', 'entertainment', 'community')
)
SELECT 
    sq.question_text,
    hs.title as home_survey,
    hs.category as home_category,
    cs.title as category_survey,
    cs.category as category_category
FROM survey_questions sq
JOIN home_surveys hs ON hs.id = sq.survey_id
JOIN survey_questions sq2 ON sq2.question_text = sq.question_text
JOIN category_surveys cs ON cs.id = sq2.survey_id AND cs.id != hs.id
ORDER BY hs.title, cs.title;
