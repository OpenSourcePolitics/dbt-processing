
  
    

  create  table "test_lyon"."prod"."stg_decidim_comments__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_comments_comments"
),
renamed as (
    SELECT
        id,
        decidim_commentable_type,
        decidim_commentable_id,
        decidim_author_id,
        created_at,
        updated_at,
        depth,
        alignment,
        decidim_user_group_id,
        decidim_root_commentable_type,
        decidim_root_commentable_id,
        decidim_author_type,
        body::jsonb->>'fr' as body,
        comments_count
    FROM source
)
SELECT * FROM renamed
  );
  