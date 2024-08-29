WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_awesome_private_proposal_fields') }}
)

SELECT
    id,
    proposal_id,
    updated_at,
    created_at,
    private_body
FROM source