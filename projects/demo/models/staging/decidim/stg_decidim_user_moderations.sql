SELECT
    id,
    decidim_user_id,
    report_count,
    created_at,
    updated_at
FROM {{ source('decidim', 'decidim_user_moderations') }}
  