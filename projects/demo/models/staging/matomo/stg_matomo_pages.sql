SELECT 
    nb_visits::int, 
    nb_uniq_visitors::int,
    nb_hits,
    sum_time_spent,
    coalesce(exit_nb_uniq_visitors::float::int, 0) AS exit_nb_uniq_visitors,
    coalesce(exit_nb_visits::float::int, 0) as exit_nb_visits,
    avg_time_on_page, 
    bounce_rate, 
    exit_rate,
    url,
    date,
    coalesce(entry_nb_uniq_visitors::float::int, 0) as entry_nb_uniq_visitors,
    coalesce(entry_nb_visits::float::int, 0) as entry_nb_visits,
    coalesce(entry_bounce_count::float::int, 0) as entry_bounce_count,
    label
FROM {{ source('matomo', 'pages') }}