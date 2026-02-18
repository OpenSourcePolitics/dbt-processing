{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_debates_debates') }}
),
renamed AS (
    SELECT
        id,
        title::jsonb->> '{{ lang }}' as title,
        regexp_replace(description::jsonb->> '{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as description,
        start_time,
        end_time,
        decidim_component_id,
        decidim_scope_id,
        decidim_author_id,
        created_at,
        closed_at,
        {{ get_column_if_exists(source('decidim', 'decidim_debates_debates'), 'deleted_at', 'TIMESTAMP') }},
        {{ coalesce_legacy_and_new_columns(source('decidim', 'decidim_debates_debates'), 'endorsements_count', 'likes_count') }},
        {{ get_column_if_exists(source('decidim', 'decidim_debates_debates'), 'comments_layout', 'TEXT') }},
        'Decidim::Debates::Debate' as resource_type
    FROM source 
)
SELECT * FROM renamed