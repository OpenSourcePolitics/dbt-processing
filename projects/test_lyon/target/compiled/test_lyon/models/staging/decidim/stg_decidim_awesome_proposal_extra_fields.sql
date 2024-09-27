WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_awesome_proposal_extra_fields_test"
)

SELECT
    id,
    decidim_proposal_id AS proposal_id,
    updated_at,
    created_at,
    private_body_clear
FROM source