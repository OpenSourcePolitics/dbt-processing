WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_categories"
),
renamed AS (
    SELECT
        id,
        name::jsonb->>'fr' AS name,
        description,
        parent_id,
        decidim_participatory_space_id,
        decidim_participatory_space_type,
        weight
    FROM source
)
SELECT * FROM renamed