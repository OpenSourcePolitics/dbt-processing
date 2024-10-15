SELECT
    id,
    token,
	title::jsonb->>'fr' AS title,
	description,
	decidim_component_id,
	proposals_count
FROM {{ source('decidim', 'decidim_proposals_proposal_states') }} 
