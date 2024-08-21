WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_surveys_surveys') }}
),
renamed as (
    SELECT
        id,
        decidim_component_id,
        created_at,
        updated_at
    FROM source
)
SELECT * FROM renamed
  