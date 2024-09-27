
  
    

  create  table "test_lyon"."prod"."stg_decidim_moderations__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_moderations"
),
renamed AS (
    SELECT
        id,
        decidim_participatory_space_id,
        decidim_reportable_type,
        decidim_reportable_id,
        report_count,
        hidden_at,
        created_at,
        updated_at,
        decidim_participatory_space_type,
        reported_content
    FROM source
)
SELECT * FROM renamed
  );
  