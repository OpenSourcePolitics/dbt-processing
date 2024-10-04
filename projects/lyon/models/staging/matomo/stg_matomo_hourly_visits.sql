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
    VisitTime_LocalTime,
    segment,
    date
FROM {{ source('matomo', 'hourly_visits') }}