{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_reports'
) %}

{% if relation is not none %}
SELECT
    id,
    decidim_moderation_id,
    decidim_user_id,
    reason,
    details,
    created_at,
    updated_at,
    locale
FROM {{ source('decidim', 'decidim_reports') }}
{% else %}
    SELECT
    	CAST(NULL AS BIGINT) AS id,
    	CAST(NULL AS BIGINT) AS decidim_moderation_id,
    	CAST(NULL AS BIGINT) AS decidim_user_id,
    	CAST(NULL AS TEXT) AS reason,
		CAST(NULL AS TEXT) AS details,
		CAST(NULL AS TIMESTAMP) AS created_at,
		CAST(NULL AS TIMESTAMP) AS updated_at,
		CAST(NULL AS TEXT) AS locale
    LIMIT 0
{% endif %}