{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_initiatives_votes'
) %}

{% if relation is not none %}
    SELECT
        id,
        decidim_initiative_id,
        decidim_author_id as user_id,
        created_at,
        updated_at,
        encrypted_metadata,
        timestamp,
        hash_id,
        decidim_scope_id
    FROM {{ source('decidim', 'decidim_initiatives_votes') }}
{% else %}
    SELECT
        CAST(NULL AS INTEGER) AS id,
        CAST(NULL AS INTEGER) AS decidim_initiative_id,
        CAST(NULL AS INTEGER) AS user_id,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at,
        CAST(NULL AS TEXT) AS encrypted_metadata,
        CAST(NULL AS TIMESTAMP) AS timestamp,
        CAST(NULL AS TEXT) AS hash_id,
        CAST(NULL AS INTEGER) AS decidim_scope_id
    LIMIT 0
{% endif %}
