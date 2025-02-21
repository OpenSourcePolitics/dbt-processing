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

