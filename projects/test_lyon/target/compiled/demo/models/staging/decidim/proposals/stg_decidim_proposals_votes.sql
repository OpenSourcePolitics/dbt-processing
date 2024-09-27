WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_proposals_proposal_votes"
),
renamed AS (
    SELECT
        id,
        decidim_proposal_id,
        decidim_author_id,
        created_at,
        updated_at,
        weight,
        temporary
    FROM source
)
SELECT * FROM renamed