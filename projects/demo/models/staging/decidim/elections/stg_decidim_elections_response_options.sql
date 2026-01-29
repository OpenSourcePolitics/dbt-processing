{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_elections_response_options'
) %}

{% if relation is not none %}
    SELECT
        id,
        question_id,
        body,
        created_at,
        updated_at,
        votes_count
    FROM {{ source('decidim', 'decidim_elections_response_options') }}
{% else %}
    SELECT
        CAST(NULL AS BIGINT) AS id,
        CAST(NULL AS BIGINT) AS question_id,
        CAST(NULL AS JSONB) AS body,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at,
        CAST(NULL AS BIGINT) AS votes_count
    LIMIT 0
{% endif %}