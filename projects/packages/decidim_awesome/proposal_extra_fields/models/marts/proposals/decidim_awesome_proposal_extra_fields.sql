SELECT
    decidim_awesome_proposal_extra_fields.id,
    decidim_awesome_proposal_extra_fields.proposal_id,
    decidim_awesome_proposal_extra_fields.private_field_description,
    decidim_awesome_proposal_extra_fields.private_field_content,
    decidim_proposals_proposals.decidim_component_id,
    components.ps_title
FROM
    {{ ref ("int_decidim_awesome_proposal_extra_fields")}} AS decidim_awesome_proposal_extra_fields
JOIN {{ ref ("stg_decidim_proposals")}} AS decidim_proposals_proposals ON decidim_awesome_proposal_extra_fields.proposal_id = decidim_proposals_proposals.id
JOIN {{ ref ("components")}} AS components ON decidim_proposals_proposals.decidim_component_id = components.id