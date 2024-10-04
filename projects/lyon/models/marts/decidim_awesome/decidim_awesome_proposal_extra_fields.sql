SELECT
    decidim_awesome_proposal_extra_fields.id,
    decidim_awesome_proposal_extra_fields.proposal_id,
    MAX(CASE 
        WHEN decidim_awesome_proposal_extra_fields.private_field_description = 'Cette idée est déposée à titre :' 
        THEN decidim_awesome_proposal_extra_fields.private_field_content 
        END) AS description_content,
    MAX(CASE 
        WHEN decidim_awesome_proposal_extra_fields.private_field_description = 'Votre tranche d age :' 
        THEN decidim_awesome_proposal_extra_fields.private_field_content 
        END) AS age_range_content
FROM
    {{ ref("int_decidim_awesome_proposal_extra_fields") }} AS decidim_awesome_proposal_extra_fields
JOIN {{ ref("stg_decidim_proposals") }} AS decidim_proposals ON 
    decidim_awesome_proposal_extra_fields.proposal_id = decidim_proposals.id
GROUP BY 
    decidim_awesome_proposal_extra_fields.id,
    decidim_awesome_proposal_extra_fields.proposal_id
