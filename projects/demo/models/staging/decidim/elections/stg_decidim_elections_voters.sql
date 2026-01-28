{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_elections_voters'
) %}

{% if relation is not none %}
    SELECT
        id,
        election_id,
        data,
        created_at,
        updated_at
    FROM {{ source('decidim', 'decidim_elections_voters') }}
{% else %}
    SELECT
        CAST(NULL AS BIGINT) AS id,
        CAST(NULL AS BIGINT) AS election_id,
        CAST(NULL AS JSONB) AS data,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at
    LIMIT 0
{% endif %}