SELECT
    date,
    nb_visits,
    nb_hits,
    sum_time_spent,
    index,
    nb_uniq_visitors,
    label, 
    url
FROM {{ source('matomo', 'downloads') }}