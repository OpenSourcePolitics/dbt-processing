
  
    

  create  table "test_lyon"."prod"."int_meetings__dbt_tmp"
  
  
    as
  
  (
    SELECT
    decidim_meetings.id,
    decidim_meetings.title,
    decidim_meetings.description,
    decidim_meetings.address,
    decidim_meetings.attendees_count,
    decidim_meetings.created_at,
    decidim_meetings.decidim_scope_id,
    decidim_meetings.decidim_component_id,
    decidim_meetings.start_time,
    decidim_meetings.end_time,
    decidim_meetings.registration_url,
    decidim_meetings.type_of_meeting, 
    (CASE decidim_meetings.type_of_meeting
        WHEN 'online' THEN 'En ligne'
        WHEN 'in_person' THEN 'En présentiel'
        WHEN 'hybrid' THEN 'Hybride'
        ELSE  decidim_meetings.type_of_meeting
        END
    ) AS translated_type_of_meeting,
    decidim_meetings.private_meeting,
    decidim_meetings.decidim_author_id,
    decidim_meetings.resource_type
    FROM "test_lyon"."prod"."stg_decidim_meetings" as decidim_meetings
  );
  