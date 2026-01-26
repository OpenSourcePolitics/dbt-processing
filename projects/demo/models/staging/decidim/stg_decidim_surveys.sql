WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_surveys_surveys') }}
),
renamed as (
    SELECT
        id,
        decidim_component_id,
        created_at,
        updated_at,
        {{ get_column_if_exists(source('decidim', 'decidim_blogs_posts'), 'deleted_at', 'TIMESTAMP') }}
    FROM source
)
SELECT * FROM renamed
  