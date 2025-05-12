{{ config(
    indexes=[
      {'columns': ['id'], 'type': 'btree'},
    ]
)}}

{% set lang = var('DBT_LANG', 'fr') %}


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
FROM {{ ref ("stg_decidim_organizations")}}
    WHERE host = '{{ env_var('PARTICIPATION_HOST_NAME') }}'
    -- Assumption: There is only one organization, so we select the first available host
    LIMIT 1