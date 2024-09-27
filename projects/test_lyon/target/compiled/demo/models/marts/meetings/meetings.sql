WITH categorizations AS (
    
    SELECT 
        array_agg(category_name) AS categories,
        array_agg(child_name) AS sub_categories,
        categorizable_id
    FROM "test_lyon"."prod"."categorizations" AS categorizations
    WHERE categorizations.categorizable_type = 'Decidim::Meetings::Meeting'
    GROUP BY categorizable_id 

)
SELECT
    decidim_meetings_meetings.id,
    decidim_meetings_meetings.title,
    decidim_meetings_meetings.description,
    decidim_meetings_meetings.address,
    decidim_meetings_meetings.attendees_count,
    decidim_meetings_meetings.created_at,
    decidim_meetings_meetings.decidim_scope_id,
    decidim_meetings_meetings.decidim_component_id,
    decidim_meetings_meetings.start_time,
    decidim_meetings_meetings.end_time,
    decidim_meetings_meetings.registration_url,
    decidim_meetings_meetings.type_of_meeting, 
    decidim_meetings_meetings.translated_type_of_meeting,
    decidim_meetings_meetings.private_meeting,
    decidim_meetings_meetings.decidim_author_id,
    decidim_meetings_meetings.resource_type,
    concat(
        'https://',
        decidim_components.organization_host,
        '/',
        decidim_components.ps_space_type_slug,
        '/',
        decidim_components.ps_slug,
        '/f/',
        decidim_meetings_meetings.decidim_component_id,
        '/meetings/',
        decidim_meetings_meetings.id
    ) AS meeting_url,
    categorizations.categories,
    coalesce(categorizations.categories[1], 'Sans catégorie') AS first_category,
    categorizations.sub_categories,
    coalesce(categorizations.sub_categories[1], 'Sans sous-catégorie') AS first_sub_category
FROM "test_lyon"."prod"."int_meetings" AS decidim_meetings_meetings
JOIN "test_lyon"."prod"."components" decidim_components on decidim_components.id = decidim_component_id
LEFT JOIN categorizations on categorizations.categorizable_id = decidim_meetings_meetings.id
where manifest_name like 'meetings'