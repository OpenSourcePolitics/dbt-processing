
  
    

  create  table "test_lyon"."prod"."stg_decidim_participatory_process_steps__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_participatory_process_steps"
),
renamed AS (
    select
        id,
        title::jsonb->>'fr' as title,
        title::jsonb->>'fr' as description,
        start_date,
        end_date,
        decidim_participatory_process_id,
        created_at,
        updated_at,
        active,
        position,
        cta_text,
        cta_path

    FROM source
)
select * FROM renamed
  );
  