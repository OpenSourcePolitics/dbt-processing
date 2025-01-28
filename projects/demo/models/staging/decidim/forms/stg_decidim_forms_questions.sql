{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
      {'columns': ['decidim_questionnaire_id'], 'type': 'btree'},
      {'columns': ['question_type'], 'type': 'btree'},
    ]
)}}

{% set lang = env_var('LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_forms_questions') }}
),
renamed AS (
    SELECT
        id,
        decidim_questionnaire_id,
        position,
        question_type,
        mandatory,
        body::jsonb->>'{{ lang }}' AS body,
        description,
        max_choices,
        created_at,
        updated_at,
        max_characters
    FROM source
)
SELECT * FROM renamed
  