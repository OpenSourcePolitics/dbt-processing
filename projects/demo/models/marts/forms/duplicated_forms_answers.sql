SELECT 
    session_token,
    question_title,
    answer,
    custom_body,
    position,
    sub_matrix_question,
    COUNT(*)
FROM {{ ref('all_forms_answers')}} all_answers
GROUP BY session_token, question_title, answer, custom_body, position, sub_matrix_question
HAVING COUNT(*) > 1
ORDER BY count DESC