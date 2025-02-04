{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_scopes') }}
),
renamed AS (
    SELECT
        id,
        decidim_organization_id,
        created_at,
        updated_at,
        name::jsonb->>'{{ lang }}' AS name,
        scope_type_id,
        parent_id,
        code,
        part_of
    FROM source
)
SELECT * FROM renamed
