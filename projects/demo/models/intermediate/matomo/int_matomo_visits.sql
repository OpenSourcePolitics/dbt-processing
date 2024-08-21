SELECT
    *,
    bounce_count::decimal / nb_visits as bounce_rate_as_number,
    sum_visit_length / nb_visits as daily_average_visit_length
FROM {{ref ("stg_matomo_visits")}}