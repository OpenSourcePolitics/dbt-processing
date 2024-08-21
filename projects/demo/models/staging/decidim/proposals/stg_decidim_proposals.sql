SELECT
    id,
    regexp_replace(title::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as title,
    regexp_replace(body::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as body,
    'Decidim::Proposals::Proposal' as resource_type,
    decidim_component_id,
    decidim_scope_id,
    created_at,
    published_at,
    state,
    comments_count,
    endorsements_count,
    address
FROM {{ source('decidim', 'decidim_proposals_proposals') }}

