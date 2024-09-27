WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_follows"
),
renamed as (
    SELECT
        id,
        decidim_user_id,
        updated_at,
        created_at,
        decidim_followable_type,
        decidim_followable_id
    FROM source
)
SELECT * FROM renamed