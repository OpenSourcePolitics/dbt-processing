{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
    ]
)}}

{% set lang = env_var('DBT_LANG', 'fr') %}

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
        COALESCE(regexp_replace(description::jsonb->>'{{ lang }}', E'(<[^>]+>)|(&[a-z]+;)', '', 'gi'), '') as description,
        secondary_hosts,
        available_authorizations,
        header_snippets,
        tos_version,
        badges_enabled,
        send_welcome_notification,
        users_registration_mode,
        time_zone
    FROM source
    WHERE host = '{{ env_var('PARTICIPATION_HOST_NAME') }}'
    -- Assumption: There is only one organization, so we select the first available host
    LIMIT 1
)
SELECT * FROM renamed
