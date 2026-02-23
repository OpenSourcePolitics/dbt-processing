WITH
taxonomizations AS (
    {{ taxonomizables_select('Decidim::Budgets::Project') }}
),
categories_from_taxonomies AS (
    {{ import_categories_from_taxonomies('Decidim::Budgets::Project') }}
),
categorizations AS (
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
    COALESCE(categories_from_taxonomies.categories, categorizations.categories) AS categories,
    COALESCE(
        {{ categorization_first_category('categories_from_taxonomies.categories[1]') }},
        {{ categorization_first_category('categorizations.categories[1]') }}
        ) AS first_category,
    COALESCE(categories_from_taxonomies.sub_categories, categorizations.sub_categories) AS sub_categories,
    COALESCE(
        {{ categorization_first_sub_category('categories_from_taxonomies.sub_categories[1]') }},
        {{ categorization_first_sub_category('categorizations.sub_categories[1]') }}
    ) AS first_sub_category,
    taxonomizations.taxonomies,
    {{ taxonomization_first_taxonomy('taxonomizations.taxonomies[1]') }},
    taxonomizations.sub_taxonomies,
    {{ taxonomization_first_sub_taxonomy('taxonomizations.sub_taxonomies[1]') }}
FROM {{ ref("int_budgets_projects")}} AS decidim_budgets_projects
JOIN {{ ref("stg_decidim_budgets")}} AS decidim_budgets_budgets on decidim_budgets_budgets.id = decidim_budgets_projects.decidim_budgets_budget_id
JOIN {{ ref("components")}} as decidim_components on decidim_components.id = decidim_budgets_budgets.decidim_component_id
LEFT JOIN taxonomizations on taxonomizations.taxonomizable_id = decidim_budgets_projects.id
LEFT JOIN categories_from_taxonomies on categories_from_taxonomies.taxonomizable_id = decidim_budgets_projects.id
LEFT JOIN categorizations on categorizations.categorizable_id = decidim_budgets_projects.id
WHERE decidim_budgets_projects.deleted_at IS NULL
