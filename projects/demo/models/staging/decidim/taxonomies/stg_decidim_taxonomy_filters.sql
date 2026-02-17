{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_taxonomy_filters'
) %}

{% set lang = var('DBT_LANG', 'fr') %}

{% if relation is not none %}
    SELECT
        id,
        root_taxonomy_id,
        filter_items_count,
        created_at,
        updated_at,
        components_count,
        regexp_replace(name::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as name,
        regexp_replace(internal_name::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as internal_name,
        participatory_space_manifests
    FROM {{ source('decidim', 'decidim_taxonomy_filters') }}
{% else %}
    SELECT
        CAST(NULL AS INTEGER) AS id,
        CAST(NULL AS INTEGER) AS root_taxonomy_id,
        CAST(NULL AS INTEGER) AS filter_items_count,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at,
        CAST(NULL AS INTEGER) AS components_count,
        CAST(NULL AS TEXT) AS name,
        CAST(NULL AS TEXT) AS internal_name,
        CAST(NULL AS JSONB) AS participatory_space_manifests
    LIMIT 0
{% endif %}