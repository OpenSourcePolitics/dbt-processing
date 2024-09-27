WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_forms_answers"
),
renamed AS (
    SELECT
        id,
        body,
        decidim_user_id,
        decidim_questionnaire_id,
        decidim_question_id,
        created_at,
        updated_at,
        session_token,
        ip_hash
    FROM source
)
SELECT * FROM renamed