{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
      {'columns': ['resource_type'], 'type': 'btree'}
    ]
)}}

SELECT
        all_proposals.id,
        all_proposals.decidim_participatory_space_id,
        all_proposals.decidim_participatory_space_slug,
        all_proposals.decidim_scope_name,
        all_proposals.title,
        all_proposals.body,
        all_proposals.resource_type,
        all_proposals.url,
        all_proposals.decidim_component_id,
        all_proposals.created_at,
        all_proposals.published_at,
        all_proposals.state,
        all_proposals.translated_state,
        all_proposals.authors_ids::text AS authors_ids,
        all_proposals.first_author_id,
        all_proposals.address,
        all_proposals.categories,
        all_proposals.first_category,
        all_proposals.sub_categories,
        all_proposals.first_sub_category,
        all_proposals.comments_count,
        all_proposals.endorsements_count,
        all_proposals.votes_count,
        all_proposals.hidden_at
FROM {{ ref("all_proposals")}} AS all_proposals
    WHERE all_proposals.hidden_at IS NULL
    AND all_proposals.published_at IS NOT NULL
    AND (all_proposals.state NOT LIKE '%withdrawn' OR all_proposals.state IS NULL)
