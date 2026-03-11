-- Get all surveys in the system with their details
-- This helps identify duplicates and understand the survey structure

SELECT 
    s.id,
    s.title,
    s.description,
    s.category,
    s.reward,
    s.duration,
    s.questions_count,
    s.is_premium,
    s.is_locked,
    s.unlock_price,
    s.created_at,
    COUNT(sq.id) as actual_question_count
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
GROUP BY s.id, s.title, s.description, s.category, s.reward, s.duration, 
         s.questions_count, s.is_premium, s.is_locked, s.unlock_price, s.created_at
ORDER BY s.category, s.reward;

-- Alternative: Just list all surveys without question count
-- SELECT * FROM surveys ORDER BY category, created_at;
