{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_components') }}
),
renamed AS (
    SELECT
        id,
        manifest_name,
        name::jsonb->>'{{ lang }}' AS name,
        participatory_space_id,
        participatory_space_type,
        settings,
        weight,
        permissions,
        published_at,
        created_at,
        updated_at,
    FROM source
)
SELECT * FROM renamed