
  
    

  create  table "test_lyon"."prod"."stg_decidim_proposals_collaborative_drafts__dbt_tmp"
  
  
    as
  
  (
    WITH source as (
      SELECT * FROM "test_lyon"."public"."decidim_proposals_collaborative_drafts"
),
renamed as (
    select
        id,
        title,
        body,
        decidim_component_id,
        decidim_scope_id,
        state,
        reference,
        address,
        latitude,
        longitude,
        published_at,
        authors_count,
        versions_count,
        contributions_count,
        created_at,
        updated_at,
        coauthorships_count,
        comments_count,
        follows_count

    from source
)
select * from renamed
  );
  