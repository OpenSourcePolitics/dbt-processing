
  
    

  create  table "test_lyon"."prod"."proposals_votes__dbt_tmp"
  
  
    as
  
  (
    

SELECT
    proposals_votes.id,
    proposals_votes.created_at,
    proposals_votes.decidim_author_id,
    proposals_votes.decidim_proposal_id,
    proposals.decidim_component_id,
    proposals.title AS proposal_title,
    proposals.url AS proposal_url
FROM "test_lyon"."prod"."stg_decidim_proposals_votes" AS proposals_votes
JOIN "test_lyon"."prod"."proposals" AS proposals on proposals_votes.decidim_proposal_id = proposals.id
  );
  