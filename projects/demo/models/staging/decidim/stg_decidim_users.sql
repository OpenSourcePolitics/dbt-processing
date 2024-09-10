WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_users') }}
),
renamed AS (
    SELECT 
        id,
        email,
        sign_in_count,
        last_sign_in_at,
        created_at,
        updated_at,
        invitation_created_at,
        invitation_sent_at,
        invitation_accepted_at,
        invited_by_id,
        invited_by_type,
        decidim_organization_id,
        confirmed_at,
        confirmation_token,
        unconfirmed_email,
        name,
        locale,
        deleted_at,
        admin,
        managed,
        roles::text AS roles,
        nickname,
        accepted_tos_version,
        type,
        following_count,
        followers_count,
        failed_attempts,
        locked_at,
        admin_terms_accepted_at,
        blocked,
        blocked_at,
        (CASE WHEN confirmed_at IS NULL THEN false ELSE true END) AS "confirmed",
        extended_data
    FROM source
)
SELECT * FROM renamed
