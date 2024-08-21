WITH followings_proposals AS (
    SELECT
        decidim_follows.*,
        decidim_proposals_proposals.decidim_component_id,
        url AS followable_url,
        title AS followable_title
    FROM {{ ref("stg_decidim_follows")}} AS decidim_follows
        JOIN {{ ref("proposals")}} decidim_proposals_proposals
            on decidim_proposals_proposals.id = decidim_followable_id
            and resource_type = decidim_followable_type
    ), followings_components as (
    SELECT
        distinct decidim_follows.*,
        -1 as "decidim_components.id",
        ps_url as followable_url,
        ps_title as followable_title
    FROM {{ ref("stg_decidim_follows")}} as decidim_follows
        JOIN {{ ref("components")}} decidim_components
            on decidim_components.ps_id = decidim_followable_id
            and ps_type = decidim_followable_type
    ), followings_debates as (
    SELECT
        decidim_follows.*,
        decidim_debates_debates.decidim_component_id,
        debate_url as followable_url,
        title as followable_title
    FROM {{ ref("stg_decidim_follows")}} as decidim_follows
        JOIN {{ ref("debates")}} decidim_debates_debates on decidim_debates_debates.id = decidim_followable_id
            and resource_type =  decidim_followable_type
    ), followings_blogs_posts as (
    SELECT
        decidim_follows.*,
        decidim_blogs_posts.decidim_component_id,
        post_url as followable_url,
        title as followable_title
    FROM {{ ref("stg_decidim_follows")}} as decidim_follows
        JOIN {{ ref("blogs_posts")}} decidim_blogs_posts
            on decidim_blogs_posts.id = decidim_followable_id
            and resource_type = decidim_followable_type
    ), followings_users as (
    SELECT
        decidim_follows.*,
        -1 as decidim_component_id,
        '' as followable_url,
        '' as followable_title
    FROM {{ ref("stg_decidim_follows")}} as decidim_follows
        JOIN {{ ref("int_users")}} decidim_users
            on decidim_users.id = decidim_followable_id
    where decidim_followable_type = 'Decidim::UserBaseEntity'
    ), followings_meetings as (
    SELECT
        decidim_follows.*,
        decidim_component_id,
        meeting_url as followable_url,
        title as followable_title
    from {{ ref("stg_decidim_follows")}} as decidim_follows
        JOIN {{ ref("meetings")}} decidim_meetings
            on decidim_meetings.id = decidim_followable_id
            and resource_type = decidim_followable_type
    ), followings_budgets_projects as (
    SELECT
        decidim_follows.*,
        decidim_component_id,
        project_url as followable_url,
        title as followable_title
    from {{ ref("stg_decidim_follows")}} as decidim_follows
        join {{ ref("budgets_projects")}} decidim_budgets_projects
            on decidim_budgets_projects.id = decidim_followable_id
            and resource_type = decidim_followable_type
    ), followings as (
    SELECT * from followings_proposals union all
    SELECT * from followings_components union all
    SELECT * from followings_debates union all
    SELECT * from followings_blogs_posts union all
    SELECT * from followings_users union all
    SELECT * from followings_meetings union all
    SELECT * from followings_budgets_projects
    ), real_follow as (
    SELECT
        followings.*,
        'real_follow' as "following_way",
        decidim_followable_id as "root_decidim_followable_id",
        decidim_followable_type as "root_decidim_followable_type",
        followable_url as "root_following_url",
        followable_title as "root_followable_title"
    from followings,
        lateral (SELECT (case array_length(array_remove(string_to_array(decidim_followable_type, ':', ''),null),1) when 2 then 'Ancestor' else 'Child' end) as followable_meta_type) p_is_ps
    where followable_meta_type != 'Ancestor'
    ), ancestor_follow as (
        SELECT
            distinct
            followings.*,
            'ancestor_follow' as "following_way",
            real_follow.decidim_followable_id as "root_decidim_followable_id",
            real_follow.decidim_followable_type as "root_decidim_followable_type",
            real_follow.followable_url as "root_following_url",
            real_follow.followable_title as "root_followable_title"
        from real_follow
            join {{ ref("components")}} as components on components.id = real_follow.decidim_component_id
            join followings on followings.decidim_followable_id = components.ps_id and followings.decidim_followable_type = components.ps_type
    ), follows as (
          select * from real_follow union all
          select * from ancestor_follow
      )
select id,
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
from follows