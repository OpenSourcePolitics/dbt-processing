WITH source as (
      SELECT * FROM "test_lyon"."public"."decidim_area_types"
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