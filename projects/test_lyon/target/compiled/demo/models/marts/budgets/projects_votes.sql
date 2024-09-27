-- /!\ Warning : counts unfinished votes !
-- /!\ Warning : should be filtered on the corresponding budget to get the good values



WITH budgets_projects AS (
    SELECT
        decidim_budgets_line_items.decidim_order_id,
        decidim_budgets_projects.id AS "project_id",
        decidim_budgets_projects.title AS "project_title",
        decidim_budgets_projects.decidim_component_id,
        decidim_budgets_projects.project_url
    from  "test_lyon"."prod"."stg_decidim_budgets_line_items" AS decidim_budgets_line_items
        JOIN "test_lyon"."prod"."budgets_projects" decidim_budgets_projects on decidim_budgets_projects.id = decidim_budgets_line_items.decidim_project_id
)
    SELECT
        decidim_budgets_orders.id as order_id,
        decidim_budgets_orders.decidim_user_id,
        budgets_projects.project_id,
        budgets_projects.project_title,
        budgets_projects.decidim_component_id,
        decidim_budgets_orders.created_at,
        decidim_budgets_orders.checked_out_at,
        budgets_projects.project_url,
        decidim_budgets_orders.vote_finished,
        decidim_budgets_orders.decidim_budgets_budget_id
    from "test_lyon"."prod"."int_budgets_orders" AS decidim_budgets_orders
        LEFT JOIN budgets_projects on decidim_order_id = decidim_budgets_orders.id