SELECT
    id, 
    title,
    description,
    created_at,
    decidim_scope_id, 
    project_amount,
    selected_at,
    decidim_budgets_budget_id,
    resource_type,
    (CASE
        WHEN selected_at IS NULL
        THEN false
        ELSE true
    END) AS is_selected
FROM "test_lyon"."prod"."stg_decidim_budgets_projects"