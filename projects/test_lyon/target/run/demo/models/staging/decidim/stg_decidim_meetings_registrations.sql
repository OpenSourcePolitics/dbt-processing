
  
    

  create  table "test_lyon"."prod"."stg_decidim_meetings_registrations__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_meetings_registrations"
),
renamed AS (
    select
        id,
        decidim_user_id,
        decidim_meeting_id,
        created_at,
        updated_at,
        code,
        validated_at,
        decidim_user_group_id
    FROM source
)
select * FROM renamed
  );
  