
  
    

  create  table "test_lyon"."prod"."int_scopes__dbt_tmp"
  
  
    as
  
  (
    -- Due to ARRAY bug in test, we create an intermediate scopes without the column part_of

SELECT
    decidim_scopes.id,
    decidim_scopes.decidim_organization_id,
    decidim_scopes.created_at,
    decidim_scopes.updated_at,
    coalesce(nullif(decidim_scopes.name, ''), 'Sans secteur') as name,
    decidim_scopes.scope_type_id,
    decidim_scopes.parent_id,
    decidim_scopes.code
FROM "test_lyon"."prod"."stg_decidim_scopes"  as decidim_scopes
  );
  