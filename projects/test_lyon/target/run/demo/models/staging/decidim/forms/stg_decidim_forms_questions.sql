
  
    

  create  table "test_lyon"."prod"."stg_decidim_forms_questions__dbt_tmp"
  
  
    as
  
  (
    

WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_forms_questions"
),
renamed AS (
    SELECT
        id,
        decidim_questionnaire_id,
        position,
        question_type,
        mandatory,
        body::jsonb->>'fr' AS body,
        description,
        max_choices,
        created_at,
        updated_at,
        max_characters
    FROM source
)
SELECT * FROM renamed
  );
  