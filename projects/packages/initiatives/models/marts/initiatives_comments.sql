{{ config(
    indexes=[
      {'columns': ['decidim_author_id'], 'type': 'btree'},
    ]
)}}

WITH commentaries AS (
    SELECT
        comments.*
    FROM {{ ref("stg_decidim_initiatives") }}
    JOIN {{ ref("stg_decidim_comments") }} AS comments
        on comments.decidim_root_commentable_id = {{ ref("stg_decidim_initiatives") }}.id
        and comments.decidim_root_commentable_type = 'Decidim::Initiative'
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
    concat('https://toto.caca', '/initiatives/i-', commentaries.decidim_commentable_id, '?commentId=', commentaries.id, '&initiative_slug=i-', commentaries.decidim_commentable_id) AS comment_url
    -- concat('https://', components.organization_host, '/', components.ps_space_type_slug, '/', components.ps_slug, '/f/', components.id, '/', components.manifest_name,'/', commentaries.decidim_root_commentable_id, '?commentId=', commentaries.id, '#comment_', commentaries.id) AS comment_url
FROM commentaries
LEFT JOIN {{ ref('stg_decidim_moderations') }} AS decidim_moderations
    on decidim_moderations.decidim_reportable_type = 'Decidim::Comments::Comment' 
    and decidim_moderations.decidim_reportable_id = commentaries.id
where decidim_moderations.hidden_at is null