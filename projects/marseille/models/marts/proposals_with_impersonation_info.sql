SELECT 
    proposals.*
    --(CASE
    --WHEN proposals.created_at BETWEEN impersonations.started_at AND impersonations.ended_at THEN true ELSE false END
    --) AS authored_by_impersonation
FROM {{ ref("proposals") }} AS proposals
LEFT JOIN {{ ref("decidim_impersonation_logs") }} AS impersonations ON proposals.first_author_id = impersonations.user_id
    WHERE proposals.created_at BETWEEN impersonations.started_at AND impersonations.ended_at
    ORDER BY proposals.id