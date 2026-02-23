WITH
taxonomizations AS (
    {{ taxonomizables_select('Decidim::Meetings::Meeting') }}
),
scopes_from_taxonomies AS (
    {{ import_scopes_from_taxonomies('Decidim::Meetings::Meeting') }}
),
categories_from_taxonomies AS (
    {{ import_categories_from_taxonomies('Decidim::Meetings::Meeting') }}
),
categorizations AS (
    {{ categorizations_filter('Decidim::Meetings::Meeting') }}
),
categories_final AS (
    SELECT
        id,
        COALESCE(categories_from_taxonomies.categories, categorizations.categories) AS categories,
        COALESCE(categories_from_taxonomies.sub_categories, categorizations.sub_categories) AS sub_categories
    FROM {{ ref("int_meetings")}} AS decidim_meetings_meetings
    LEFT JOIN categories_from_taxonomies on categories_from_taxonomies.taxonomizable_id = decidim_meetings_meetings.id
    LEFT JOIN categorizations ON categorizations.categorizable_id = decidim_meetings_meetings.id
)
SELECT
    decidim_meetings_meetings.id,
    decidim_meetings_meetings.title,
    decidim_meetings_meetings.description,
    decidim_meetings_meetings.address,
    decidim_meetings_meetings.attendees_count,
    decidim_meetings_meetings.created_at,
    COALESCE(scopes_from_taxonomies.child_name, decidim_scopes.name) AS decidim_scope_name,
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
    categories_final.categories,
    {{ categorization_first_category('categories_final.categories[1]') }} AS first_category,
    categories_final.sub_categories,
    {{ categorization_first_sub_category('categories_final.sub_categories[1]') }} AS first_sub_category,
    taxonomizations.taxonomies,
    {{ taxonomization_first_taxonomy('taxonomizations.taxonomies[1]') }},
    taxonomizations.sub_taxonomies,
    {{ taxonomization_first_sub_taxonomy('taxonomizations.sub_taxonomies[1]') }}
FROM {{ ref("int_meetings")}} AS decidim_meetings_meetings
JOIN {{ ref("components")}} decidim_components on decidim_components.id = decidim_component_id
LEFT JOIN taxonomizations on taxonomizations.taxonomizable_id = decidim_meetings_meetings.id
LEFT JOIN scopes_from_taxonomies on scopes_from_taxonomies.taxonomizable_id = decidim_meetings_meetings.id
LEFT JOIN categories_from_taxonomies on categories_from_taxonomies.taxonomizable_id = decidim_meetings_meetings.id
LEFT JOIN categorizations on categorizations.categorizable_id = decidim_meetings_meetings.id
LEFT JOIN categories_final ON categories_final.id = decidim_meetings_meetings.id
LEFT JOIN {{ ref("int_scopes")}} AS decidim_scopes ON decidim_scopes.id = decidim_meetings_meetings.decidim_scope_id
WHERE manifest_name like 'meetings'
AND decidim_meetings_meetings.deleted_at IS NULL