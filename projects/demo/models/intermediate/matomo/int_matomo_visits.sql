SELECT
    date,
    nb_visits,
    nb_uniq_visitors,
    bounce_count,
    bounce_rate,
    bounce_rate_new,
    sum_visit_length,
    nb_visits_new,
    nb_downloads,
    bounce_count::decimal / NULLIF(nb_visits, 0) AS bounce_rate_as_number,
    sum_visit_length / NULLIF(nb_visits, 0) as daily_average_visit_length
FROM {{ref ("stg_matomo_visits")}}