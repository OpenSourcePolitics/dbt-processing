SELECT
        date,
        nb_actions,
        bounce_count,
        label,
        sum_visit_length,
        nb_visits_converted,
        max_actions,
        segment,
        nb_visits,
        logo,
        nb_uniq_visitors,
        nb_users
FROM {{ source('matomo', 'device_type') }}

  