SELECT 
    label, 
    nb_uniq_visitors,
    nb_visits,
    nb_actions,
    sum_visit_length,
    bounce_count,
    --sub_type, 
    date
FROM {{ source('matomo', 'referrers') }}
--WHERE sub_type IS NOT null