{% set relation = adapter.get_relation(
    database=target.database,
    schema='matomo',
    identifier='campaign_source_medium'
) %}

{% if relation is not none %}
    SELECT
        label,
        nb_users,
        nb_visits,
        nb_actions,
        max_actions,
        bounce_count,
        campaign_medium,
        campaign_source,
        nb_uniq_visitors,
        sum_visit_length,
        nb_visits_converted,
        date
    FROM {{ source('matomo', 'campaign_source_medium') }}
{% else %}
    SELECT
        CAST(NULL AS TEXT) AS label,
        CAST(NULL AS INTEGER) AS nb_uniq_visitors,
        CAST(NULL AS INTEGER) AS nb_visits,
        CAST(NULL AS INTEGER) AS nb_actions,
        CAST(NULL AS INTEGER) AS nb_users,
        CAST(NULL AS INTEGER) AS max_actions,
        CAST(NULL AS INTEGER) AS sum_visit_length,
        CAST(NULL AS INTEGER) AS bounce_count,
        CAST(NULL AS INTEGER) AS nb_visits_converted,
        CAST(NULL AS TIMESTAMP) AS date,
        CAST(NULL AS TEXT) AS campaign_source,
        CAST(NULL AS TEXT) AS campaign_medium
    LIMIT 0
{% endif %}
