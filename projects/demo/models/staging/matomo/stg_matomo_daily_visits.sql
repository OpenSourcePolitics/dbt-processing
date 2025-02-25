{% set relation = adapter.get_relation(
    database=target.database,
    schema='matomo',
    identifier='daily_visits'
) %}

{% if relation is not none %}
    SELECT
        label,
        nb_uniq_visitors,
        nb_visits,
        day_of_week,
        visittime_dayoftheweek,
        nb_actions,
        nb_users,
        sum_visit_length,
        bounce_count,
        nb_visits_converted,
        date
    FROM {{ source('matomo', 'daily_visits') }}
{% else %}
    SELECT
    	CAST(NULL AS TEXT) AS label,
    	CAST(NULL AS INTEGER) AS nb_uniq_visitors,
		CAST(NULL AS INTEGER) AS nb_visits,
		CAST(NULL AS INTEGER) AS day_of_week,
		CAST(NULL AS TEXT) AS visittime_dayoftheweek,
		CAST(NULL AS INTEGER) AS nb_actions,
		CAST(NULL AS INTEGER) AS nb_users,
		CAST(NULL AS INTEGER) AS sum_visit_length,
		CAST(NULL AS INTEGER) AS bounce_count,
		CAST(NULL AS INTEGER) AS nb_visits_converted,
		CAST(NULL AS TIMESTAMP) AS date
    LIMIT 0
{% endif %}



