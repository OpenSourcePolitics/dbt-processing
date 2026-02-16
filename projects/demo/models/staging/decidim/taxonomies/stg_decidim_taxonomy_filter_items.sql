{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_taxonomy_filter_items'
) %}

{% if relation is not none %}
    SELECT
        id,
        taxonomy_filter_id,
        taxonomy_item_id,
        created_at,
        updated_at
    FROM {{ source('decidim', 'decidim_taxonomy_filter_items') }}
{% else %}
    SELECT
        CAST(NULL AS INTEGER) AS id,
        CAST(NULL AS INTEGER) AS taxonomy_filter_id,
        CAST(NULL AS INTEGER) AS taxonomy_item_id,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at
    LIMIT 0
{% endif %}