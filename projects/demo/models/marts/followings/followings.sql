{{ config(
    indexes=[
      {'columns': ['decidim_user_id'], 'type': 'btree'},
    ]
)}}


WITH followings_proposals AS (
    SELECT
        decidim_follows.*,
        decidim_proposals_proposals.decidim_component_id,
        url AS followable_url,
        title AS followable_title
    FROM {{ ref("stg_decidim_follows")}} AS decidim_follows
    JOIN {{ ref("proposals")}} decidim_proposals_proposals
        ON decidim_proposals_proposals.id = decidim_follows.decidim_followable_id
        AND decidim_proposals_proposals.resource_type = decidim_follows.decidim_followable_type
    ), followings_components AS (
    SELECT
        distinct decidim_follows.*,
        -1 AS "decidim_components.id",
        ps_url AS followable_url,
        ps_title AS followable_title
    FROM {{ ref("stg_decidim_follows")}} AS decidim_follows
    JOIN {{ ref("components")}} decidim_components
        ON decidim_components.ps_id = decidim_followable_id
        AND ps_type = decidim_followable_type
    ), followings_debates AS (
    SELECT
        decidim_follows.*,
        decidim_debates_debates.decidim_component_id,
        debate_url AS followable_url,
        title AS followable_title
    FROM {{ ref("stg_decidim_follows")}} AS decidim_follows
        JOIN {{ ref("debates")}} decidim_debates_debates ON decidim_debates_debates.id = decidim_followable_id
            AND resource_type =  decidim_followable_type
    ), followings_blogs_posts AS (
    SELECT
        decidim_follows.*,
        decidim_blogs_posts.decidim_component_id,
        post_url AS followable_url,
        title AS followable_title
    FROM {{ ref("stg_decidim_follows")}} AS decidim_follows
        JOIN {{ ref("blogs_posts")}} decidim_blogs_posts
            ON decidim_blogs_posts.id = decidim_followable_id
            AND resource_type = decidim_followable_type
    ), followings_users AS (
    SELECT
        decidim_follows.*,
        -1 AS decidim_component_id,
        '' AS followable_url,
        '' AS followable_title
    FROM {{ ref("stg_decidim_follows")}} AS decidim_follows
        JOIN {{ ref("int_users")}} decidim_users
            ON decidim_users.id = decidim_followable_id
    where decidim_followable_type = 'Decidim::UserBaseEntity'
    ), followings_meetings AS (
    SELECT
        decidim_follows.*,
        decidim_component_id,
        meeting_url AS followable_url,
        title AS followable_title
    FROM {{ ref("stg_decidim_follows")}} AS decidim_follows
        JOIN {{ ref("meetings")}} decidim_meetings
            ON decidim_meetings.id = decidim_followable_id
            AND resource_type = decidim_followable_type
    ), followings_budgets_projects AS (
    SELECT
        decidim_follows.*,
        decidim_component_id,
        project_url AS followable_url,
        title AS followable_title
    FROM {{ ref("stg_decidim_follows")}} AS decidim_follows
        join {{ ref("budgets_projects")}} decidim_budgets_projects
            ON decidim_budgets_projects.id = decidim_followable_id
            AND resource_type = decidim_followable_type
    ), followings AS (
    SELECT * FROM followings_proposals union all
    SELECT * FROM followings_components union all
    SELECT * FROM followings_debates union all
    SELECT * FROM followings_blogs_posts union all
    SELECT * FROM followings_users union all
    SELECT * FROM followings_meetings union all
    SELECT * FROM followings_budgets_projects
    ), real_follow AS (
    SELECT
        followings.*,
        'real_follow' AS "following_way",
        decidim_followable_id AS "root_decidim_followable_id",
        decidim_followable_type AS "root_decidim_followable_type",
        followable_url AS "root_following_url",
        followable_title AS "root_followable_title"
    FROM followings,
        lateral (SELECT (case array_length(array_remove(string_to_array(decidim_followable_type, ':', ''),null),1) when 2 then 'Ancestor' else 'Child' end) AS followable_meta_type) p_is_ps
    where followable_meta_type != 'Ancestor'
    ), ancestor_follow AS (
        SELECT
            distinct
            followings.*,
            'ancestor_follow' AS "following_way",
            real_follow.decidim_followable_id AS "root_decidim_followable_id",
            real_follow.decidim_followable_type AS "root_decidim_followable_type",
            real_follow.followable_url AS "root_following_url",
            real_follow.followable_title AS "root_followable_title"
        FROM real_follow
            join {{ ref("components")}} AS components ON components.id = real_follow.decidim_component_id
            join followings ON followings.decidim_followable_id = components.ps_id AND followings.decidim_followable_type = components.ps_type
    ), follows AS (
          SELECT * FROM real_follow union all
          SELECT * FROM ancestor_follow
      )
SELECT id,
    decidim_component_id,
    decidim_user_id,
    root_decidim_followable_id,
    root_decidim_followable_type,
    root_followable_title,
    created_at,
    root_following_url,
    decidim_followable_id,
    decidim_followable_type,
    followable_url,
    following_way
FROM follows