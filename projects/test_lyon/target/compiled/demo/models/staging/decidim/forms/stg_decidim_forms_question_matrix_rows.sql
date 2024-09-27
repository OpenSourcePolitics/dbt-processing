WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_forms_question_matrix_rows"
),
renamed AS (
    SELECT
        id,
        decidim_question_id,
        position,
        TRIM(body::jsonb->>'fr') AS body
    FROM source
)
SELECT * FROM renamed