{% set lang = var('DBT_LANG', 'fr') %}

SELECT
    id,
    title::jsonb->>'{{ lang }}' AS title,
    regexp_replace(body::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') AS body,
    decidim_component_id,
    created_at,
    decidim_author_id,
    {{ get_column_if_exists(source('decidim', 'decidim_blogs_posts'), 'published_at', 'TIMESTAMP') }},
    {{ get_column_if_exists(source('decidim', 'decidim_blogs_posts'), 'deleted_at', 'TIMESTAMP') }},
    {{ coalesce_legacy_and_new_columns(source('decidim', 'decidim_blogs_posts'), 'endorsements_count', 'likes_count') }},
    'Decidim::Blogs::Post' AS resource_type
FROM {{ source('decidim', 'decidim_blogs_posts') }} 
