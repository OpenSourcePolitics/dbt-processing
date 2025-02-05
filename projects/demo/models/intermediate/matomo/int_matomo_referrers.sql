SELECT *,
     {{ translate_renamed_label('stg_matomo_referrers.label') }} AS renamed_label
FROM {{ref ("stg_matomo_referrers")}} as stg_matomo_referrers