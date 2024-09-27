
  
    

  create  table "test_lyon"."prod"."stg_decidim_areas__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_areas"
),
renamed as (
    select
        id,
        name,
        area_type_id,
        decidim_organization_id,
        created_at,
        updated_at
    FROM source
)
select * FROM renamed
  );
  