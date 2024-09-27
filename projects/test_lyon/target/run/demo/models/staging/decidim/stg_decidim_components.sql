
  
    

  create  table "test_lyon"."prod"."stg_decidim_components__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_components"
),
renamed AS (
    SELECT
        id,
        manifest_name,
        name::jsonb->>'fr' AS name,
        participatory_space_id,
        participatory_space_type,
        settings,
        weight,
        permissions,
        published_at,
        created_at,
        updated_at
    FROM source
)
SELECT * FROM renamed
  );
  