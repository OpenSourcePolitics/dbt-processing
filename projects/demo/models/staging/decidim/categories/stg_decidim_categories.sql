{% set lang = env_var('LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_categories') }}
),
renamed AS (
    SELECT
        id,
        name::jsonb->>'{{ lang }}' AS name,
        description,
        parent_id,
        decidim_participatory_space_id,
        decidim_participatory_space_type,
        weight
    FROM source
)
SELECT * FROM renamed
