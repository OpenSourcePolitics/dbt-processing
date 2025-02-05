{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_blogs_posts') }}
),
renamed AS (
    SELECT
        id,
        title::jsonb->>'{{ lang }}' AS title,
        regexp_replace(body::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') AS body,
        decidim_component_id,
        created_at,
        decidim_author_id,
        'Decidim::Blogs::Post' AS resource_type
    FROM source 
)
SELECT * FROM renamed
        
