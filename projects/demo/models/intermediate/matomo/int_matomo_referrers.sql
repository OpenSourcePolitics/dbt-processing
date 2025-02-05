SELECT
    label,
    nb_uniq_visitors,
    nb_visits,
    nb_actions,
    sum_visit_length,
    bounce_count,
    date,
    {{ int_matomo_referrers_translate_sub_type('sub_type') }} AS sub_type,
    {{ translate_renamed_label('stg_matomo_referrers.label') }} AS renamed_label
FROM {{ref ("stg_matomo_referrers")}} as stg_matomo_referrers