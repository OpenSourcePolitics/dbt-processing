WITH source as (
      SELECT * FROM {{ source('decidim', 'decidim_budgets_line_items') }}
),
renamed as (
    select
        id,
        decidim_order_id,
        decidim_project_id
    FROM source
)
select * from renamed
  