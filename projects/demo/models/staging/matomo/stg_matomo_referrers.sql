SELECT 
    label, 
    nb_uniq_visitors,
    nb_visits,
    nb_actions,
    sum_visit_length,
    bounce_count,
    date
FROM {{ source('matomo', 'referrers') }}