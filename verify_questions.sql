-- Check actual questions in Transportation and Home surveys
-- Use the exact UUIDs from the verification

SELECT 
    sq.survey_id,
    s.title,
    sq.question_text,
    sq.order_number
FROM survey_questions sq
JOIN surveys s ON s.id = sq.survey_id
WHERE s.id IN ('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'd1f581be-edbb-4b11-82b8-997ea0f2e9bb')
ORDER BY s.title, sq.order_number;

-- Check if options column has proper JSON format
SELECT 
    sq.survey_id,
    s.title,
    sq.options,
    pg_typeof(sq.options)
FROM survey_questions sq
JOIN surveys s ON s.id = sq.survey_id
WHERE s.id IN ('9f6ae800-ded7-44e5-a29b-3cc4cce9cc91', 'd1f581be-edbb-4b11-82b8-997ea0f2e9bb')
LIMIT 2;
