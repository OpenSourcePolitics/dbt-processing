
  
    

  create  table "test_lyon"."prod"."stg_decidim_categorizations__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_categorizations"
),
renamed AS (
    SELECT
        id,
        decidim_category_id,
        categorizable_type,
        categorizable_id,
        created_at,
        updated_at
    FROM source
)
SELECT * FROM renamed
  );
  