
  
    

  create  table "test_lyon"."prod"."stg_decidim_coauthorships__dbt_tmp"
  
  
    as
  
  (
    

WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_coauthorships"
),
renamed AS (
    SELECT
        id,
        decidim_author_id,
        decidim_user_group_id,
        coauthorable_type,
        coauthorable_id,
        created_at,
        updated_at,
        decidim_author_type
    FROM source
)
SELECT * FROM renamed
  );
  