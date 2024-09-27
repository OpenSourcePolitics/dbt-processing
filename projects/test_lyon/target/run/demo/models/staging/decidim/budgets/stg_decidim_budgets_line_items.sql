
  
    

  create  table "test_lyon"."prod"."stg_decidim_budgets_line_items__dbt_tmp"
  
  
    as
  
  (
    WITH source as (
      SELECT * FROM "test_lyon"."public"."decidim_budgets_line_items"
),
renamed as (
    select
        id,
        decidim_order_id,
        decidim_project_id
    FROM source
)
select * from renamed
  );
  