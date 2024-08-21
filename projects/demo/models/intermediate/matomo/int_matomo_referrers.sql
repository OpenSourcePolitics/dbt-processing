SELECT *,
    (CASE stg_matomo_referrers.label
        WHEN 'Mot clef indéfini' THEN 'Moteur de recherche'
    ELSE stg_matomo_referrers.label
    END
    ) AS renamed_label
FROM {{ref ("stg_matomo_referrers")}} as stg_matomo_referrers