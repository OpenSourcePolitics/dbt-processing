{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
      {'columns': ['resource_type'], 'type': 'btree'}
    ]
)}}

WITH coauthorships AS (
    SELECT 
        array_agg(decidim_users.id) AS authors_ids,
        decidim_coauthorships.coauthorable_id 
    FROM {{ ref("int_users")}} AS decidim_users 
    JOIN {{ ref("stg_decidim_coauthorships")}} AS decidim_coauthorships on decidim_users.id = decidim_coauthorships.decidim_author_id
    WHERE coauthorable_type = 'Decidim::Proposals::Proposal'
    GROUP BY coauthorable_id
), 
categorizations AS (
    {{ categorizations_filter('Decidim::Proposals::Proposal') }}
),
taxonomizations AS (
    {{ taxonomizables_select('Decidim::Proposals::Proposal') }}
),
scopes AS (
    {{ import_scopes_from_taxonomies('Decidim::Proposals::Proposal') }}
),
votes AS (
    SELECT
        decidim_proposal_id,
        COUNT(id) AS votes_count
    FROM {{ ref("stg_decidim_proposals_votes")}}
   GROUP BY decidim_proposal_id
),
proposals AS (
    SELECT
        decidim_proposals.id,
        decidim_components.ps_id AS decidim_participatory_space_id,
        decidim_components.ps_slug AS decidim_participatory_space_slug,
        (CASE WHEN scopes.is_scope
            THEN
            scopes.child_name
            ELSE
            decidim_scopes.name
        END) AS decidim_scope_name,
        decidim_proposals.title,
        decidim_proposals.body,
        decidim_proposals.resource_type,
        concat('https://', decidim_components.organization_host, '/', decidim_components.ps_space_type_slug, '/', decidim_components.ps_slug, '/f/', decidim_proposals.decidim_component_id, '/proposals/', decidim_proposals.id) AS url,
        decidim_proposals.decidim_component_id,
        decidim_proposals.created_at,
        decidim_proposals.published_at,
        decidim_proposals.state,
        COALESCE(decidim_proposals_proposal_states.title, decidim_proposals.translated_state) AS translated_state,
        coauthorships.authors_ids::text,
        COALESCE(coauthorships.authors_ids[1], -1) AS first_author_id,
        decidim_proposals.address,
        categorizations.categories::text,
        {{ categorization_first_category('categorizations.categories[1]') }},
        categorizations.sub_categories::text,
        {{ categorization_first_sub_category('categorizations.sub_categories[1]') }},
        taxonomizations.taxonomies::text,
        {{ taxonomization_first_taxonomy('taxonomizations.taxonomies[1]') }},
        taxonomizations.sub_taxonomies::text,
        {{ taxonomization_first_sub_taxonomy('taxonomizations.sub_taxonomies[1]') }},
        decidim_proposals.comments_count,
        decidim_proposals.endorsements_count,
        decidim_proposals.follows_count,
        COALESCE(votes.votes_count,0) AS votes_count,
        decidim_proposals_proposal_states.id::int AS custom_state_id, 
        decidim_proposals_proposal_states.title AS custom_state,
        decidim_proposals_proposal_states.description,
        decidim_proposals_proposal_states.proposals_count::int
    FROM {{ ref("int_proposals")}} AS decidim_proposals
    JOIN {{ ref("components")}} AS decidim_components ON decidim_components.id = decidim_proposals.decidim_component_id
    LEFT JOIN coauthorships ON decidim_proposals.id = coauthorships.coauthorable_id
    LEFT JOIN {{ ref("stg_decidim_moderations")}} AS decidim_moderations
        ON decidim_moderations.decidim_reportable_id = decidim_proposals.id
        AND decidim_moderations.decidim_reportable_type = 'Decidim::Proposals::Proposal'
    LEFT JOIN {{ ref("int_scopes")}} AS decidim_scopes ON decidim_scopes.id = decidim_proposals.decidim_scope_id
    LEFT JOIN votes ON decidim_proposals.id = votes.decidim_proposal_id
    LEFT JOIN categorizations ON categorizations.categorizable_id = decidim_proposals.id
    LEFT JOIN taxonomizations on taxonomizations.taxonomizable_id = decidim_proposals.id
    LEFT JOIN scopes on scopes.taxonomizable_id = decidim_proposals.id
    LEFT JOIN {{ ref("stg_decidim_proposals_custom_states")}} AS decidim_proposals_proposal_states ON decidim_proposals_proposal_states.id = decidim_proposals.decidim_proposals_proposal_state_id
    WHERE decidim_moderations.hidden_at IS NULL
    AND decidim_proposals.published_at IS NOT NULL
    AND (decidim_proposals.state NOT LIKE '%withdrawn' OR decidim_proposals.state IS NULL)
)

SELECT * FROM proposals