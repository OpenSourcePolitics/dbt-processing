SELECT
    decidim_awesome_private_proposal_fields.id,
    decidim_awesome_private_proposal_fields.proposal_id,
    decidim_awesome_private_proposal_fields.private_field_description,
    decidim_awesome_private_proposal_fields.private_field_content,
    decidim_proposals_proposals.decidim_component_id
FROM
    {{ ref ("int_decidim_awesome_private_proposal_fields")}} AS decidim_awesome_private_proposal_fields
JOIN decidim_proposals_proposals ON decidim_awesome_private_proposal_fields.proposal_id = decidim_proposals_proposals.id