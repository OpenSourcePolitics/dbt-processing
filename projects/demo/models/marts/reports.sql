SELECT
    id,
    decidim_moderation_id,
    decidim_user_id,
    reason,
    details,
    created_at,
    updated_at,
    locale,
    (CASE WHEN details = 'AI system marked this as spam' THEN true ELSE false END) AS ai_reported
FROM {{ ref("stg_decidim_reports") }}