WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_forms_answer_choices"
),
renamed AS (
    SELECT
        id,
        decidim_answer_id,
        decidim_answer_option_id,
        position,
        body::text AS body,
        custom_body,
        decidim_question_matrix_row_id
    FROM source
)
SELECT * FROM renamed