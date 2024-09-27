

SELECT
    decidim_user_id,
    session_token,
    ip_hash,
    question_type,
    position,
    COALESCE(NULLIF(decidim_forms_answers.body,''), 'Pas de réponse') AS "answer",
    '' AS sub_matrix_question,
    '' AS custom_body,
    -1 AS sorting_position,
    decidim_forms_questions.decidim_questionnaire_id,
    decidim_forms_questions.body,
    decidim_forms_answers.created_at,
    decidim_forms_answers.author_status
FROM "test_lyon"."prod"."int_forms_answers" decidim_forms_answers
JOIN "test_lyon"."prod"."stg_decidim_forms_questions" AS decidim_forms_questions ON decidim_forms_questions.id = decidim_forms_answers.decidim_question_id
WHERE question_type = ANY('{short_answer,long_answer}'::text[])