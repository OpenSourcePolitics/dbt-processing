WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_participatory_processes') }}
),
renamed AS (
    SELECT 
        id, 
        published_at, 
        title::jsonb->>'fr' AS title,
        subtitle::jsonb->>'fr' as subtitle, 
        slug, 
        'Decidim::ParticipatoryProcess' as type,
        'processes' as space_type_slug,
        decidim_organization_id
    FROM source
)
SELECT * FROM renamed
