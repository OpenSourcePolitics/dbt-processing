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
    {{ int_proposals_translate_default_state('decidim_proposals.state') }} AS state,
    {{ int_proposals_translate_proposal_state('decidim_proposals.state') }} AS translated_state,
    decidim_proposals.comments_count,
    decidim_proposals.endorsements_count,
    COALESCE(NULLIF(decidim_proposals.address,''),'Pas d''adresse') AS address
FROM {{ ref ("stg_decidim_proposals")}} AS decidim_proposals
WHERE published_at IS NOT NULL
