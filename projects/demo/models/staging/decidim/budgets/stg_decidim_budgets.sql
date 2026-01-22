{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_budgets_budgets') }}
),
renamed AS (
    SELECT
        id,
        title::jsonb->>'{{ lang }}' as title,
        decidim_component_id,
        total_budget,
        {{ get_column_if_exists(source('decidim', 'decidim_budgets_budgets'), 'deleted_at', 'TIMESTAMP') }}
    FROM source
)
SELECT * FROM renamed