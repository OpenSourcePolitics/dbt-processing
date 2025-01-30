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
    {{ int_meetings_translate_type_of_meeting('decidim_meetings.type_of_meeting') }} AS translated_type_of_meeting,
    decidim_meetings.private_meeting,
    decidim_meetings.decidim_author_id,
    decidim_meetings.resource_type
    FROM {{ ref ("stg_decidim_meetings")}} as decidim_meetings