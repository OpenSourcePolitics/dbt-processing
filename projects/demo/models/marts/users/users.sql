SELECT *
    FROM {{ ref('all_users') }} AS decidim_users
WHERE decidim_users.blocked != true
AND decidim_users.admin != true
AND decidim_users.confirmed = true