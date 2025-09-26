SELECT
    id,
    decidim_moderation_id,
    decidim_user_id,
    reason,
    details,
    created_at,
    updated_at,
    locale
FROM {{ source('decidim', 'decidim_reports') }}