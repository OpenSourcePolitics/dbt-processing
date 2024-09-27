
  
    

  create  table "test_lyon"."prod"."blogs_posts__dbt_tmp"
  
  
    as
  
  (
    SELECT
    decidim_blogs_posts.id,
    decidim_blogs_posts.title,
    decidim_blogs_posts.body,
    decidim_blogs_posts.decidim_component_id,
    decidim_blogs_posts.created_at,
    decidim_blogs_posts.decidim_author_id,
    decidim_blogs_posts.resource_type,
    concat('https://', decidim_components.organization_host, '/', decidim_components.ps_space_type_slug, '/', decidim_components.ps_slug, '/f/', decidim_components.id, '/posts/', decidim_blogs_posts.id) AS post_url
FROM "test_lyon"."prod"."stg_decidim_blogs_posts" AS decidim_blogs_posts
JOIN "test_lyon"."prod"."components" AS decidim_components ON decidim_components.id = decidim_component_id
  );
  