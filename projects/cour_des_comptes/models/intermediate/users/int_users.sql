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

users_with_correct_age AS (
SELECT
    users_with_date_of_birth.id,
    users_with_date_of_birth.email,
    users_with_date_of_birth.sign_in_count,
    users_with_date_of_birth.sign_in_frequency,
    users_with_date_of_birth.last_sign_in_at,
    users_with_date_of_birth.created_at,
    users_with_date_of_birth.updated_at,
    users_with_date_of_birth.invitation_created_at,
    users_with_date_of_birth.invitation_sent_at,
    users_with_date_of_birth.invitation_accepted_at,
    users_with_date_of_birth.invited_by_id,
    users_with_date_of_birth.invited_by_type,
    users_with_date_of_birth.decidim_organization_id,
    users_with_date_of_birth.confirmed_at,
    users_with_date_of_birth.confirmation_token,
    users_with_date_of_birth.unconfirmed_email,
    users_with_date_of_birth.name,
    users_with_date_of_birth.locale,
    users_with_date_of_birth.deleted_at,
    users_with_date_of_birth.admin,
    users_with_date_of_birth.managed,
    users_with_date_of_birth.roles,
    users_with_date_of_birth.nickname,
    users_with_date_of_birth.accepted_tos_version,
    users_with_date_of_birth.type,
    users_with_date_of_birth.following_count,
    users_with_date_of_birth.followers_count,
    users_with_date_of_birth.failed_attempts,
    users_with_date_of_birth.locked_at,
    users_with_date_of_birth.admin_terms_accepted_at,
    users_with_date_of_birth.blocked,
    users_with_date_of_birth.blocked_at,
    users_with_date_of_birth.confirmed,
    users_with_date_of_birth.extended_data,
    (CASE WHEN date_of_birth > '1900-01-01' THEN date_of_birth ELSE NULL END) AS date_of_birth
FROM users_with_date_of_birth
    ),

users_with_age AS (
SELECT
    *,
    EXTRACT(YEAR FROM AGE({{ dbt_date.today() }}, DATE(users_with_correct_age.date_of_birth))) AS age
FROM users_with_correct_age
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