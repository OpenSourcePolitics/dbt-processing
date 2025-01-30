WITH categorizations AS (
    {{ categorizations_filter('Decidim::Meetings::Meeting') }}
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
    categorizations.sub_categories,
    {{ translate_first_category_and_sub_category('categorizations.categories', 'categorizations.sub_categories') }}
FROM {{ ref("int_meetings")}} AS decidim_meetings_meetings
JOIN {{ ref("components")}} decidim_components on decidim_components.id = decidim_component_id
LEFT JOIN categorizations on categorizations.categorizable_id = decidim_meetings_meetings.id
where manifest_name like 'meetings'