SELECT
    id,
    user_moderation_id,
    user_id,
    reason,
    details,
    created_at,
    updated_at
FROM {{ source('decidim', 'decidim_user_reports') }}