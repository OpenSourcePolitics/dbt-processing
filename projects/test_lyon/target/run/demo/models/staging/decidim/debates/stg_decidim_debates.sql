
  
    

  create  table "test_lyon"."prod"."stg_decidim_debates__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_debates_debates"
),
renamed AS (
    SELECT
        id,
        title::jsonb->>'fr' as title,
        regexp_replace(description::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as description,
        start_time,
        end_time,
        decidim_component_id,
        decidim_author_id,
        created_at,
        closed_at,
        'Decidim::Debates::Debate' as resource_type
    FROM source 
)
SELECT * FROM renamed
  );
  