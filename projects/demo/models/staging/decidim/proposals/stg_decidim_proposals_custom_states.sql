{% set lang = var('DBT_LANG', 'fr') %}

{% set relation = adapter.get_relation(
    database=target.database,
    schema='public',
    identifier='decidim_proposals_proposal_states'
) %}

{% if relation is not none %}
SELECT
    id,
    token,
	title::jsonb->>'{{ lang }}' AS title,
	description,
	decidim_component_id,
	proposals_count
FROM {{ source('decidim', 'decidim_proposals_proposal_states') }} 
{% else %}
    SELECT
    	CAST(NULL AS INTEGER) AS id,
    	CAST(NULL AS TEXT) AS token,
		CAST(NULL AS TEXT) AS title,
		CAST(NULL AS TEXT) AS description,
		CAST(NULL AS INTEGER) AS decidim_component_id,
		CAST(NULL AS INTEGER) AS proposals_count
    LIMIT 0
{% endif %}