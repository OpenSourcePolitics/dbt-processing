WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_organizations') }}
),
renamed AS (
    SELECT 
        id,
        name,
        host,
        default_locale,
        available_locales::text as available_locales,
        created_at,
        description,
        secondary_hosts::text as secondary_hosts,
        available_authorizations::text as available_authorizations,
        header_snippets,
        tos_version,
        badges_enabled,
        send_welcome_notification,
        users_registration_mode,
        time_zone
    FROM source
)
SELECT * FROM renamed
