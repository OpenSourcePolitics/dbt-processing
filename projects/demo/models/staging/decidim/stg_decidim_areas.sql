WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_areas') }}
),
renamed as (
    select
        id,
        name,
        area_type_id,
        decidim_organization_id,
        created_at,
        updated_at
    FROM source
)
select * FROM renamed
  