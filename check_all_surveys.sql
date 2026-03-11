-- Check all surveys and their question counts
SELECT 
    s.id,
    s.title,
    s.category,
    s.reward,
    s.questions_count,
    COUNT(sq.id) as actual_questions,
    CASE WHEN COUNT(sq.id) = 0 THEN 'MISSING QUESTIONS' ELSE 'OK' END as status
FROM surveys s
LEFT JOIN survey_questions sq ON sq.survey_id = s.id
GROUP BY s.id, s.title, s.category, s.reward, s.questions_count
ORDER BY s.category, s.title;
