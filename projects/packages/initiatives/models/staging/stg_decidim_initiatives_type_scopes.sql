WITH source AS (
      SELECT * FROM {{ source('decidim', 'decidim_initiatives_type_scopes') }}
),
renamed AS (
    select
        id,
        decidim_initiatives_types_id,
        decidim_scopes_id,
        supports_required,
        created_at,
        updated_at
    FROM source
)
select * FROM renamed
  