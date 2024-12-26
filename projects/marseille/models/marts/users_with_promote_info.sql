WITH promote_actions AS (
    SELECT
        DISTINCT ON (users.id)
        users.id AS user_id,
        decidim_action_logs.id AS log_id,
        action
    FROM {{ ref('stg_decidim_action_logs') }} AS decidim_action_logs
    LEFT JOIN {{ ref('all_users') }} AS users ON users.id = decidim_action_logs.resource_id
        WHERE resource_type = 'Decidim::User'
        AND action = 'promote'
)

SELECT
    users.*,
    (CASE
        WHEN promote_actions.action IS NOT NULL AND users.managed = false THEN 'Confirmée'
        WHEN promote_actions.action IS NOT NULL AND users.managed = true THEN 'En attente'
        WHEN promote_actions.action IS NULL AND users.managed = false THEN 'Utilisateur non représenté'
        ELSE 'Non proposée'
    END) AS promotion_status
FROM {{ ref('all_users') }} AS users
LEFT JOIN promote_actions ON users.id = promote_actions.user_id