SELECT 
    label, 
    nb_uniq_visitors,
    nb_visits,
    nb_actions,
    sum_visit_length,
    bounce_count,
    label as sub_type,
    date
FROM {{ source('matomo', 'referrers') }}
WHERE label IS NOT NULL