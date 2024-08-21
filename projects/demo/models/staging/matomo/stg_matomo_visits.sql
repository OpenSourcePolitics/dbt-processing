SELECT
    index,
    date,
    nb_visits,
    nb_uniq_visitors,
    bounce_count,
    bounce_rate,
    bounce_rate_new, 
    sum_visit_length, 
    nb_visits_new,
    nb_downloads
FROM {{ source('matomo', 'visits') }}
