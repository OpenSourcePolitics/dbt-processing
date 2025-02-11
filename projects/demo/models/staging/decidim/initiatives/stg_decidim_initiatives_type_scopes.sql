{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_initiatives_type_scopes'
) %}

{% if relation is not none %}
    WITH source AS (
        SELECT * FROM {{ source('decidim', 'decidim_initiatives_type_scopes') }}
    ),
    renamed AS (
        SELECT
            id,
            decidim_initiatives_types_id,
            decidim_scopes_id,
            supports_required,
            created_at,
            updated_at
        FROM source
    )
    SELECT * FROM renamed
{% else %}
    SELECT
        CAST(NULL AS INTEGER) AS id,
        CAST(NULL AS INTEGER) AS decidim_initiatives_types_id,
        CAST(NULL AS INTEGER) AS decidim_scopes_id,
        CAST(NULL AS BOOLEAN) AS supports_required,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at
    LIMIT 0
{% endif %}
