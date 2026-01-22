SELECT
    decidim_budgets_budgets.id,
    decidim_budgets_budgets.title,
    decidim_components.id AS decidim_component_id,
    decidim_components.ps_url AS url,
    decidim_components.ps_slug,
    decidim_components.ps_title
FROM {{ ref ("stg_decidim_budgets")}} AS decidim_budgets_budgets
JOIN {{ ref("components")}} AS decidim_components on decidim_components.id = decidim_budgets_budgets.decidim_component_id
WHERE decidim_budgets_budgets.deleted_at IS NULL