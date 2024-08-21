WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_debates_debates') }}
),
renamed AS (
    SELECT
        id,
        title::jsonb->>'fr' as title,
        regexp_replace(description::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as description,
        start_time,
        end_time,
        decidim_component_id,
        decidim_author_id,
        created_at,
        closed_at,
        'Decidim::Debates::Debate' as resource_type
    FROM source 
)
SELECT * FROM renamed