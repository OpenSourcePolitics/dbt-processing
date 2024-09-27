




WITH commentaries AS (
    
    SELECT
        comments.*, 
        "test_lyon"."prod"."stg_decidim_accountability_results".decidim_component_id AS "decidim_component_id"
    FROM "test_lyon"."prod"."stg_decidim_accountability_results"
    JOIN "test_lyon"."prod"."stg_decidim_comments" AS comments
        on comments.decidim_root_commentable_id = "test_lyon"."prod"."stg_decidim_accountability_results".id
        and comments.decidim_root_commentable_type = 'Decidim::Accountability::Result'
     union all 
    
    SELECT
        comments.*, 
        "test_lyon"."prod"."blogs_posts".decidim_component_id AS "decidim_component_id"
    FROM "test_lyon"."prod"."blogs_posts"
    JOIN "test_lyon"."prod"."stg_decidim_comments" AS comments
        on comments.decidim_root_commentable_id = "test_lyon"."prod"."blogs_posts".id
        and comments.decidim_root_commentable_type = 'Decidim::Blogs::Post'
     union all 
    
    SELECT
        comments.*, 
        "test_lyon"."prod"."budgets_projects".decidim_component_id AS "decidim_component_id"
    FROM "test_lyon"."prod"."budgets_projects"
    JOIN "test_lyon"."prod"."stg_decidim_comments" AS comments
        on comments.decidim_root_commentable_id = "test_lyon"."prod"."budgets_projects".id
        and comments.decidim_root_commentable_type = 'Decidim::Budgets::Project'
     union all 
    
    SELECT
        comments.*, 
        "test_lyon"."prod"."debates".decidim_component_id AS "decidim_component_id"
    FROM "test_lyon"."prod"."debates"
    JOIN "test_lyon"."prod"."stg_decidim_comments" AS comments
        on comments.decidim_root_commentable_id = "test_lyon"."prod"."debates".id
        and comments.decidim_root_commentable_type = 'Decidim::Debates::Debate'
     union all 
    
    SELECT
        comments.*, 
        "test_lyon"."prod"."meetings".decidim_component_id AS "decidim_component_id"
    FROM "test_lyon"."prod"."meetings"
    JOIN "test_lyon"."prod"."stg_decidim_comments" AS comments
        on comments.decidim_root_commentable_id = "test_lyon"."prod"."meetings".id
        and comments.decidim_root_commentable_type = 'Decidim::Meetings::Meeting'
     union all 
    
    SELECT
        comments.*, 
        "test_lyon"."prod"."proposals".decidim_component_id AS "decidim_component_id"
    FROM "test_lyon"."prod"."proposals"
    JOIN "test_lyon"."prod"."stg_decidim_comments" AS comments
        on comments.decidim_root_commentable_id = "test_lyon"."prod"."proposals".id
        and comments.decidim_root_commentable_type = 'Decidim::Proposals::Proposal'
     union all 
    
    SELECT
        comments.*, 
        "test_lyon"."prod"."stg_decidim_proposals_collaborative_drafts".decidim_component_id AS "decidim_component_id"
    FROM "test_lyon"."prod"."stg_decidim_proposals_collaborative_drafts"
    JOIN "test_lyon"."prod"."stg_decidim_comments" AS comments
        on comments.decidim_root_commentable_id = "test_lyon"."prod"."stg_decidim_proposals_collaborative_drafts".id
        and comments.decidim_root_commentable_type = 'Decidim::Proposals::CollaborativeDraft'
    
    
)

SELECT
    commentaries.id,
    commentaries.decidim_commentable_id,
    commentaries.decidim_commentable_type,
    commentaries.decidim_author_id,
    commentaries.created_at,
    commentaries.depth,
    commentaries.alignment,
    commentaries.decidim_root_commentable_id,
    commentaries.decidim_root_commentable_type,
    commentaries.decidim_author_type,
    commentaries.body,
    commentaries.decidim_component_id,
    components.ps_slug,
    concat('https://', components.organization_host, '/', components.ps_space_type_slug, '/', components.ps_slug, '/f/', components.id, '/', components.manifest_name,'/', commentaries.decidim_root_commentable_id, '?commentId=', commentaries.id, '#comment_', commentaries.id) AS comment_url
FROM commentaries
JOIN "test_lyon"."prod"."components" AS components
    on components.id = commentaries.decidim_component_id
LEFT JOIN "test_lyon"."prod"."stg_decidim_moderations" AS decidim_moderations
    on decidim_moderations.decidim_reportable_type = 'Decidim::Comments::Comment' 
    and decidim_moderations.decidim_reportable_id = commentaries.id
where decidim_moderations.hidden_at is null