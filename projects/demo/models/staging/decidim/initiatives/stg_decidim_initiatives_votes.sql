{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_initiatives_votes'
) %}

{% if relation is not none %}
    WITH source AS (
        SELECT * FROM {{ source('decidim', 'decidim_initiatives_votes') }}
    ),
    renamed AS (
        SELECT
            id,
            decidim_initiative_id,
            decidim_author_id,
            created_at,
            updated_at,
            encrypted_metadata,
            timestamp,
            hash_id,
            decidim_scope_id
        FROM source
    )
    SELECT * FROM renamed
{% else %}
    SELECT
        CAST(NULL AS INTEGER) AS id,
        CAST(NULL AS INTEGER) AS decidim_initiative_id,
        CAST(NULL AS INTEGER) AS decidim_author_id,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at,
        CAST(NULL AS TEXT) AS encrypted_metadata,
        CAST(NULL AS TIMESTAMP) AS timestamp,
        CAST(NULL AS TEXT) AS hash_id,
        CAST(NULL AS INTEGER) AS decidim_scope_id
    LIMIT 0
{% endif %}

  