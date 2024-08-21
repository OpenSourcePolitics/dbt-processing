WITH endorsements_proposals AS (
    SELECT
        decidim_endorsements.*,
        decidim_component_id
    FROM {{ ref("stg_decidim_endorsements")}} AS decidim_endorsements
        JOIN {{ ref("stg_decidim_proposals")}} decidim_proposals_proposals on decidim_endorsements.resource_id = decidim_proposals_proposals.id
        and decidim_proposals_proposals.resource_type = decidim_endorsements.resource_type
), endorsements_debates AS (
    SELECT
        decidim_endorsements.*,
        decidim_component_id
    FROM {{ ref("stg_decidim_endorsements")}} AS decidim_endorsements
        JOIN {{ ref("stg_decidim_debates")}} AS decidim_debates_debates on decidim_endorsements.resource_id = decidim_debates_debates.id
        and decidim_debates_debates.resource_type = decidim_endorsements.resource_type
), endorsements_blogs_posts AS (
    SELECT
        decidim_endorsements.*,
        decidim_component_id
    FROM {{ ref("stg_decidim_endorsements")}} AS decidim_endorsements
        JOIN {{ ref("stg_decidim_blogs_posts")}} AS decidim_blogs_posts on decidim_endorsements.resource_id = decidim_blogs_posts.id
        and decidim_blogs_posts.resource_type = decidim_endorsements.resource_type
), endorsements as (
    SELECT * FROM endorsements_proposals union all
    SELECT * FROM endorsements_debates union all
    SELECT * FROM endorsements_blogs_posts
)
SELECT
          endorsements.id,
          endorsements.resource_type,
          endorsements.resource_id,
          endorsements.decidim_author_type,
          endorsements.decidim_author_id,
          endorsements.created_at,
          endorsements.updated_at,
          endorsements.decidim_component_id
      FROM endorsements
          LEFT JOIN {{ ref("stg_decidim_moderations")}} as decidim_moderations
              on decidim_moderations.decidim_reportable_type = endorsements.resource_type
              and decidim_moderations.decidim_reportable_id = endorsements.resource_id
      where decidim_moderations.hidden_at is null