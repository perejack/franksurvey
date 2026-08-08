-- Check if survey_questions table has data
-- Count questions per survey

SELECT 
    s.id,
    s.title,
    s.category,
    COUNT(sq.id) as question_count
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
GROUP BY s.id, s.title, s.category
ORDER BY s.category, question_count DESC;

-- Alternative: Just see which surveys have ZERO questions
SELECT 
    s.id,
    s.title,
    s.category
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
WHERE sq.id IS NULL
ORDER BY s.category;
