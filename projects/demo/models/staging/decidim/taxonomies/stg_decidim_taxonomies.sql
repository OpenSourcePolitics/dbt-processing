{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_taxonomies'
) %}

{% set lang = var('DBT_LANG', 'fr') %}

{% if relation is not none %}
    SELECT
        id,
        regexp_replace(name::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as name,
        decidim_organization_id,
        parent_id,
        weight,
        children_count,
        taxonomizations_count,
        created_at,
        updated_at,
        filters_count,
        filter_items_count,
        part_of
    FROM {{ source('decidim', 'decidim_taxonomies') }}
{% else %}
    SELECT
        CAST(NULL AS BIGINT) AS id,
        CAST(NULL AS TEXT) AS name,
        CAST(NULL AS BIGINT) AS decidim_organization_id,
        CAST(NULL AS BIGINT) AS parent_id,
        CAST(NULL AS BIGINT) AS weight,
        CAST(NULL AS BIGINT) AS children_count,
        CAST(NULL AS BIGINT) AS taxonomizations_count,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at,
        CAST(NULL AS BIGINT) AS filters_count,
        CAST(NULL AS BIGINT) AS filter_items_count,
        CAST(NULL AS JSONB) AS part_of
    LIMIT 0
{% endif %}