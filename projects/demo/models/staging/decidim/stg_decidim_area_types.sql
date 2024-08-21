WITH source as (
      SELECT * FROM {{ source('decidim', 'decidim_area_types') }}
),
renamed as (
    SELECT
        id,
        decidim_organization_id,
        name,
        plural
    FROM source
)
SELECT * FROM renamed
  