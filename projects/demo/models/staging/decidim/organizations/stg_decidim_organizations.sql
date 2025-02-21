{% set lang = var('DBT_LANG', 'fr') %}

WITH source AS (
    SELECT * FROM {{ source('decidim', 'decidim_organizations') }}
),
renamed AS (
    SELECT
        id,
        {{ get_name_column(lang) }},
        host,
        default_locale,
        available_locales::text AS available_locales,
        created_at,
        description,
        secondary_hosts::text AS secondary_hosts,
        available_authorizations::text AS available_authorizations,
        header_snippets,
        tos_version,
        badges_enabled,
        send_welcome_notification,
        users_registration_mode,
        time_zone
    FROM source
)
SELECT * FROM renamed
