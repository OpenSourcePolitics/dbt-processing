WITH proposals_under_impersonation AS (
    SELECT 
    proposals.id AS proposal_id
    FROM {{ ref("proposals") }} AS proposals
    LEFT JOIN {{ ref("decidim_impersonation_logs") }} AS impersonations ON proposals.first_author_id = impersonations.user_id
    WHERE proposals.created_at BETWEEN impersonations.started_at AND impersonations.ended_at
    ORDER BY proposals.id
)

SELECT
    *,
    (CASE WHEN proposals_under_impersonation.proposal_id IS NOT NULL THEN true ELSE false END) AS authored_under_impersonation
FROM {{ ref("proposals") }} AS proposals
LEFT JOIN proposals_under_impersonation ON proposals.id = proposals_under_impersonation.proposal_id