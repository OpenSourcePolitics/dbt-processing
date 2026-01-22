WITH categorizations AS (
    {{ categorizations_filter('Decidim::Budgets::Project') }}
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
    {{ categorization_first_category('categorizations.categories[1]') }},
    categorizations.sub_categories,
    {{ categorization_first_sub_category('categorizations.sub_categories[1]') }}
FROM {{ ref("int_budgets_projects")}} AS decidim_budgets_projects
JOIN {{ ref("stg_decidim_budgets")}} AS decidim_budgets_budgets on decidim_budgets_budgets.id = decidim_budgets_projects.decidim_budgets_budget_id
JOIN {{ ref("components")}} as decidim_components on decidim_components.id = decidim_budgets_budgets.decidim_component_id
LEFT JOIN categorizations on categorizations.categorizable_id = decidim_budgets_projects.id
WHERE decidim_budgets_projects.deleted_at IS NULL
