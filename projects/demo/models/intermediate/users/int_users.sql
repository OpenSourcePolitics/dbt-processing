{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
    ]
)}}

WITH users_with_age AS (
    SELECT
        decidim_users.id,
        decidim_users.email,
        decidim_users.sign_in_count,
        {{ int_users_translate_sign_in_count('decidim_users.sign_in_count') }} AS sign_in_frequency,
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
        decidim_users.date_of_birth,
        {{ translate_gender('decidim_users.gender') }} AS gender,
        decidim_users.postal_code,
        (CASE WHEN decidim_users.confirmed_at IS NULL THEN false ELSE true END) AS confirmed, 
        (CASE WHEN decidim_users.spam_probability IS NULL THEN false ELSE true END) AS spam, 
        decidim_users.spam_probability,
        DATE(decidim_users.spam_report_timestamp) AS spam_reported_at,
        (CASE WHEN decidim_users.half_signup IS NULL THEN false ELSE true END) AS half_signup,
        decidim_users.extended_data,
        EXTRACT(YEAR FROM AGE({{ dbt_date.today() }}, DATE(decidim_users.date_of_birth))) AS age
    FROM {{ ref("stg_decidim_users") }} as decidim_users
    WHERE type LIKE 'Decidim::User'
)

SELECT
    *,
    {{ age_category('users_with_age.age') }} AS age_category
FROM users_with_age
