WITH followings AS (
    SELECT DISTINCT
        decidim_user_id
    FROM {{ ref("followings")}}
), participations AS (
    SELECT
        user_id,
        MAX(CASE WHEN participation_type = 'Decidim::Endorsements::Endorsement' THEN 1 ELSE 0 END) = 1 AS is_endorsing,
        MAX(CASE WHEN participation_type = 'Decidim::Comments::Comment' THEN 1 ELSE 0 END) = 1 AS has_authored_comment,
        MAX(CASE WHEN participation_type = 'Decidim::Proposals::ProposalVote' OR participation_type = 'Decidim::Budgets::Project::Vote' THEN 1 ELSE 0 END) = 1 AS has_voted,
        MAX(CASE WHEN participation_type = 'Decidim::Proposals::Proposal' THEN 1 ELSE 0 END) = 1 AS has_authored_proposal,
        MAX(CASE WHEN participation_type = 'Decidim::Forms::Answer' THEN 1 ELSE 0 END) = 1 AS has_answered_survey
    FROM {{ ref("participations")}}
        GROUP BY user_id
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
    COALESCE(participations.has_voted, false) has_voted,
    COALESCE(participations.has_authored_proposal, false) has_authored_proposal,
    COALESCE(participations.has_answered_survey, false) has_answered_survey,
    decidim_users.confirmed,
    concat('https://', decidim_organizations.host, '/profiles/', decidim_users.nickname, '/activity') AS url,
    decidim_users.extended_data
FROM {{ ref ("int_users")}} as decidim_users
LEFT JOIN followings on followings.decidim_user_id = decidim_users.id
LEFT JOIN participations ON participations.user_id = decidim_users.id
JOIN {{ ref ("stg_decidim_organizations")}} as decidim_organizations on decidim_organizations.id = decidim_users.decidim_organization_id
WHERE true