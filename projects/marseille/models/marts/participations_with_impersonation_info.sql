WITH participations_under_impersonation AS (
    SELECT
       participations.participation_id AS pid
    FROM {{ ref('participations') }} as participations
    LEFT JOIN {{ ref('stg_decidim_impersonation_logs') }} AS impersonations ON participations.user_id = impersonations.user_id
    WHERE participations.participation_date BETWEEN impersonations.started_at AND impersonations.ended_at
    ORDER BY participations.participation_id
)

SELECT
    *,
    (CASE WHEN participations_under_impersonation.pid IS NOT NULL THEN true ELSE false END) AS authored_under_impersonation
FROM {{ ref('participations') }} AS participations
LEFT JOIN participations_under_impersonation ON participations.participation_id = participations_under_impersonation.pid