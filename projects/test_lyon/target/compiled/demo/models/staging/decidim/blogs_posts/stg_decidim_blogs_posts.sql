WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_blogs_posts"
),
renamed AS (
    SELECT
        id,
        title::jsonb->>'fr' AS title,
        regexp_replace(body::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') AS body,
        decidim_component_id,
        created_at,
        decidim_author_id,
        'Decidim::Blogs::Post' AS resource_type
    FROM source 
)
SELECT * FROM renamed