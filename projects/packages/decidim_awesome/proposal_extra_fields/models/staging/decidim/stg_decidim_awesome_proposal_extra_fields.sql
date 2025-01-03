WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_awesome_proposal_extra_fields') }}
)


SELECT
    id,
    decidim_proposal_id AS proposal_id,
    updated_at,
    created_at,
    replace(decrypted_private_body, '&nbsp;', '') AS private_body
FROM source