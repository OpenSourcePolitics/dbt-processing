SELECT
    id,
    resource_type,
    resource_id,
    decidim_author_type,
    decidim_author_id,
    decidim_user_group_id,
    created_at,
    updated_at
FROM {{ source('decidim', 'decidim_endorsements') }}
  