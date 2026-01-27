{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_initiatives_type_scopes'
) %}

{% if relation is not none %}
    SELECT
        id,
        decidim_initiatives_types_id,
        decidim_scopes_id,
        supports_required,
        {{ get_column_if_exists(source('decidim', 'decidim_initiatives_type_scopes'), 'decidim_taxonomy_id', 'BIGINT') }},
        created_at,
        updated_at
    FROM {{ source('decidim', 'decidim_initiatives_type_scopes') }}
{% else %}
    SELECT
        CAST(NULL AS INTEGER) AS id,
        CAST(NULL AS INTEGER) AS decidim_initiatives_types_id,
        CAST(NULL AS INTEGER) AS decidim_scopes_id,
        CAST(NULL AS BOOLEAN) AS supports_required,
        CAST(NULL AS INTEGER) AS decidim_taxonomy_id,
        CAST(NULL AS TIMESTAMP) AS created_at,
        CAST(NULL AS TIMESTAMP) AS updated_at
    LIMIT 0
{% endif %}

