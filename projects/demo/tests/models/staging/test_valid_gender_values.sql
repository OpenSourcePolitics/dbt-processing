SELECT
    id,
    gender
FROM {{ ref('stg_decidim_users') }}
WHERE gender IS NOT NULL
AND gender NOT IN ('male', 'female', 'other')
