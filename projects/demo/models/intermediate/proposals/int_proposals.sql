{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
    ]
)}}

SELECT
    decidim_proposals.id,
    decidim_proposals.title,
    decidim_proposals.body,
    decidim_proposals.resource_type,
    decidim_proposals.decidim_component_id,
    decidim_proposals.decidim_scope_id,
    decidim_proposals.created_at,
    decidim_proposals.published_at,
    COALESCE(NULLIF(decidim_proposals.state, NULL), 'Pas d''état') AS state,
    (CASE
        WHEN decidim_proposals.state = 'evaluating' THEN 'En cours d''évaluation'
        WHEN decidim_proposals.state = 'rejected' THEN 'Rejetée'
        WHEN decidim_proposals.state = 'accepted' THEN 'Acceptée'
        WHEN decidim_proposals.state IS NULL THEN 'Pas d''état'
        ELSE decidim_proposals.state
        END
    ) AS translated_state,
    decidim_proposals.comments_count,
    decidim_proposals.endorsements_count,
    COALESCE(NULLIF(decidim_proposals.address,''),'Pas d''adresse') AS address
FROM {{ ref ("stg_decidim_proposals")}} AS decidim_proposals
WHERE published_at IS NOT NULL
