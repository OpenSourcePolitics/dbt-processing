WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_awesome_proposal_extra_fields_test') }}
)


SELECT
    id,
    decidim_proposal_id AS proposal_id,
    updated_at,
    created_at,
    replace(private_body_clear, '&nbsp;', '') AS private_body_clear
FROM source