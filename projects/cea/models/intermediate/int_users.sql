SELECT 
    decidim_users.id,
    decidim_users.email,
    decidim_users.sign_in_count,
    (CASE
        WHEN decidim_users.sign_in_count = 0 THEN 'Jamais'
        WHEN decidim_users.sign_in_count = 1 THEN 'Une seule fois'
        WHEN decidim_users.sign_in_count = 2 THEN 'Deux fois'
        WHEN decidim_users.sign_in_count BETWEEN 2 AND 10 THEN 'Entre 2 et 10 fois'
        ELSE 'Plus de 10 fois'
        END
    ) AS sign_in_frequency,
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
    (CASE WHEN decidim_users.confirmed_at IS NULL THEN false ELSE true END) AS confirmed,
    decidim_users.extended_data
FROM {{ ref ("stg_decidim_users")}} AS decidim_users
    WHERE deleted_at IS NULL
    AND type LIKE 'Decidim::User'
