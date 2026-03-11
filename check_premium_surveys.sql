-- Add questions to ALL premium/locked surveys
-- First, let's see what we're working with

-- Check all locked/premium surveys and their question counts
SELECT 
    s.id,
    s.title,
    s.category,
    s.reward,
    s.questions_count,
    (SELECT COUNT(*) FROM survey_questions sq WHERE sq.survey_id = s.id) as actual_questions
FROM surveys s
WHERE s.is_locked = true OR s.is_premium = true
ORDER BY s.category, s.title;
