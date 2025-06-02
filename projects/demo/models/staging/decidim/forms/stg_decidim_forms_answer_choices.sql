WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_forms_answer_choices') }}
),
renamed AS (
    SELECT
        id,
        decidim_answer_id,
        decidim_answer_option_id,
        position,
        REPLACE(SUBSTR(body, 2, length(body) - 2)::text, '\"', '"') AS body,
        custom_body,
        decidim_question_matrix_row_id
    FROM source
)
SELECT * FROM renamed
  