SELECT
        date,
        nb_actions,
        bounce_count,
        {{ int_matomo_device_type_translate_label('label') }} AS label,
        sum_visit_length,
        nb_visits_converted,
        max_actions,
        segment,
        nb_visits,
        logo,
        nb_uniq_visitors,
        nb_users
FROM {{ref ("stg_matomo_device_type")}}
  