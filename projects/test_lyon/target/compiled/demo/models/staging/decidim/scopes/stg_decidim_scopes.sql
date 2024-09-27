WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_scopes"
),
renamed AS (
    SELECT
        id,
        decidim_organization_id,
        created_at,
        updated_at,
        name::jsonb->>'fr' AS name,
        scope_type_id,
        parent_id,
        code,
        part_of
    FROM source
)
SELECT * FROM renamed