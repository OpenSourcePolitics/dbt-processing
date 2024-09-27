WITH categorizations AS (
    
    SELECT 
        array_agg(category_name) AS categories,
        array_agg(child_name) AS sub_categories,
        categorizable_id
    FROM "test_lyon"."prod"."categorizations" AS categorizations
    WHERE categorizations.categorizable_type = 'Decidim::Budgets::Project'
    GROUP BY categorizable_id 

)
SELECT
    decidim_budgets_projects.id, 
    decidim_budgets_projects.title,
    decidim_budgets_projects.description,
    decidim_budgets_projects.created_at,
    decidim_budgets_projects.decidim_scope_id, 
    decidim_budgets_projects.project_amount,
    decidim_budgets_projects.selected_at,
    decidim_budgets_projects.is_selected,
    decidim_budgets_budgets.id AS budget_id,
    decidim_budgets_budgets.title AS budget_title,
    decidim_budgets_projects.resource_type,
    decidim_budgets_budgets.decidim_component_id,
    concat(decidim_components.component_url,'/', decidim_components.manifest_name,'/', decidim_budgets_budgets.id, '/projects/', decidim_budgets_projects.id) AS project_url,
    categorizations.categories,
    coalesce(categorizations.categories[1], 'Sans catégorie') AS first_category,
    categorizations.sub_categories,
    coalesce(categorizations.sub_categories[1], 'Sans sous-catégorie') AS first_sub_category
FROM "test_lyon"."prod"."int_budgets_projects" AS decidim_budgets_projects
JOIN "test_lyon"."prod"."stg_decidim_budgets" AS decidim_budgets_budgets on decidim_budgets_budgets.id = decidim_budgets_projects.decidim_budgets_budget_id
JOIN "test_lyon"."prod"."components" as decidim_components on decidim_components.id = decidim_budgets_budgets.decidim_component_id
LEFT JOIN categorizations on categorizations.categorizable_id = decidim_budgets_projects.id