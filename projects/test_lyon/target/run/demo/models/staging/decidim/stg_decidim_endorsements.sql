
  
    

  create  table "test_lyon"."prod"."stg_decidim_endorsements__dbt_tmp"
  
  
    as
  
  (
    SELECT
    id,
    resource_type,
    resource_id,
    decidim_author_type,
    decidim_author_id,
    decidim_user_group_id,
    created_at,
    updated_at
FROM "test_lyon"."public"."decidim_endorsements"
  );
  