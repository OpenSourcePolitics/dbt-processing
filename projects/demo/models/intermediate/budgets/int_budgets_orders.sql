SELECT
    id,
    decidim_user_id,
    checked_out_at,
    created_at,
    updated_at,
    decidim_budgets_budget_id,
    (CASE
        WHEN checked_out_at IS NULL
        THEN false
        ELSE true
    END) AS vote_finished
FROM {{ ref("stg_decidim_budgets_orders")}}