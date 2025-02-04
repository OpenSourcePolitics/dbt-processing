{% set lang = env_var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_budgets_budgets') }}
),
renamed AS (
    SELECT
        id,
        title::jsonb->>'{{ lang }}' as title,
        decidim_component_id
    FROM source
)
SELECT * FROM renamed