{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_elections_questions'
) %}

{% if relation is not none %}
    SELECT
        id,
        election_id,
        body,
        description,
        mandatory,
        question_type,
        multiple_option,
        position,
        created_at,
        updated_at,
        published_results_at,
        voting_enabled_at,
        votes_count,
        response_options_count
    FROM {{ source('decidim', 'decidim_elections_questions') }}
{% else %}
    SELECT
        CAST(NULL AS BIGINT) AS id,
        CAST(NULL AS BIGINT) AS election_id,
        CAST(NULL AS JSONB) AS body,
        CAST(NULL AS JSONB) AS description,
        CAST(NULL AS BOOLEAN) AS mandatory,
        CAST(NULL AS TEXT) AS question_type,
        CAST(NULL AS BIGINT) AS position,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at,
        CAST(NULL AS TIMESTAMP) AS published_results_at,
        CAST(NULL AS TIMESTAMP) AS voting_enabled_at,
        CAST(NULL AS BIGINT) AS votes_count,
        CAST(NULL AS BIGINT) AS response_options_count
    LIMIT 0
{% endif %}