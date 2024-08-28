WITH followings AS (
    SELECT DISTINCT
        decidim_user_id
    FROM {{ ref("followings")}}
),  participations_proposals AS (
        SELECT decidim_coauthorships.decidim_author_id
            FROM {{ ref("proposals")}} AS decidim_proposals_proposals
            JOIN {{ ref("stg_decidim_coauthorships")}} AS decidim_coauthorships ON decidim_coauthorships.coauthorable_id = decidim_proposals_proposals.id
            WHERE coauthorable_type = 'Decidim::Proposals::Proposal'
    ), participations AS (
    SELECT 
        decidim_users.id AS user_id,
        MAX(CASE WHEN decidim_endorsements.decidim_author_id IS NOT NULL THEN 1 ELSE 0 END) = 1 AS is_endorsing,
        MAX(CASE WHEN decidim_comments.decidim_author_id IS NOT NULL THEN 1 ELSE 0 END) = 1 AS has_authored_comment,
        MAX(CASE WHEN decidim_forms_answers.decidim_user_id IS NOT NULL THEN 1 ELSE 0 END) = 1 AS has_answered_survey,
        MAX(CASE WHEN decidim_proposals_proposal_votes.decidim_author_id IS NOT NULL THEN 1 ELSE 0 END) = 1 AS has_voted_on_proposal,
        MAX(CASE WHEN decidim_budgets_projects_votes.decidim_user_id IS NOT NULL THEN 1 ELSE 0 END) = 1 AS has_voted_on_project,
        MAX(CASE WHEN participations_proposals.decidim_author_id IS NOT NULL THEN 1 ELSE 0 END) = 1 AS has_authored_proposal  
    FROM {{ ref("int_users")}} AS decidim_users
        LEFT JOIN {{ ref("endorsements")}} AS decidim_endorsements ON decidim_users.id = decidim_endorsements.decidim_author_id
        LEFT JOIN {{ ref("comments")}} AS decidim_comments ON decidim_users.id = decidim_comments.decidim_author_id
        LEFT JOIN {{ ref("forms_answers")}} AS decidim_forms_answers ON decidim_users.id = decidim_forms_answers.decidim_user_id
        LEFT JOIN {{ ref("proposals_votes")}} AS decidim_proposals_proposal_votes ON decidim_users.id = decidim_proposals_proposal_votes.decidim_author_id
        LEFT JOIN {{ ref("projects_votes")}} AS decidim_budgets_projects_votes ON decidim_users.id = decidim_budgets_projects_votes.decidim_user_id
        LEFT JOIN participations_proposals ON decidim_users.id = participations_proposals.decidim_author_id
        GROUP BY decidim_users.id
)

SELECT 
    decidim_users.id,
    decidim_users.email,
    decidim_users.sign_in_count,
    decidim_users.sign_in_frequency,
    decidim_users.last_sign_in_at,
    decidim_users.created_at,
    decidim_users.updated_at,
    decidim_users.invitation_created_at,
    decidim_users.invitation_sent_at,
    decidim_users.invitation_accepted_at,
    decidim_users.invited_by_id,
    decidim_users.invited_by_type,
    decidim_users.decidim_organization_id,
    decidim_users.confirmed_at,
    decidim_users.confirmation_token,
    decidim_users.unconfirmed_email,
    decidim_users.name,
    decidim_users.locale,
    decidim_users.deleted_at,
    decidim_users.admin,
    decidim_users.managed,
    decidim_users.roles,
    -- decidim_users.email_on_notification,
    decidim_users.nickname,
    decidim_users.accepted_tos_version,
    decidim_users.type,
    decidim_users.following_count,
    decidim_users.followers_count,
    decidim_users.failed_attempts,
    decidim_users.locked_at,
    decidim_users.admin_terms_accepted_at,
    decidim_users.blocked,
    decidim_users.blocked_at,
    COALESCE(participations.is_endorsing, false) is_endorsing,
    (CASE WHEN followings.decidim_user_id IS NULL THEN false ELSE true END) AS is_following,
    COALESCE(participations.has_authored_comment, false) has_authored_comment,
    COALESCE(participations.has_voted_on_proposal, false) has_voted_on_proposal,
    COALESCE(participations.has_voted_on_project, false) has_voted_on_project,
    COALESCE(participations.has_authored_proposal, false) has_authored_proposal,
    COALESCE(participations.has_answered_survey, false) has_answered_survey,
    decidim_users.confirmed,
    concat('https://', decidim_organizations.host, '/profiles/', decidim_users.nickname, '/activity') as url,
    decidim_users.extended_data,
    decidim_users.date_of_birth
FROM {{ ref ("int_users")}} as decidim_users
LEFT JOIN followings on followings.decidim_user_id = decidim_users.id
LEFT JOIN participations ON participations.user_id = decidim_users.id
JOIN {{ ref ("int_organizations")}} as decidim_organizations on decidim_organizations.id = decidim_users.decidim_organization_id
WHERE true