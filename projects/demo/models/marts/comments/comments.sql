{{ config(
    indexes=[
      {'columns': ['decidim_author_id'], 'type': 'btree'},
    ]
)}}


{% set commentable_tables = [
    {"table": "stg_decidim_accountability_results", "type": "Decidim::Accountability::Result"},
    {"table": "blogs_posts", "type": "Decidim::Blogs::Post"},
    {"table": "budgets_projects", "type": "Decidim::Budgets::Project"},
    {"table": "debates", "type": "Decidim::Debates::Debate"},
    {"table": "meetings", "type": "Decidim::Meetings::Meeting"},
    {"table": "proposals", "type": "Decidim::Proposals::Proposal"},
    {"table": "stg_decidim_proposals_collaborative_drafts", "type": "Decidim::Proposals::CollaborativeDraft"}
] %}

WITH commentaries AS (
    {% for commentable in commentable_tables %}
    SELECT
        comments.*, 
        {{ ref(commentable.table) }}.decidim_component_id AS "decidim_component_id"
    FROM {{ ref(commentable.table) }}
    JOIN {{ ref("stg_decidim_comments") }} AS comments
        on comments.decidim_root_commentable_id = {{ ref(commentable.table) }}.id
        and comments.decidim_root_commentable_type = '{{ commentable.type }}'
    {% if not loop.last %} union all {% endif %}
    {% endfor %}
)

SELECT
    commentaries.id,
    commentaries.decidim_commentable_id,
    commentaries.decidim_commentable_type,
    commentaries.decidim_author_id,
    commentaries.created_at,
    commentaries.depth,
    commentaries.alignment,
    commentaries.decidim_root_commentable_id,
    commentaries.decidim_root_commentable_type,
    commentaries.decidim_author_type,
    commentaries.body,
    commentaries.decidim_component_id,
    components.ps_slug,
    concat('https://', components.organization_host, '/', components.ps_space_type_slug, '/', components.ps_slug, '/f/', components.id, '/', components.manifest_name,'/', commentaries.decidim_root_commentable_id, '?commentId=', commentaries.id, '#comment_', commentaries.id) AS comment_url
FROM commentaries
JOIN {{ ref('components') }} AS components
    on components.id = commentaries.decidim_component_id
LEFT JOIN {{ ref('stg_decidim_moderations') }} AS decidim_moderations
    on decidim_moderations.decidim_reportable_type = 'Decidim::Comments::Comment' 
    and decidim_moderations.decidim_reportable_id = commentaries.id
where decidim_moderations.hidden_at is null