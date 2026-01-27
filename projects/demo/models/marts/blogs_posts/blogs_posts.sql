WITH taxonomizations AS (
    {{ taxonomizables_select('Decidim::Blogs::Post') }}
)

SELECT
    decidim_blogs_posts.id,
    decidim_blogs_posts.title,
    decidim_blogs_posts.body,
    decidim_blogs_posts.decidim_component_id,
    decidim_blogs_posts.created_at,
    decidim_blogs_posts.decidim_author_id,
    decidim_blogs_posts.resource_type,
    concat('https://', decidim_components.organization_host, '/', decidim_components.ps_space_type_slug, '/', decidim_components.ps_slug, '/f/', decidim_components.id, '/posts/', decidim_blogs_posts.id) AS post_url,
    taxonomizations.taxonomies::text,
    {{ taxonomization_first_taxonomy('taxonomizations.taxonomies[1]') }},
    taxonomizations.sub_taxonomies::text,
    {{ taxonomization_first_sub_taxonomy('taxonomizations.sub_taxonomies[1]') }}
FROM {{ ref ("stg_decidim_blogs_posts")}} AS decidim_blogs_posts
JOIN {{ ref ("components")}} AS decidim_components ON decidim_components.id = decidim_component_id
LEFT JOIN taxonomizations on taxonomizations.taxonomizable_id = decidim_blogs_posts.id
WHERE decidim_blogs_posts.deleted_at IS NULL
