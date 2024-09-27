
  
    

  create  table "test_lyon"."prod"."debates__dbt_tmp"
  
  
    as
  
  (
    WITH categorizations AS (
    
    SELECT 
        array_agg(category_name) AS categories,
        array_agg(child_name) AS sub_categories,
        categorizable_id
    FROM "test_lyon"."prod"."categorizations" AS categorizations
    WHERE categorizations.categorizable_type = 'Decidim::Debates::Debate'
    GROUP BY categorizable_id 

)
SELECT
    decidim_debates_debates.id,
    decidim_debates_debates.title,
    decidim_debates_debates.description,
    decidim_debates_debates.start_time,
    decidim_debates_debates.end_time,
    decidim_debates_debates.decidim_component_id,
    decidim_debates_debates.decidim_author_id,
    decidim_debates_debates.created_at,
    decidim_debates_debates.closed_at,
    decidim_components.ps_slug,
    concat(
        'https://',
        decidim_components.organization_host,
        '/',
        decidim_components.ps_space_type_slug,
        '/',
        decidim_components.ps_slug,
        '/f/',
        decidim_components.id,
        '/debates/',
        decidim_debates_debates.id
    ) AS debate_url,
    decidim_debates_debates.resource_type,
    categorizations.categories,
    coalesce(categorizations.categories[1], 'Sans catégorie') AS first_category,
    categorizations.sub_categories,
    coalesce(categorizations.sub_categories[1], 'Sans sous-catégorie') AS first_sub_category
FROM "test_lyon"."prod"."stg_decidim_debates" AS decidim_debates_debates
    JOIN "test_lyon"."prod"."components" decidim_components on decidim_components.id = decidim_component_id
    LEFT JOIN categorizations on categorizations.categorizable_id = decidim_debates_debates.id
  );
  