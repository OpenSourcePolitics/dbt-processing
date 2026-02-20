WITH categorizations AS (
    {{ categorizations_filter('Decidim::Meetings::Meeting') }}
),
taxonomizations AS (
    {{ taxonomizables_select('Decidim::Meetings::Meeting') }}
),
scopes AS (
    {{ import_scopes_from_taxonomies('Decidim::Meetings::Meeting') }}
)
SELECT
    decidim_meetings_meetings.id,
    decidim_meetings_meetings.title,
    decidim_meetings_meetings.description,
    decidim_meetings_meetings.address,
    decidim_meetings_meetings.attendees_count,
    decidim_meetings_meetings.created_at,
    (CASE WHEN scopes.is_scope
        THEN
        scopes.child_name
        ELSE
        decidim_scopes.name
    END) AS decidim_scope_name,
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
    {{ categorization_first_category('categorizations.categories[1]') }},
    categorizations.sub_categories,
    {{ categorization_first_sub_category('categorizations.sub_categories[1]') }},
    taxonomizations.taxonomies,
    {{ taxonomization_first_taxonomy('taxonomizations.taxonomies[1]') }},
    taxonomizations.sub_taxonomies,
    {{ taxonomization_first_sub_taxonomy('taxonomizations.sub_taxonomies[1]') }}
FROM {{ ref("int_meetings")}} AS decidim_meetings_meetings
JOIN {{ ref("components")}} decidim_components on decidim_components.id = decidim_component_id
LEFT JOIN categorizations on categorizations.categorizable_id = decidim_meetings_meetings.id
LEFT JOIN taxonomizations on taxonomizations.taxonomizable_id = decidim_meetings_meetings.id
LEFT JOIN scopes on scopes.taxonomizable_id = decidim_meetings_meetings.id
LEFT JOIN {{ ref("int_scopes")}} AS decidim_scopes ON decidim_scopes.id = decidim_meetings_meetings.decidim_scope_id
WHERE manifest_name like 'meetings'
AND decidim_meetings_meetings.deleted_at IS NULL