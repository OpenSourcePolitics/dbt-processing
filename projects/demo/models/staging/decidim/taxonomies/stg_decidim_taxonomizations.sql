{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_taxonomizations'
) %}

{% if relation is not none %}
    SELECT
        id,
        taxonomy_id,
        taxonomizable_type,
        taxonomizable_id,
        created_at,
        updated_at
    FROM {{ source('decidim', 'decidim_taxonomizations') }}
{% else %}
    SELECT
        CAST(NULL AS BIGINT) AS id,
        CAST(NULL AS BIGINT) AS taxonomy_id,
        CAST(NULL AS TEXT) AS taxonomizable_type,
        CAST(NULL AS BIGINT) AS taxonomizable_id,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at
    LIMIT 0
{% endif %}