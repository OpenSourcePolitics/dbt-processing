WITH source AS (
      SELECT * FROM {{ ref ("stg_decidim_organizations")}}
),
renamed AS (
    SELECT
        id,
        name,
        host,
        default_locale,
        available_locales,
        created_at,
        regexp_replace(description::jsonb->>'fr', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi') as description,
        secondary_hosts,
        available_authorizations,
        header_snippets,
        tos_version,
        badges_enabled,
        send_welcome_notification,
        users_registration_mode,
        time_zone
    FROM source
    WHERE host = '{{ var('host') }}'
)
SELECT * FROM renamed
