
  
    

  create  table "test_lyon"."prod"."organizations__dbt_tmp"
  
  
    as
  
  (
    SELECT
*
FROM "test_lyon"."prod"."int_organizations" AS decidim_organizations
  );
  