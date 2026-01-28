WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_accountability_results') }}
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
        {{ get_column_if_exists(source('decidim', 'decidim_accountability_results'), 'deleted_at', 'TIMESTAMP') }},
        children_count,
        weight,
        external_id,
        comments_count,
        {{ get_column_if_exists(source('decidim', 'decidim_accountability_results'), 'address', 'TEXT') }},
        {{ get_column_if_exists(source('decidim', 'decidim_accountability_results'), 'latitude', 'FLOAT') }},
        {{ get_column_if_exists(source('decidim', 'decidim_accountability_results'), 'longitude', 'FLOAT') }}
    FROM source
)
select * FROM renamed
  