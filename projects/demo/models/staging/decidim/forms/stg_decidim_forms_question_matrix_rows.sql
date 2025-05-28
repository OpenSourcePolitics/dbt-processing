{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_forms_question_matrix_rows') }}
),
renamed AS (
    SELECT
        id,
        decidim_question_id,
        position,
        body::jsonb->> '{{ lang }}' AS body
    FROM source
)
SELECT * FROM renamed
  