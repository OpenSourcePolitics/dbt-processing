select 
    propositions.*,
    (CASE
        WHEN propositions.created_at BETWEEN impersonations.started_at AND impersonations.ended_at THEN true ELSE false END
    ) AS authored_by_impersonation
from {{ ref("proposals") }} as propositions
join {{ ref("decidim_impersonation_logs") }} as impersonations on propositions.first_author_id = impersonations.user_id
    order by propositions.id