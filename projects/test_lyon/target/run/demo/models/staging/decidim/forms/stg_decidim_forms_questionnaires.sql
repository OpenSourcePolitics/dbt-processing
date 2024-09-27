
  
    

  create  table "test_lyon"."prod"."stg_decidim_forms_questionnaires__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_forms_questionnaires"
),
renamed AS (
    SELECT
        id,
        title,
        description,
        tos,
        questionnaire_for_type,
        questionnaire_for_id,
        published_at,
        created_at,
        updated_at,
        salt
    FROM source
)
SELECT * FROM renamed
  );
  