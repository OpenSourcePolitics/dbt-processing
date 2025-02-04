WITH endorsements AS (
    SELECT
        decidim_author_id,
        MAX(1) AS is_endorsing
    FROM {{ ref("endorsements") }}
    GROUP BY decidim_author_id
),

comments AS (
    SELECT
        decidim_author_id,
        MAX(1) AS has_authored_comment
    FROM {{ ref("comments") }}
    GROUP BY decidim_author_id
),

forms_answers AS (
    SELECT
        decidim_user_id,
        MAX(1) AS has_answered_survey
    FROM {{ ref("forms_answers") }}
    GROUP BY decidim_user_id
),

proposal_votes AS (
    SELECT
        decidim_author_id,
        MAX(1) AS has_voted_on_proposal
    FROM {{ ref("proposals_votes") }}
    GROUP BY decidim_author_id
),

project_votes AS (
    SELECT
        decidim_user_id,
        MAX(1) AS has_voted_on_project
    FROM {{ ref("projects_votes") }}
    GROUP BY decidim_user_id
),

participations_proposals AS (
    SELECT
        decidim_coauthorships.decidim_author_id,
        MAX(1) AS has_authored_proposal
    FROM {{ ref("proposals") }} AS decidim_proposals_proposals
    JOIN {{ ref("stg_decidim_coauthorships") }} AS decidim_coauthorships
        ON decidim_coauthorships.coauthorable_id = decidim_proposals_proposals.id
    WHERE coauthorable_type = 'Decidim::Proposals::Proposal'
    GROUP BY decidim_coauthorships.decidim_author_id
),

followings AS (
    SELECT DISTINCT decidim_user_id
    FROM {{ ref("followings") }}
)

SELECT
    decidim_users.id,
    decidim_users.email,
    decidim_users.sign_in_count,
    decidim_users.sign_in_frequency,
    decidim_users.current_sign_in_at,
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
    COALESCE(endorsements.is_endorsing, 0)::boolean AS is_endorsing,
    (CASE WHEN followings.decidim_user_id IS NULL THEN false ELSE true END) AS is_following,
    COALESCE(comments.has_authored_comment, 0)::boolean AS has_authored_comment,
    COALESCE(proposal_votes.has_voted_on_proposal, 0)::boolean AS has_voted_on_proposal,
    COALESCE(project_votes.has_voted_on_project, 0)::boolean AS has_voted_on_project,
    COALESCE(participations_proposals.has_authored_proposal, 0)::boolean AS has_authored_proposal,
    COALESCE(forms_answers.has_answered_survey, 0)::boolean AS has_answered_survey,
    decidim_users.confirmed,
    CONCAT('https://', decidim_organizations.host, '/profiles/', decidim_users.nickname, '/activity') AS url,
    decidim_users.spam,
    decidim_users.spam_probability,
    decidim_users.spam_reported_at,
    decidim_users.extended_data,
    decidim_users.date_of_birth,
    decidim_users.gender,
    decidim_users.postal_code,
    decidim_users.half_signup
FROM {{ ref("int_users") }} AS decidim_users
LEFT JOIN followings ON followings.decidim_user_id = decidim_users.id
LEFT JOIN endorsements ON endorsements.decidim_author_id = decidim_users.id
LEFT JOIN comments ON comments.decidim_author_id = decidim_users.id
LEFT JOIN forms_answers ON forms_answers.decidim_user_id = decidim_users.id
LEFT JOIN proposal_votes ON proposal_votes.decidim_author_id = decidim_users.id
LEFT JOIN project_votes ON project_votes.decidim_user_id = decidim_users.id
LEFT JOIN participations_proposals ON participations_proposals.decidim_author_id = decidim_users.id
JOIN {{ ref("int_organizations") }} AS decidim_organizations
ON decidim_organizations.id = decidim_users.decidim_organization_id
