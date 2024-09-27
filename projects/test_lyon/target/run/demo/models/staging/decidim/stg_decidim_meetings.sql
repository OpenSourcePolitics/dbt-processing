
  
    

  create  table "test_lyon"."prod"."stg_decidim_meetings__dbt_tmp"
  
  
    as
  
  (
    WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_meetings_meetings"
),
renamed AS (
    SELECT
        id,
        title::jsonb->>'fr' AS title,
        regexp_replace(description::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') AS description,
        coalesce(nullif(address,''), 'Pas d''adresse') as address,
        coalesce(attendees_count, 0) as attendees_count,
        created_at,
        decidim_scope_id,
        decidim_component_id,
        start_time,
        end_time,
        registration_url,
        type_of_meeting,
        private_meeting,
        decidim_author_id,
        'Decidim::Meetings::Meeting' as resource_type
    FROM source
)
SELECT * FROM renamed
  );
  