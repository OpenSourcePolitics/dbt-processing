{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_budgets_projects') }}
),
renamed AS (
    SELECT
    id, 
    title::jsonb->>'{{ lang }}' as title,
    regexp_replace(description::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as description,
    created_at,
    decidim_scope_id, 
    budget_amount as project_amount,
    selected_at,
    decidim_budgets_budget_id,
    'Decidim::Budgets::Project' as resource_type
    FROM source
)
SELECT * FROM renamed