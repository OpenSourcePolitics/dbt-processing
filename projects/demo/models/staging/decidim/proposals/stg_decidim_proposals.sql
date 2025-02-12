{% set lang = var('DBT_LANG', 'fr') %}

SELECT
    id,
    regexp_replace(title::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as title,
    regexp_replace(body::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as body,
    'Decidim::Proposals::Proposal' as resource_type,
    decidim_component_id,
    decidim_scope_id,
    created_at,
    published_at,
    state,
    comments_count,
    endorsements_count,
    address,
    {{ get_column_if_exists(source('decidim', 'decidim_proposals_proposals'), 'decidim_proposals_proposal_state_id') }}
FROM {{ source('decidim', 'decidim_proposals_proposals') }}