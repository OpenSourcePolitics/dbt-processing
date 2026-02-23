WITH
taxonomizations AS (
    {{ taxonomizables_select('Decidim::Budgets::Project') }}
),
categories_from_taxonomies AS (
    {{ import_categories_from_taxonomies('Decidim::Budgets::Project') }}
),
categorizations AS (
    {{ categorizations_filter('Decidim::Budgets::Project') }}
),
categories_final AS (
    SELECT
        id,
        COALESCE(categories_from_taxonomies.categories, categorizations.categories) AS categories,
        COALESCE(categories_from_taxonomies.sub_categories, categorizations.sub_categories) AS sub_categories
    FROM {{ ref("int_budgets_projects")}} AS decidim_budgets_projects
    LEFT JOIN categories_from_taxonomies on categories_from_taxonomies.taxonomizable_id = decidim_budgets_projects.id
    LEFT JOIN categorizations ON categorizations.categorizable_id = decidim_budgets_projects.id
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
    categories_final.categories,
    {{ categorization_first_category('categories_final.categories[1]') }} AS first_category,
    categories_final.sub_categories,
    {{ categorization_first_sub_category('categories_final.sub_categories[1]') }} AS first_sub_category,
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
LEFT JOIN categories_final ON categories_final.id = decidim_budgets_projects.id
WHERE decidim_budgets_projects.deleted_at IS NULL
