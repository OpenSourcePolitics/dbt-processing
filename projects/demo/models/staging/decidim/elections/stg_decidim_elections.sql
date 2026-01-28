{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_elections_elections'
) %}

{% if relation is not none %}
    SELECT
        id,
        decidim_component_id,
        title,
        description,
        announcement,
        start_at,
        end_at,
        results_availability,
        published_at,
        deleted_at,
        created_at,
        updated_at,
        census_manifest,
        census_settings,
        published_results_at,
        votes_count,
    FROM {{ source('decidim', 'decidim_elections_elections') }}
{% else %}
    SELECT
        CAST(NULL AS BIGINT) AS id,
        CAST(NULL AS BIGINT) AS decidim_component_id,
        CAST(NULL AS JSONB) AS title,
        CAST(NULL AS JSONB) AS description,
        CAST(NULL AS JSONB) AS announcement,
        CAST(NULL AS TIMESTAMP) AS start_at,
        CAST(NULL AS TIMESTAMP) AS end_at,
        CAST(NULL AS TEXT) AS results_availability,
        CAST(NULL AS TIMESTAMP) AS published_at,
        CAST(NULL AS TIMESTAMP) AS deleted_at,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at,
        CAST(NULL AS TEXT) AS census_manifest,
        CAST(NULL AS JSONB) AS census_settings,
        CAST(NULL AS TIMESTAMP) AS published_results_at,
        CAST(NULL AS BIGINT) AS votes_count
    LIMIT 0
{% endif %}