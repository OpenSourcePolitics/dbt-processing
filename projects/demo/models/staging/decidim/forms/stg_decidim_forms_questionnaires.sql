WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_forms_questionnaires') }}
),
renamed AS (
    SELECT
        id,
        title,
        description,
        tos,
        questionnaire_for_type,
        questionnaire_for_id,
        published_at,
        created_at,
        updated_at,
        salt
    FROM source
)
SELECT * FROM renamed
  