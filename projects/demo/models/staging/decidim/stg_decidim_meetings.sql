{% set lang = var('DBT_LANG', 'fr') %}

SELECT
    id,
    title::jsonb->>'{{ lang }}' AS title,
    regexp_replace(description::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') AS description,
    coalesce(nullif(address,''), 'Pas d''adresse') as address,
    coalesce(attendees_count, 0) as attendees_count,
    created_at,
    {{ get_column_if_exists(source('decidim', 'decidim_proposals_proposals'), 'withdrawn_at', 'TIMESTAMP') }},
    decidim_scope_id,
    decidim_component_id,
    start_time,
    end_time,
    registration_url,
    type_of_meeting,
    private_meeting,
    decidim_author_id,
    'Decidim::Meetings::Meeting' as resource_type
FROM {{ source('decidim', 'decidim_meetings_meetings') }}