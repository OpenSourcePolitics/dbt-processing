WITH source AS (
      SELECT * FROM "test_lyon"."public"."decidim_accountability_results"
),
renamed as (
    select
        id,
        title,
        description,
        reference,
        start_date,
        end_date,
        progress,
        parent_id,
        decidim_accountability_status_id,
        decidim_component_id,
        decidim_scope_id,
        created_at,
        updated_at,
        children_count,
        weight,
        external_id,
        comments_count
    FROM source
)
select * FROM renamed