WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_surveys_surveys"
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