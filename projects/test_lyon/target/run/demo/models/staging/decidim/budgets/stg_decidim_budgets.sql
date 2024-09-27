
  
    

  create  table "test_lyon"."prod"."stg_decidim_budgets__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_budgets_budgets"
),
renamed AS (
    SELECT
        id,
        title::jsonb->>'fr' as title,
        decidim_component_id
    FROM source
)
SELECT * FROM renamed
  );
  