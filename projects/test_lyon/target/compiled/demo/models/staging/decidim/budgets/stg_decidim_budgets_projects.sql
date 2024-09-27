WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_budgets_projects"
),
renamed AS (
    SELECT
    id, 
    title::jsonb->>'fr' as title,
    regexp_replace(description::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as description,
    created_at,
    decidim_scope_id, 
    budget_amount as project_amount,
    selected_at,
    decidim_budgets_budget_id,
    'Decidim::Budgets::Project' as resource_type
    FROM source
)
SELECT * FROM renamed