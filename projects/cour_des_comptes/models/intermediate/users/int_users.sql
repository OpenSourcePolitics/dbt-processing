WITH users_with_date_of_birth AS (
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
    decidim_users.extended_data,
    decidim_users.extended_data::jsonb->>'date_of_birth' as date_of_birth
FROM {{ ref ("stg_decidim_users")}} as decidim_users
    WHERE deleted_at IS NULL
    AND type LIKE 'Decidim::User'
),

users_with_age AS (
SELECT
    *,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, DATE(users_with_date_of_birth.date_of_birth))) AS age
FROM users_with_date_of_birth
)

SELECT
    *,
    (CASE
        when age < 15 then '[0-15 ans]'
        when age >= 15 and age <= 19 then '[15-19 ans]'
        when age >= 20 and age <= 24 then '[20-24 ans]'
        when age >= 25 and age <= 29 then '[25-29 ans]'
        when age >= 30 and age <= 34 then '[30-34 ans]'
        when age >= 35 and age <= 39 then '[35-39 ans]'
        when age >= 40 and age <= 44 then '[40-44 ans]'
        when age >= 45 and age <= 49 then '[45-49 ans]'
        when age >= 50 and age <= 54 then '[50-54 ans]'
        when age >= 55 and age <= 59 then '[55-59 ans]'
        when age >= 60 and age <= 64 then '[60-64 ans]'
        when age >= 65 and age <= 69 then '[65-69 ans]'
        when age >= 70 and age <= 74 then '[70-74 ans]'
        when age >= 75 then '[75 ans ou plus]'
        else 'Âge non défini'
    end) as age_category
FROM users_with_age