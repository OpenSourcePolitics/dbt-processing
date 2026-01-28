{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_elections_votes'
) %}

{% if relation is not none %}
    SELECT
        id,
        question_id,
        response_option_id,
        voter_uid,
        created_at,
        updated_at
    FROM {{ source('decidim', 'decidim_elections_votes') }}
{% else %}
    SELECT
        CAST(NULL AS BIGINT) AS id,
        CAST(NULL AS BIGINT) AS question_id,
        CAST(NULL AS BIGINT) AS response_option_id,
        CAST(NULL AS TEXT) AS voter_uid,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at
    LIMIT 0
{% endif %}