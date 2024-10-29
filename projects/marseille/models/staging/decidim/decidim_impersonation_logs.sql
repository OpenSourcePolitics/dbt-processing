WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_impersonation_logs') }}
)

SELECT
    id,
    decidim_user_id as user_id,
    reason,
    started_at,
    ended_at
FROM source
