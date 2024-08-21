WITH source as (
      SELECT * FROM {{ source('decidim', 'decidim_budgets_orders') }}
),
renamed as (
    select
        id,
        decidim_user_id,
        checked_out_at,
        created_at,
        updated_at,
        decidim_budgets_budget_id
    FROM source
)
select * from renamed
  