{% set relation = adapter.get_relation(
    database=target.database,
    schema='matomo',
    identifier='campaign_source_medium'
) %}

{% if relation is not none %}
    SELECT
        label,     
        nb_uniq_visitors,
        nb_visits,
        nb_actions,
        nb_users,
        max_actions,
        sum_visit_length,
        bounce_count,
        nb_visits_converted,
        campaign_name,
        date,
        campaign_source,
        campaign_medium
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
        CAST(NULL AS TEXT) AS campaign_name,
        CAST(NULL AS TIMESTAMP) AS date,
        CAST(NULL AS TEXT) AS campaign_source,
        CAST(NULL AS TEXT) AS campaign_medium
    LIMIT 0
{% endif %}
