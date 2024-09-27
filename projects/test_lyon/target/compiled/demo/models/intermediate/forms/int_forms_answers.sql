

SELECT
    id,
    body,
    decidim_user_id,
    decidim_questionnaire_id,
    decidim_question_id,
    created_at,
    (CASE
        WHEN decidim_user_id IS NULL THEN 'Non connecté'
        ELSE 'Inscrit et connecté'
        END
    ) AS author_status,
    updated_at,
    session_token,
    ip_hash
FROM "test_lyon"."prod"."stg_decidim_forms_answers"