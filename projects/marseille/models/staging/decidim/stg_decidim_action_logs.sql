WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_action_logs') }}
)

SELECT
    id,
    created_at,
    updated_at,
    decidim_user_id,
    action,
    resource_type,
    resource_id
FROM source